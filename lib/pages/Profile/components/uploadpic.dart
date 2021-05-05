import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_education_app/constants.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UploadPic extends StatefulWidget {
  @override
  _UploadPicState createState() => _UploadPicState();
}

class _UploadPicState extends State<UploadPic> {
  List<Asset> images = <Asset>[];
  String _error = 'No Error Dectected';

  @override
  void initState() {
    super.initState();
  }

  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        return AssetThumb(
          asset: asset,
          width: 300,
          height: 300,
        );
      }),
    );
  }
  Future<String> uploadIcon() async {
    var  byteData = await images[0].requestOriginal();
    List<int> imageData = byteData.buffer.asUint8List();
    final User _user = FirebaseAuth.instance.currentUser;
    String name= _user.uid;
    Reference firebaseStorageRef =
    FirebaseStorage.instance.ref().child('Usericon/' + name);
    UploadTask uploadTask = firebaseStorageRef.putData(imageData);
    //UploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
    TaskSnapshot taskSnapshot = await uploadTask;
    //String downloadURL = await FirebaseStorage.instance.ref('productImage/'+name).getDownloadURL(); this is working too
    String downloadURL = await taskSnapshot.ref.getDownloadURL();
    print(downloadURL);
    FirebaseFirestore.instance
        .collection('userProfile')
        .doc(name)
        .update({

      'iconURL': downloadURL,
    })
        .then((value) => print("Uploaded"))
        .catchError((onError) => print("Failed:" + onError));
    Navigator.of(context).popUntil((route) => route.isFirst);
  }
  Future<void> loadAssets() async {
    List<Asset> resultList = <Asset>[];
    String error = 'No Error Detected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Example App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
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
      _error = error;
    });
  }
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Choose an image'),
        ),
        body: Column(
          children: <Widget>[
            ElevatedButton(
              child: Text("Pick an image"),
              onPressed: loadAssets,
            ),
            Expanded(
              child: buildGridView(),
            ),
            ElevatedButton(
              child: Text("Upload User Icon"),
              onPressed: uploadIcon,
            ),
          ],
        ),
      );
  }
}