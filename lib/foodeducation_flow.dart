import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:fyp_firebase_login/storage_service.dart';

import 'camera_page.dart';
import 'gallery_page.dart';

class FoodEducationFlow extends StatefulWidget {
  final VoidCallback shouldLogOut;
  final VoidCallback showFoodEducation;

  FoodEducationFlow({Key key, this.shouldLogOut, this.showFoodEducation})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _FoodEducationFlowState();
}

class _FoodEducationFlowState extends State<FoodEducationFlow> {
  CameraDescription _camera;

 // StorageService _storageService;

  bool _shouldShowCamera = false;

  List<MaterialPage> get _pages {
    return [

      // Show Gallery Pag
        MaterialPage(
            child: GalleryPage(
              //imageUrlsController: _storageService.imageUrlsController
                shouldLogOut: widget.shouldLogOut,
                shouldShowCamera: () => _toggleCameraOpen(true))),

      // Show Camera Page
      if (_shouldShowCamera)
        MaterialPage(
            child: CameraPage(
                camera: _camera,
                didProvideImagePath: (imagePath) {
                  this._toggleCameraOpen(false);
                  //this._storageService.uploadImageAtPath(imagePath);
                }))
    ];
  }

  @override
  void initState() {
    super.initState();
    _getCamera();
    // _storageService = StorageService();
    // _storageService.getImages();
  }

  @override
  Widget build(BuildContext context) {
    // 4
    return Navigator(
      pages: _pages,
      onPopPage: (route, result) => route.didPop(result),
    );
  }

  void _toggleCameraOpen(bool isOpen) {
    setState(() {
      this._shouldShowCamera = isOpen;
    });
  }

  void _getCamera() async {
    final camerasList = await availableCameras();
    setState(() {
      final firstCamera = camerasList.first;
      this._camera = firstCamera;
    });
  }
}
