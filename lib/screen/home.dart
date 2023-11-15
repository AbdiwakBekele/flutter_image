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
          content: Container(
            height: 200,
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.image),
                  title: Text("Gallary"),
                  onTap: () {
                    pickImageGallery();
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.camera),
                  title: Text("Camera"),
                  onTap: () {
                    pickImageCamera();
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Close"),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          title: Center(child: Text("Edit Profile")),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
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
                    bottom: 0,
                    right: 5,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.green[700],
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.camera_alt,
                          size: 25,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          showImageOption(context);
                        },
                      ),
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
      ),
    );
  }
}
