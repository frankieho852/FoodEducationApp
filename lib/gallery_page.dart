import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// testing page only
class GalleryPage extends StatelessWidget {

  final VoidCallback shouldLogOut;
  final VoidCallback shouldShowCamera;
  final imageUrlsController;

  GalleryPage({Key key, this.imageUrlsController, this.shouldLogOut, this.shouldShowCamera})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gallery'),
        actions: [
          // Log Out Button
          Padding(
            padding: const EdgeInsets.all(8),
            child:
            GestureDetector(child: Icon(Icons.logout), onTap: shouldLogOut),
          )
        ],
      ),

      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.camera_alt), onPressed: shouldShowCamera),
      body: Container(child: _galleryGrid()),
    );
  }

  Widget _galleryGrid() {

    CollectionReference foodProductCollection = FirebaseFirestore.instance.collection('foodProduct');

    return StreamBuilder<QuerySnapshot>(
      stream: foodProductCollection.where('name', isEqualTo: "n1").snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          );
        }

        return new ListView(

          children: snapshot.data.docs.map((DocumentSnapshot document) {
            print("Finding: "+ document.data()["name"]);
            print("Finding: "+ document.data()["category"]);
            /*
            for(DocumentSnapshot x in document){
              print(x.id);
              print(x.data()['comment']);
              print(x.data()['star']);
            }

          //  document.get(field)

            document.reference.collection('commentSet').get().then((snapshot) {
              print(snapshot.docs);
              for(DocumentSnapshot x in snapshot.docs){
                print(x.id);
                print(x.data()['comment']);
                print(x.data()['star']);
              }
            });

             */
            return new ListTile(
            //  title: new Text(document.data()['name']), //document.data()['name']
             // subtitle: new Text(document.data()['category']), //document.data()['category']

            );
          }).toList(),
        );
      },
    );
  }
}