import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodei_life/constant/images.dart';
import 'dart:io';
import '../Provider/User_Data_Provider.dart';
import '../widgets/Image_dialog.dart';
import 'Home_Screen.dart';
import 'Tabs_Screen.dart';

class SettingsMenu extends ConsumerStatefulWidget {
  const SettingsMenu({Key? key}) : super(key: key);

  @override
  _SettingsMenuState createState() => _SettingsMenuState();
}

class _SettingsMenuState extends ConsumerState<SettingsMenu> {
  File? selectedImage;
  String currentImageUrl = '';
  bool _loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUserProfileImage();
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  Future<void> getCurrentUserProfileImage() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      DocumentSnapshot<Map<String, dynamic>> userData = await FirebaseFirestore
          .instance
          .collection('User')
          .doc(user.uid)
          .get();

      if (userData.exists) {
        currentImageUrl = userData['imageUrl'] ?? '';
      } else {
        throw Exception('User data not found.');
      }
    } else {
      throw Exception('User Not Logged in.');
    }
  }

  void _showImageDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Change Profile Picture'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ImageInput(
              currentImageUrl: currentImageUrl,
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Future<void> updateUsername(String newUsername) async {
    setState(() {
      _loading = true;
    });
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.updateProfile(displayName: newUsername);
        await FirebaseFirestore.instance
            .collection('User')
            .doc(user.uid)
            .update({'username': newUsername});
        showSnackBar(context, 'Username updated successfully!');
        ref.watch(userDataProvider);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => TabsScreen()),
          (route) => false, // This prevents going back to the previous screens
        );
      } else {
        showSnackBar(context, 'User not logged in.');
      }
    } catch (error) {
      print('Error updating username: $error');
      showSnackBar(context, 'Failed to update username. Please try again.');
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  void showUsernameDialog() {
    TextEditingController newUsernameController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Change Username'),
        content: SizedBox(
          width: 700,
          child: TextFormField(
            controller: newUsernameController,
            decoration: InputDecoration(
              labelText: 'New Username',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (!_loading) {
                // Update the username in Firebase and close the dialog
                updateUsername(newUsernameController.text);
                Navigator.pop(context);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Column(
        children: [
          ListTile(
            leading: const CircleAvatar(
              backgroundImage: AssetImage(hUserImage),
            ),
            title: const Text('Change Profile'),
            onTap: () {
              _showImageDialog();
            },
          ),
          const SizedBox(height: 8),
          ListTile(
            leading: const CircleAvatar(
              backgroundImage: AssetImage(hNameImage),
            ),
            title: const Text('Change Username'),
            onTap: () {
              showUsernameDialog();
            },
          ),
        ],
      ),
    );
  }
}
