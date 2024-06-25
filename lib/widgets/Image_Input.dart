import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key, required this.onPickImage});

  final void Function(String imageUrl) onPickImage;

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _selectedImage;

  Future<void> _takePicture() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery, maxWidth: 600);
    if (pickedImage == null) {
      return;
    }
    setState(() {
      _selectedImage = File(pickedImage.path);
    });

    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('recipe_image')
            .child('${user.uid}_${DateTime.now().microsecondsSinceEpoch}.jpg');
        await storageRef.putFile(_selectedImage!);

        final imageUrl = await storageRef.getDownloadURL();
        widget.onPickImage(imageUrl);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error uploading Image: $e'),
            duration: const Duration(seconds: 5),
          ),
        );
        print('Error uploading Image: $e');
      }
    } else {
      print('user not Logged in');
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
        onPressed: _takePicture,
        icon: Icon(
          size: 35,
          Icons.camera_alt,
          color: Colors.blueGrey,
        ),
        label: Text(
          'Take Picture',
          style: Theme.of(context).textTheme.bodyLarge,
        ));

    if (_selectedImage != null) {
      content = Image.file(
        _selectedImage!,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      );
    }
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
        ),
      ),
      height: 250,
      width: double.infinity,
      alignment: Alignment.center,
      child: content,
    );
  }
}
