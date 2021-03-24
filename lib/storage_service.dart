import 'dart:async';
import 'dart:io';


class StorageService {
  // 1

  final imageUrlsController = StreamController<List<String>>();

  // 2
  void getImages() async {
    try {
      // 3
      final listOptions = '';

      // 4
      final result = '';

      // 5
      final getUrlOptions = '';

      // 6
      final List<String> imageUrls = [""];

      // 7
      imageUrlsController.add(imageUrls);

      // 8
    } catch (e) {
      print('Storage List error - $e');
      print(e.toString());
    }
  }

  }

  // 1
  void uploadImageAtPath(String imagePath) async {
    /*
    final imageFile = File(imagePath);
    // 2
    final imageKey = '${DateTime.now().millisecondsSinceEpoch}.jpg';
    print(imageKey);
    try {
      // 3
      final options = S3UploadFileOptions(
          accessLevel: StorageAccessLevel.private);
      print('uploadtest1');
      // 4
      print(imageFile);
      await Amplify.Storage.uploadFile(
          local: imageFile, key: imageKey, options: options);

      // 5
      getImages();
    } catch (e) {
      print('upload error - $e.');
    }
  }
    */

}