import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodei_life/screens/Tabs_Screen.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import '../Provider/User_Data_Provider.dart';

class ImageInput extends ConsumerStatefulWidget {
  const ImageInput({super.key, required this.currentImageUrl});

  final String currentImageUrl;

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends ConsumerState<ImageInput> {
  File? _selectedImage;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    _loadImage();
  }

  Future<void> _loadImage() async {
    setState(() {
      _isLoading = true;
    });

    try {
      _selectedImage = await downloadImage(widget.currentImageUrl);
    } catch (error) {
      print('Error loading image: $error');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<File?> downloadImage(String imageUrl) async {
    try {
      final response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode == 200) {
        final Uint8List bytes = response.bodyBytes;
        final tempDir = await getTemporaryDirectory();
        final file = File('${tempDir.path}/image.jpg');
        await file.writeAsBytes(bytes);
        return file;
      } else {
        print('Failed to load image. Status Code: ${response.statusCode}');
        return null;
      }
    } catch (error) {
      print('Error downloading image: $error');
      return null;
    }
  }

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
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  Future<void> updateProfilePicture(File newImage) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        String userId = user.uid;
        String fileName = 'User_Images/$userId.png'; // Use .png for consistency

        Reference storageReference =
            FirebaseStorage.instance.ref().child(fileName);
        List<int> imageBytes = await newImage.readAsBytes();

        UploadTask uploadTask =
            storageReference.putData(Uint8List.fromList(imageBytes));

        await uploadTask.whenComplete(() async {
          try {
            TaskSnapshot taskSnapshot = await uploadTask;
            String downloadUrl = await taskSnapshot.ref.getDownloadURL();
            await FirebaseFirestore.instance
                .collection('User')
                .doc(userId)
                .update({
              'imageUrl': downloadUrl,
            });
            print('Profile picture updated successfully!');
            showSnackBar(context, 'Profile picture updated successfully!');
            ref.watch(userDataProvider);

            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => TabsScreen()),
                  (route) => false, // This prevents going back to the previous screens
            );

          } catch (error) {
            print('Error updating profile picture: $error');
            showSnackBar(
                context, 'Failed to update profile picture. Please try again.');
          }
        });
      } else {
        throw Exception('User Not Logged in.');
      }
    } catch (error) {
      print('Error updating profile picture: $error');
      showSnackBar(
          context, "Failed to update profile picture. Please try again.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            image: _selectedImage != null
                ? DecorationImage(
                    image: FileImage(_selectedImage!),
                    fit: BoxFit.cover,
                  )
                : null,
            shape: BoxShape.circle,
            border: Border.all(
              width: 1,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
            ),
          ),
          height: 80,
          width: 80,
          alignment: Alignment.center,
          //child: content,
        ),
        const SizedBox(height: 16),
        _isLoading ? const CircularProgressIndicator() : TextButton(
          onPressed: _takePicture,
          child: const Text('Choose Image'),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            if (_selectedImage != null) {
              updateProfilePicture(_selectedImage!);
            } else {
              print('Selected image is null.');
              showSnackBar(context, 'Selected image is null.');
            }
          },
          child: const Text('update Image'),
        ),
      ],
    );
  }
}
