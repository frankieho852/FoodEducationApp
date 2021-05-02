import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';


// testing page only
class CameraPage extends StatefulWidget {

  final CameraDescription camera;
  final ValueChanged didProvideImagePath;

  CameraPage({Key key, this.camera, this.didProvideImagePath})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;

  bool isFileUploading = false;

  File selectedFile;

  String poolId;
  String awsFolderPath;
  String bucketName;


  @override
  void initState() {
    super.initState();
    _controller = CameraController(widget.camera, ResolutionPreset.ultraHigh);
    _initializeControllerFuture = _controller.initialize();
    readEnv();
  }

  void readEnv() async {
    final str = await rootBundle.loadString(".env");
    if (str.isNotEmpty) {
      final decoded = jsonDecode(str);
      poolId = decoded["us-east-2:2aaad3c8-b22f-4aec-a61a-910cf9a6534b"];
      awsFolderPath = decoded[""];
      bucketName = decoded["textractfyptest1"];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          // 4
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(this._controller);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera),
        onPressed: _takePicture,
      ),
    );

  }


  void _takePicture() async {

    try {
      await _initializeControllerFuture;

      final tmpDirectory = await getTemporaryDirectory();
      final filePath = '${DateTime
          .now()
          .millisecondsSinceEpoch}.png';
      //final path = join(tmpDirectory.path, filePath);

      final image = await _controller.takePicture();

      //final File imageFile = getImageFile();
      final File imageFile = File(image.path);
      final FirebaseVisionImage visionImage = FirebaseVisionImage
          .fromFile(imageFile);

      final TextRecognizer cloudTextRecognizer = FirebaseVision.instance
          .cloudTextRecognizer();
      final VisionText visionText = await cloudTextRecognizer
          .processImage(visionImage);

      String text = visionText.text;
      print("ALL text: " + text);
      for (TextBlock block in visionText.blocks) {
        final Rect boundingBox = block.boundingBox;
        final List<Offset> cornerPoints = block.cornerPoints;
        final String text = block.text;
        final List<RecognizedLanguage> languages = block.recognizedLanguages;

        for (TextLine line in block.lines) {
          // Same getters as TextBlock
          print("TextLine text: " + line.text);
          for (TextElement element in line.elements) {
            // Same getters as TextBlock
            //setState(() {
            //  text = text + element.text + ' ';
            // });
            // element.text ;
            print("TextElement text: " + element.text);
          }
        }
      }

      cloudTextRecognizer.close();

      // widget.didProvideImagePath(path);

    } catch (e) {
      print(e);
    }
  }

  /*
  Future<String> _uploadImage(File file, int number,
      {String extension = 'png'}) async {

    String result;
    if (result == null) {
      // generating file name
      String fileName =
          "$number$extension\_${DateTime.now().millisecondsSinceEpoch}.$extension";
      setState(() => isFileUploading = true);
      displayUploadDialog(awsS3);
      try {
        try {
          result = await awsS3.uploadFile;
          debugPrint("Result :'$result'.");
        } on PlatformException {
          debugPrint("Result :'$result'.");
        }
      } on PlatformException catch (e) {
        debugPrint("Failed :'${e.message}'.");
      }
    }
    Navigator.of(context).pop();
    return result;
  }

  Future displayUploadDialog(AwsS3 awsS3) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => StreamBuilder(
        stream: awsS3.getUploadStatus,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return buildFileUploadDialog(snapshot, context);
        },
      ),
    );
  }

   */

  AlertDialog buildFileUploadDialog(
      AsyncSnapshot snapshot, BuildContext context) {
    return AlertDialog(
      title: Container(
        padding: EdgeInsets.all(6),
        child: LinearProgressIndicator(
          value: (snapshot.data != null) ? snapshot.data / 100 : 0,
          valueColor:
          AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColorDark),
        ),
      ),
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Text('Uploading...')),
            Text("${snapshot.data ?? 0}%"),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}

class DisplayPictureScreen extends StatelessWidget {

  final String text;
  final String imagePath;
  const DisplayPictureScreen({Key key, this.text, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Column(
        children: [
          Text('test'),
          //Image.file(File(imagePath)),
        ],
      ),
    );
  }
}


