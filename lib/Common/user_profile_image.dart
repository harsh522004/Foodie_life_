import 'dart:io';

import 'package:flutter/material.dart';
import 'package:foodei_life/theme/colors.dart';
import 'package:image_picker/image_picker.dart';

class UserProfileImage extends StatefulWidget {
  const UserProfileImage({super.key, required this.onPickImage, required this.defaultImage});

  final void Function(File pickedImage) onPickImage;
  final ImageProvider<Object> defaultImage;

  @override
  State<UserProfileImage> createState() => _UserProfileImageState();
}

class _UserProfileImageState extends State<UserProfileImage> {
  File? _pickedImageFile;

  void userPickerImage() async {
    final pickedImage = await ImagePicker().pickImage(
        source: ImageSource.gallery, imageQuality: 50, maxWidth: 150);
    if (pickedImage == null) {
      return;
    }
    setState(() {
      _pickedImageFile = File(pickedImage.path);
    });

    widget.onPickImage(_pickedImageFile!);
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Column(
        children: [
          GestureDetector(
            onTap: userPickerImage,
            child: CircleAvatar(
              radius: 35,
              backgroundColor: materialColor[50],
              child: _pickedImageFile != null
                  ? ClipOval(
                child: Image.file(
                  _pickedImageFile!,
                  width: 70, // Set the width as needed
                  height: 70, // Set the height as needed
                  fit: BoxFit.cover,
                ),
              )
                  : ClipOval(
                child: Image(
                  image: widget.defaultImage,
                  width: 50, // Set the width as needed
                  height: 50, // Set the height as needed
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
