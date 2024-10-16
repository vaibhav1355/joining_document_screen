import 'package:flutter/material.dart';

class Document {
  final String title;
  final String leadingImage;
  final String trailingImage;
  final String? date;

  Document({
    required this.title,
    required this.leadingImage,
    required this.trailingImage,
    this.date,
  });
}

class JoiningDocuments extends StatefulWidget {
  const JoiningDocuments({super.key});

  @override
  State<JoiningDocuments> createState() => _JoiningDocumentsState();
}

class _JoiningDocumentsState extends State<JoiningDocuments> {
  final List<Document> documents = [
    Document(
      title: 'Relieving/ Experience Letter',
      leadingImage: 'assets/joiningdoc/img.png',
      trailingImage: 'assets/joiningdoc/upload.png',
    ),
    Document(
      title: 'Latest Salary Clip or Bank Statement',
      leadingImage: 'assets/joiningdoc/img_1.png',
      trailingImage: 'assets/joiningdoc/upload.png',
      date: '2024-10-01',
    ),
    Document(
      title: 'Pancard',
      leadingImage: 'assets/joiningdoc/img_2.png',
      trailingImage: 'assets/joiningdoc/preview.png',
      date: '2024-09-15',
    ),
    Document(
      title: 'UAN',
      leadingImage: 'assets/joiningdoc/img.png',
      trailingImage: 'assets/joiningdoc/upload.png',
    ),
    Document(
      title: 'Bank Passbook / Cancel Cheque',
      leadingImage: 'assets/joiningdoc/img.png',
      trailingImage: 'assets/joiningdoc/upload.png',
    ),
  ];

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
      body: Column(
        children: [
          Container(
            height: 55,
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(50),
                bottomLeft: Radius.circular(50),
              ),
              color: Color(0xFF39BAFC),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: const Text(
                  'Joining Documents',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          Expanded(
            child: ListView.builder(
              itemCount: documents.length,
              itemBuilder: (BuildContext context, int index) {
                final document = documents[index];
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    leading: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Image.asset(document.leadingImage),
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            document.title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff565656),
                            ),
                          ),
                        ),
                        if (document.date != null)
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, bottom: 2.0),
                            child: Text(
                              document.date!,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                      ],
                    ),
                    trailing: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Image.asset(
                        document.trailingImage,
                        color: Colors.grey,
                        height: 20,
                        width: 20,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
