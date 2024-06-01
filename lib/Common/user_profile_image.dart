import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodei_life/Provider/profile_image_provider.dart';
import 'package:foodei_life/theme/colors.dart';
import 'package:image_picker/image_picker.dart';

class UserProfileImage extends ConsumerStatefulWidget {
  const UserProfileImage(
      {super.key, required this.onPickImage, required this.defaultImage});

  final void Function(File pickedImage) onPickImage;
  final ImageProvider<Object> defaultImage;

  @override
  ConsumerState<UserProfileImage> createState() => _UserProfileImageState();
}

class _UserProfileImageState extends ConsumerState<UserProfileImage> {
  void userPickerImage() async {
    final pickedImage = await ImagePicker().pickImage(
        source: ImageSource.gallery, imageQuality: 50, maxWidth: 150);
    if (pickedImage == null) {
      return;
    }
    final _pickedImageFile = File(pickedImage.path);
    ref.read(pickedImageProvider.notifier).state = _pickedImageFile;

    widget.onPickImage(_pickedImageFile);
  }

  @override
  Widget build(BuildContext context) {
    final pickedImageFile = ref.watch(pickedImageProvider);
    return Align(
      child: Column(
        children: [
          GestureDetector(
            onTap: userPickerImage,
            child: CircleAvatar(
              radius: 35,
              backgroundColor: materialColor[50],
              child: pickedImageFile != null
                  ? ClipOval(
                      child: Image.file(
                        pickedImageFile,
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                      ),
                    )
                  : ClipOval(
                      child: Image(
                        image: widget.defaultImage,
                        width: 40,
                        height: 40,
                        fit: BoxFit.contain,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
