import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_education_app/constants.dart';

class newUserProfilePage extends StatefulWidget {
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

  final _formKeyUserProfile = GlobalKey<FormState>();

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
    );
  }

  Widget _userProfileForm() {
    return Form(
        key: _formKeyUserProfile,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Create User Profile"),
            GestureDetector(
              onTap: () {
                _chooseProfileAvatar();
                //do what you want here
              },
              child: CircleAvatar(
                backgroundImage:
                    AssetImage("assets/icons/default-user-icon.jpg"),
                backgroundColor: Colors.transparent,
                radius: 60.0,
              ),
            ),
            CircleAvatar(
              backgroundImage:
              AssetImage("assets/icons/default_avatar_free_icon.png"),//assets/icons/default-user-icon.jpg"
              backgroundColor: Colors.transparent,
              radius: 60.0,
            ),
            CircularProfileAvatar(
              "https://firebasestorage.googleapis.com/v0/b/food-education-383e1.appspot.com/o/default_avatar_free_icon.svg?alt=media&token=a0e4f329-b236-4930-b5bf-838d86c9ada0",
              //"assets/images/bread.jpg"
              borderWidth: 4,
              radius: 100.0,
              elevation: 8,
              animateFromOldImageOnUrlChange: true,
              onTap: _chooseProfileAvatar,
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
            TextButton(
              onPressed: () {
                if (_formKeyUserProfile.currentState.validate()) {
                  _submitProfile();
                }
              },
              child: Text("Next"),
              // color: Theme.of(context).accentColor),
            )
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

  void _submitProfile() {
    final nickname = _nicknameController.text.trim();
    final age = _ageController.text.trim();
    final height = _heightController.text.trim();
    final weight = _weightController.text.trim();

    try {
      setState(() {
        _loading = true;
      });

      User user = FirebaseAuth.instance.currentUser;
      FirebaseFirestore.instance.collection('userProfile').doc(user.uid).set({
        'name': nickname,
        'age': age,
        'height': height,
        'weight': weight,
        'sex': _genderRadioBtnVal,
        'coupon': 0,
        'completedProfile': true
      }).then((userInfoValue) {});
      user.updateProfile(displayName: nickname, photoURL: null);
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
}
