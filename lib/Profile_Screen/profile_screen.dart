import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class ProfileUpdate {
  final String title;
  final String description;
  final String imagePath;

  ProfileUpdate({required this.title, required this.description, required this.imagePath});
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? selectedFile;

  List<ProfileUpdate> updates = [
    ProfileUpdate(title: 'Update your Profile', description: 'Update your personal details', imagePath: 'assets/listview/img.png'),
    ProfileUpdate(title: 'Complete KYC', description: 'Complete your KYC verification', imagePath: 'assets/listview/img_1.png'),
    ProfileUpdate(title: 'Upload Documents', description: 'Upload necessary documents', imagePath: 'assets/listview/img_2.png'),
    ProfileUpdate(title: 'Joining Documents', description: 'Upload your documents for joining', imagePath: 'assets/listview/img_3.png'),
  ];

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'jpeg'],
    );

    if (result != null) {
      setState(() {
        selectedFile = File(result.files.single.path!);
      });
      print("Selected file: ${selectedFile!.path}");
    } else {
      print("File selection canceled.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Image.asset(
            'assets/images/menu.png',
            height: 14,
            width: 8,
            color: const Color(0xFFEAFFFF),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Image.asset(
              'assets/images/comment.png',
              height: 30,
              width: 30,
              color: const Color(0xFFEAFFFF),
            ),
          ),
        ],
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFA1DFFE),
                Color(0xFF39BAFC),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 55,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(50),
                      bottomLeft: Radius.circular(50),
                    ),
                    color: Color(0xFF39BAFC),
                  ),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 15.0),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, left: 30, right: 30),
                  child: Container(
                    width: MediaQuery.sizeOf(context).width,
                    decoration: BoxDecoration(
                      color:  Color(0xfff2f2f2),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        Center(
                          child: Text(
                            'Welcome Arun Pratap!',
                            style: TextStyle(
                              color: Color(0xff686868),
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        // profile icon
                        SizedBox(
                          height: 170,
                          width: 170,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              CircleAvatar(
                                radius: 75,
                                backgroundImage: selectedFile != null
                                    ? FileImage(selectedFile!)
                                    : AssetImage("assets/images/profile_picture.png") as ImageProvider,
                              ),
                              Positioned(
                                right: -20,
                                top: 20,
                                child: MaterialButton(
                                  onPressed: pickFile,
                                  color: Colors.white,
                                  textColor: Colors.grey,
                                  child: const Icon(
                                    Icons.camera_alt,
                                    size: 24,
                                  ),
                                  padding: EdgeInsets.all(10),
                                  shape: CircleBorder(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'KYC Verified:',
                                    style: TextStyle(
                                      color: Color(0xff272727),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Image.asset(
                                    'assets/images/cross-circle.png',
                                    height: 15,
                                    width: 15,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 16),
                            Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'TP Code:',
                                    style: TextStyle(
                                      color: Color(0xff272727),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Text(
                  'Your Document has been rejected',
                  style: TextStyle(
                    color: Color(0xffc12c2b),
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
                Text(
                  'Please reupload again',
                  style: TextStyle(
                    color: Color(0xffc12c2b),
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: updates.length,
              itemBuilder: (BuildContext context, int index) {
                ProfileUpdate update = updates[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  update.title,
                                  style: TextStyle(
                                    color: Color(0xff306883),
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  update.description,
                                  style: TextStyle(
                                    color: Color(0xff090909),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 12),
                                Container(
                                  width: 140,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xff39BAFC),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20), // Increase border radius for more rounded corners
                                      ),
                                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center, // Center align content
                                      children: [
                                        Text(
                                          'Click Here',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                          ),
                                        ),
                                        SizedBox(width: 5), // Add space between text and image
                                        Image.asset(
                                          'assets/listview/arrow_right.png',
                                          height: 20,
                                          width: 30,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),
                          Image.asset(
                            update.imagePath,
                            height: 100,
                            width: 85,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
