import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class newUserProfilePage extends StatefulWidget {

  final VoidCallback logOutBtn;
  final VoidCallback showFoodEducation;

  newUserProfilePage({Key key, this.logOutBtn, this.showFoodEducation}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _newUserProfilePageState();
}

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
          onPressed: widget.logOutBtn
        ),
      ),


      body: SafeArea(
        minimum: EdgeInsets.symmetric(horizontal: 40),
        child: _userProfileForm(),
      ),
    );
  }

  Widget _userProfileForm() {
    return Form(
        key: _formKeyUserProfile,
        child: _loading? Center(
            child: CircularProgressIndicator()
        ):Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Title: User Profile"),
            TextFormField(
                controller: _nicknameController,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    icon: Icon(Icons.account_circle), labelText: 'Nickname'),
                focusNode: _nicknameFocus,
                onFieldSubmitted: (term) {
                  FocusScope.of(context).requestFocus(_ageFocus);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your nickname';
                  }
                  return null;
                }),
            TextFormField(
                controller: _ageController,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    icon: Icon(Icons.account_circle), labelText: 'Age'),
                focusNode: _ageFocus,
                onFieldSubmitted: (term) {
                  FocusScope.of(context).requestFocus(_heightFocus);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your age';
                  }
                  return null;
                }),
            TextFormField(
                controller: _heightController,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    icon: Icon(Icons.account_circle),
                    labelText: 'Height (Unit of CM)'),
                focusNode: _heightFocus,
                onFieldSubmitted: (term) {
                  FocusScope.of(context).requestFocus(_weightFocus);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your height';
                  }
                  return null;
                }),
            TextFormField(
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
                }),
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
            FlatButton(
                onPressed: () {
                  if (_formKeyUserProfile.currentState.validate()) {

                    final nickname = _nicknameController.text.trim();
                    final age = _ageController.text.trim();
                    final height = _heightController.text.trim();
                    final weight = _weightController.text.trim();

                    try {
                      setState(() {
                        _loading = true;
                      });

                      User user = FirebaseAuth.instance.currentUser;
                      FirebaseFirestore.instance
                          .collection('userprofile')
                          .doc(user.uid)
                          .set({
                        'nickname': nickname,
                        'age': age,
                        'height': height,
                        'weight': weight,
                        'sex': _genderRadioBtnVal,
                        'done': true
                      }).then((userInfoValue) {});
                      user.updateProfile(displayName: nickname, photoURL: null);
                      widget.showFoodEducation();
                    } catch (e){
                      showDialog<void>(
                          context: context,
                          barrierDismissible: false, // user must tap button!
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Error"),
                              content: Text(e.toString()),
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
                    } finally{
                      setState(() {
                        _loading = false;
                      });
                    }
                  }
                },
                child: Text("Next"),
                color: Theme.of(context).accentColor),
          ],
        ));
  }

  void _handleGenderChange(String value) {
    setState(() {
      _genderRadioBtnVal = value;
    });
  }
}
