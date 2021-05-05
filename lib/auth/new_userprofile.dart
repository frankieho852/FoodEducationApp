import 'dart:io';
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_education_app/constants.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path_provider/path_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:camera/camera.dart';


class newUserProfilePage extends StatefulWidget {
  static String tag = 'newuserprofile-page';
  final VoidCallback logOutBtn;
  final VoidCallback showFoodEducation;

  newUserProfilePage({Key key, this.logOutBtn, this.showFoodEducation})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _newUserProfilePageState();
}

//  todo: new user page UI
class _newUserProfilePageState extends State<newUserProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _nicknameController = TextEditingController();
  final _ageController = TextEditingController();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();

  final FocusNode _nicknameFocus = FocusNode();
  final FocusNode _ageFocus = FocusNode();
  final FocusNode _heightFocus = FocusNode();
  final FocusNode _weightFocus = FocusNode();

  String _genderRadioBtnVal = "";

  List<Asset> images = <Asset>[];
  List<String> imageUrls = <String>[];

  final _formKeyUserProfile = GlobalKey<FormState>();

  // bool _showBottomSheet = false;
  bool _loading = false;

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leading: new IconButton(
            color: Colors.grey[700],
            icon: new Icon(Icons.arrow_back),
            splashRadius: 24,
            onPressed: widget.logOutBtn),
      ),
      body: SafeArea(
        minimum: EdgeInsets.symmetric(horizontal: 40),
        child: _loading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(child: _userProfileForm()),
      ),
      // bottomSheet: _showBottomSheet? _bottomSheet() : null
    );
  }

  Widget _userProfileForm() {
    Size size = MediaQuery.of(context).size;
    return Form(
        key: _formKeyUserProfile,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Create User Profile"),
            GestureDetector(
                onTap: () {
                  loadAssets();
                  //_bottomSheet(context);
                  //do what you want here
                },
                child: images.length == 0 ? CircleAvatar(
                  backgroundImage:
                  AssetImage("assets/icons/default_user_icon.jpg"),
                  backgroundColor: Colors.transparent,
                  radius: 60.0,
                ) : buildGridView()
            ),
            _formField(TextFormField(
                controller: _nicknameController,
                textInputAction: TextInputAction.next,
                decoration: _decoration(Icon(Icons.account_circle), 'Nickname'),
                focusNode: _nicknameFocus,
                onFieldSubmitted: (term) {
                  FocusScope.of(context).requestFocus(_ageFocus);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your nickname';
                  }
                  return null;
                })),
            _formField(TextFormField(
                controller: _ageController,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                decoration: _decoration(Icon(Icons.account_circle), 'Age'),
                focusNode: _ageFocus,
                onFieldSubmitted: (term) {
                  FocusScope.of(context).requestFocus(_heightFocus);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your age';
                  }
                  return null;
                })),
            _formField(TextFormField(
                controller: _heightController,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    icon: Icon(Icons.height), labelText: 'Height (Unit of CM)'),
                focusNode: _heightFocus,
                onFieldSubmitted: (term) {
                  FocusScope.of(context).requestFocus(_weightFocus);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your height';
                  }
                  return null;
                })),
            _formField(TextFormField(
                controller: _weightController,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    icon: Icon(Icons.account_circle),
                    labelText: 'Weight (Unit of KG)'),
                focusNode: _weightFocus,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your weight';
                  }
                  return null;
                })),
            Row(
              children: <Widget>[
                Radio<String>(
                  value: "Male",
                  groupValue: _genderRadioBtnVal,
                  onChanged: _handleGenderChange,
                ),
                Text("Male"),
                Radio<String>(
                  value: "Female",
                  groupValue: _genderRadioBtnVal,
                  onChanged: _handleGenderChange,
                ),
                Text("Female"),
              ],
            ),
            Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                width: size.width * 0.9,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(29),
                    child: TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 40),
                          backgroundColor: Colors.blue,
                        ),
                        onPressed: () {
                          if (_formKeyUserProfile.currentState.validate()) {
                            _submitProfile();
                            // loginPageLogic.emailLogin(email, password);
                          }
                        },
                        child: Text(
                          'Next',
                          style: TextStyle(color: Colors.white),
                        )))),
          ],
        ));
  }

  InputDecoration _decoration(Icon icon, String labelText) {
    return InputDecoration(
      icon: icon,
      labelText: labelText,
      hintStyle: TextStyle(
        color: kPrimaryColor,
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: kPrimaryColor),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: kPrimaryColor),
      ),
      border: UnderlineInputBorder(
        borderSide: BorderSide(color: kPrimaryColor),
      ),
    );
  }

  Container _formField(TextFormField formField) {
    Size size = MediaQuery.of(context).size;
    return Container(
        decoration: BoxDecoration(
          color: kPrimaryColor.withAlpha(100),
          borderRadius: BorderRadius.circular(29.0),
        ),
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        width: size.width * 0.9,
        child: formField);
  }

  void _showErrorDialog(String title, String content) {
    showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: <Widget>[
              TextButton(
                child: Text('Retry'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }


  Future<void> _submitProfile() async {
    final nickname = _nicknameController.text.trim();
    final age = _ageController.text.trim();
    final height = _heightController.text.trim();
    final weight = _weightController.text.trim();

    try {
      setState(() {
        _loading = true;
      });
      User user = FirebaseAuth.instance.currentUser;
      if(images.length==0){
        await FirebaseFirestore.instance
            .collection('userProfile')
            .doc(user.uid)
            .set({
          'name': nickname,
          'age': double.parse(age),
          'height': double.parse(height),
          'weight': double.parse(weight),
          'sex': _genderRadioBtnVal,
          'coupon': 0,
          'completedProfile': true,
          'iconURL': "https://firebasestorage.googleapis.com/v0/b/food-education-383e1.appspot.com/o/Usericon%2Fdefault_user_icon.jpg?alt=media&token=b864d2b9-368f-413d-8e31-8729c5e33d91"
        });

      }
      else{
        //uploadImages();

        for (var imageFile in images) {
          postImage(imageFile).then((downloadUrl) async {
            imageUrls.add(downloadUrl.toString());
            if (imageUrls.length == images.length) {


              await FirebaseFirestore.instance
                  .collection('userProfile')
                  .doc(user.uid)
                  .set({
                'name': nickname,
                'age': double.parse(age),
                'height': double.parse(height),
                'weight': double.parse(weight),
                'sex': _genderRadioBtnVal,
                'coupon': 0,
                'completedProfile': true,
                'iconURL': imageUrls[0]
              }).then((_) {
                setState(() {
                  images = [];
                  imageUrls = [];
                });
              });
            }
          }).catchError((err) {
            print(err);
          });
        }
      }

      /*
      User user = FirebaseAuth.instance.currentUser;
      await FirebaseFirestore.instance
          .collection('userProfile')
          .doc(user.uid)
          .set({
        'name': nickname,
        'age': age,
        'height': height,
        'weight': weight,
        'sex': _genderRadioBtnVal,
        'coupon': 0,
        'completedProfile': true
      }).then((userInfoValue) {});
       */

      // user.updateProfile(displayName: nickname, photoURL: null);
      widget.showFoodEducation();
    } catch (e) {
      _showErrorDialog(
          "Error", "Error code: ${e.code}\nError message: ${e.message}");
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  void _handleGenderChange(String value) {
    setState(() {
      _genderRadioBtnVal = value;
    });
  }

  void _chooseProfileAvatar() {}

  Widget buildGridView() {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 1,
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        return Padding(
          padding: EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            child: AssetThumb(
              asset: asset,
              width: 300,
              height: 300,
              quality: 100,

            ),
          ),
        );
      }),
    );
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = <Asset>[];
    String error = 'No Error Dectected';
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 1,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          //actionBarColor: "#abcdef",
          actionBarTitle: "Select Image",
          allViewTitle: "All Photos",
          useDetailsView: false,
          //selectCircleStrokeColor: "#000000",
        ),
      );


    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
    setState(() {
      images = resultList;
    });
  }

  Future<dynamic> postImage(Asset imageFile) async {
    User user = FirebaseAuth.instance.currentUser;
    firebase_storage.FirebaseStorage.instance.ref('userProfile').child(user.uid).child('icon');
    firebase_storage.Reference reference = firebase_storage.FirebaseStorage.instance.ref('Usericon').child(user.uid).child('icon');
    firebase_storage.UploadTask uploadTask = reference.putData((await imageFile.getByteData()).buffer.asUint8List());
    var imageUrl = await (await uploadTask).ref.getDownloadURL();
    var url = imageUrl.toString();
    return imageUrl;
  }


  void uploadImages(){
    for (var imageFile in images) {
      postImage(imageFile).then((downloadUrl) {
        imageUrls.add(downloadUrl.toString());
        if (imageUrls.length == images.length) {
          User user = FirebaseAuth.instance.currentUser;



          //FirebaseFirestore.instance.collection('Usericon').doc(user.uid).set(
          FirebaseFirestore.instance.collection('userProfile').doc(user.uid).update(
              {
                'iconURL': imageUrls
              }).then((_) {
            setState(() {
              images = [];
              imageUrls = [];
            });
          });
        }
      }).catchError((err) {
        print(err);
      });
    }

  }



}
