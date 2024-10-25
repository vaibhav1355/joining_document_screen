import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';


class UploadDocuments extends StatefulWidget {
  const UploadDocuments({super.key});

  @override
  State<UploadDocuments> createState() => _UploadDocumentsState();

  void main() {
    runApp(
      MaterialApp(
        home: UploadDocuments(),
      ),
    );
  }
}

class _UploadDocumentsState extends State<UploadDocuments> {
  String? filePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20 , right: 20 , bottom: 28),
              child: Container(
                height: MediaQuery.sizeOf(context).height * 0.27,
                width: MediaQuery.sizeOf(context).width,
                decoration: BoxDecoration(
                  color: Color(0xffe1e1e1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Color(0xffd3d3d3),
                    width: 1,
                  )
                ),
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    InkWell(
                      onTap: () => _showModalBottomSheet(context),
                      child: Image.asset(
                        'assets/download/img_1.png',
                        height: 100,
                        width: 100,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 10),
                    MaterialButton(
                      child: Text('Browse'),
                      height: 40,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      color: Color(0xffD1D1D1),
                      onPressed: () => _showModalBottomSheet(context),
                    ),
                    SizedBox(height: 15),
                    Padding(
                      padding: EdgeInsets.only(left: 5 , right: 5),
                      child: Text(
                        'Please upload a document smaller than 1 MB',
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: 200,
          child: Column(
            children: [
              SizedBox(height: 10),
              Text(
                'Please Select the Document',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 30),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: _pickFile,
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Select Doc from Gallery',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                                color: Color(0xff404040),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    CustomDivider(),
                    InkWell(
                      onTap: _navigateToCamera,
                      child: Row(
                        children:[
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Take Picture by Camera',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                                color: Color(0xff404040),
                              ),
                            ),
                          ),
                        ]
                      ),
                    ),
                    CustomDivider(),
                  ],
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  void _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'jpeg', 'pdf'],
    );
  
    if (result != null) {
      if (kIsWeb) {
        Uint8List? fileBytes = result.files.first.bytes;
        String fileName = result.files.first.name;
        setState(() {
          filePath = fileName;
        });
        print(fileBytes);
      } else {
        setState(() {
          filePath = result.files.single.path;
        });
      }

      setState(() {
        filePath = result.files.single.path;
      });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => UploadDocuments()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No file selected')),
      );
    }
  }

  void _navigateToCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TakePictureScreen(camera: firstCamera),
      ),
    );
  }
}

class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({
    super.key,
    required this.camera,
  });

  final CameraDescription camera;

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Take a picture')),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
                height: MediaQuery.sizeOf(context).height * 0.8,
                child: CameraPreview(_controller));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            await _initializeControllerFuture;
            final image = await _controller.takePicture();
            if (!context.mounted) return;
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DisplayPictureScreen(
                  imagePath: image.path,
                ),
              ),
            );
          } catch (e) {
            print(e);
          }
        },
        child: Icon(Icons.camera_alt),
      ),
    );
  }
}

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
              height: MediaQuery.sizeOf(context).height * 0.8,
              child: Image.file(File(imagePath))
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Image.asset(
                    'assets/download/cross-circle_.png',
                    height: 40,
                    width: 40,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UploadDocuments()),
                    );
                  },
                  child: Image.asset(
                    'assets/download/check-mark.png',
                    height: 30,
                    width: 30,
                  ),
                ),
              ],
            ),
          )
        ],
      )
    );
  }
}

/* --------------> Lines in between the code <---------------- */
class CustomDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 20.0,
      color: Color(0xffE7E7E7),
      thickness: 0.7,
    );
  }
}