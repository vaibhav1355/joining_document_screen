import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Joining_Documents/joining_documents.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: JoiningDocuments(),
    );
  }
}


