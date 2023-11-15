import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  XFile? image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: image != null ? Image.file(File(image!.path)) : Text("No Image"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          ImagePicker picker = new ImagePicker();
          image = await picker.pickImage(source: ImageSource.gallery);
          setState(() {});
        },
        child: Icon(Icons.image),
      ),
    );
  }
}
