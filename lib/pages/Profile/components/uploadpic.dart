import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:multi_image_picker/multi_image_picker.dart';


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
    String name="";//todo:get current uid
    Reference firebaseStorageRef =
    FirebaseStorage.instance.ref().child('userIcon/' + name);
    UploadTask uploadTask = firebaseStorageRef.putData(imageData);
    //UploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
    TaskSnapshot taskSnapshot = await uploadTask;
    //String downloadURL = await FirebaseStorage.instance.ref('productImage/'+name).getDownloadURL(); this is working too
    String downloadURL = await taskSnapshot.ref.getDownloadURL();
    print(downloadURL);
    FirebaseFirestore.instance
        .collection('userProfile')
        .doc("temp")
        .set({
      'iconUrl': downloadURL,
    })
        .then((value) => print("Uploaded"))
        .catchError((onError) => print("Failed:" + onError));
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
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: <Widget>[
            Center(child: Text('Error: $_error')),
            ElevatedButton(
              child: Text("Pick images"),
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
      ),
    );
  }
}