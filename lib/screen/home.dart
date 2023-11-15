import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ImagePicker picker = new ImagePicker();
  XFile? image;

  // From Gallery
  Future<void> pickImageGallery() async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      image = pickedImage;
    });
  }

  // From Camera
  Future<void> pickImageCamera() async {
    final pickedImageCamera =
        await picker.pickImage(source: ImageSource.camera);
    setState(() {
      image = pickedImageCamera;
    });
  }

  void showImageOption(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Select Image Source"),
          content: ListView(
            children: [
              ListTile(
                leading: Icon(Icons.image),
                title: Text("Gallary"),
                onTap: pickImageGallery,
              ),
              ListTile(
                leading: Icon(Icons.camera),
                title: Text("Camera"),
                onTap: pickImageCamera,
              ),
            ],
          ),
          actions: [],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 2)),
                  child: CircleAvatar(
                    radius: 80,
                    backgroundImage:
                        (image != null) ? FileImage(File(image!.path)) : null,
                  ),
                ),
                Positioned(
                  bottom: 5,
                  right: 10,
                  child: Icon(
                    Icons.image,
                    size: 30,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showImageOption(context);
        },
        child: Icon(Icons.image),
      ),
    );
  }
}
