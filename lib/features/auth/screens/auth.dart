import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodei_life/Common/elevated_button.dart';
import 'package:foodei_life/Common/user_profile_image.dart';
import 'package:foodei_life/Provider/profile_image_provider.dart';
import 'package:foodei_life/constant/images.dart';
import 'package:foodei_life/screens/Tabs_Screen.dart';
import 'package:foodei_life/theme/colors.dart';
import 'package:foodei_life/theme/text_theme.dart';

final _firebase = FirebaseAuth.instance;

extension NavigationExtensions on BuildContext {
  void pushReplacementAll(Widget newRoute) {
    Navigator.of(this).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => newRoute),
      (Route<dynamic> route) => false,
    );
  }
}

class AuthScreen extends ConsumerStatefulWidget {
  final String title;
  final String subtitle;
  final String buttonLabel;
  final bool isLoginScreen;

  const AuthScreen({
    super.key,
    required this.title,
    required this.subtitle,
    required this.buttonLabel,
    required this.isLoginScreen,
  });

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  final _form = GlobalKey<FormState>();

  final _emailController = TextEditingController();

  final _passController = TextEditingController();

  final _usernameController = TextEditingController();

  File? _selectedImage;

  late bool _isAuthentication = false;

  // when button Clicked
  void _onSaved() async {
    final pickedImageFile = ref.read(pickedImageProvider);

    if (!widget.isLoginScreen && pickedImageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a profile image')),
      );
    } else {
      final isValid = _form.currentState!.validate();
      if (!isValid || (!widget.isLoginScreen && _selectedImage == null)) {
        return;
      }
      _form.currentState!.save();
      try {
        setState(() {
          _isAuthentication = true;
        });
        if (!widget.isLoginScreen) {
          final userCred = await _firebase.createUserWithEmailAndPassword(
              email: _emailController.text, password: _passController.text);

          final storageRef = FirebaseStorage.instance
              .ref()
              .child('User_Images')
              .child('${userCred.user!.uid}.jpg');
          await storageRef.putFile(_selectedImage!);
          final userImageUrl = await storageRef.getDownloadURL();

          await FirebaseFirestore.instance
              .collection('User')
              .doc(userCred.user!.uid)
              .set({
            'username': _usernameController.text,
            'email': _emailController.text,
            'imageUrl': userImageUrl,
            'savedRecipes': [],
          });

          _usernameController.clear();
          _emailController.clear();
          _passController.clear();

          await Future.delayed(const Duration(milliseconds: 500));

          context.pushReplacementAll(TabsScreen());
          // Navigate to LoginScreen after successful signup
          // Navigator.of(context).pushReplacement(
          //   MaterialPageRoute(
          //     builder: (context) => const AuthScreen(
          //       title: 'Log In',
          //       subtitle: 'Log in to your account',
          //       buttonLabel: 'Log In',
          //       isLoginScreen: true,
          //     ),
          //   ),
          // );
        } else {
          final userCred = await _firebase.signInWithEmailAndPassword(
              email: _emailController.text, password: _passController.text);
          _emailController.clear();
          _passController.clear();

          context.pushReplacementAll(TabsScreen());

          setState(() {
            _isAuthentication = false;
          });
        }
      } on FirebaseAuthException catch (error) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error.message ?? 'Authentication Error')));
        setState(() {
          _isAuthentication = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content = !widget.isLoginScreen
        ? Row(
            children: [
              UserProfileImage(
                onPickImage: (pickedImage) {
                  _selectedImage = pickedImage;
                },
                defaultImage: AssetImage(hAddImage),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                children: [
                  Text(
                    widget.title,
                    style: HtextTheme.hTextTheme.headlineLarge
                        ?.copyWith(fontSize: 40),
                  ),

                  // subtitle
                  Text(
                    widget.subtitle,
                    style: HtextTheme.hTextTheme.titleMedium,
                  ),
                ],
              ),
              // title
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style:
                    HtextTheme.hTextTheme.headlineLarge?.copyWith(fontSize: 40),
              ),

              // subtitle
              Text(
                widget.subtitle,
                style: HtextTheme.hTextTheme.titleMedium,
              ),
            ],
          );

    return Scaffold(
      backgroundColor: materialColor[500],
      body: SingleChildScrollView(
        child: Stack(
          children: [
            //Image
            Card(
              elevation: 15,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(60),
              ),
              child: SizedBox(
                width: double.infinity,
                height: 200,
                child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(0),
                      bottomLeft: Radius.circular(60),
                      bottomRight: Radius.circular(60),
                    ),
                    child: Image.asset(
                      widget.isLoginScreen ? hlogInImage : hSignupImage,
                      fit: BoxFit.cover,
                    )),
              ),
            ),

            //Icon to move Back
            Positioned(
              top: 37,
              left: 12,
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios_outlined),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),

            // content
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _form,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 200),

                    content,

                    const SizedBox(height: 30),

                    // username if it is not login screen
                    if (!widget.isLoginScreen)
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _usernameController,
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors
                                    .black), // Set your desired focus color here
                            borderRadius: BorderRadius.circular(18),
                          ),
                          errorStyle: const TextStyle(color: Colors.white),
                          hintText: 'Username',
                          prefixIcon:
                              const Icon(Icons.email, color: Colors.black),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.trim().length < 4 ||
                              value.isEmpty) {
                            return 'Please enter Valid UserName';
                          }
                          return null;
                        },
                      ),

                    const SizedBox(height: 20),

                    // Email Input

                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Colors
                                  .black), // Set your desired focus color here
                          borderRadius: BorderRadius.circular(18),
                        ),
                        errorStyle: const TextStyle(color: Colors.white),
                        hintText: 'Email',
                        prefixIcon:
                            const Icon(Icons.email, color: Colors.black),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            !value.contains('@')) {
                          return 'Please Enter Your Email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    // password Input

                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _passController,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Colors
                                  .black), // Set your desired focus color here
                          borderRadius: BorderRadius.circular(18),
                        ),
                        errorStyle: const TextStyle(color: Colors.white),
                        hintText: 'Password',
                        prefixIcon:
                            const Icon(Icons.email, color: Colors.black),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.trim().length < 6 ||
                            value.isEmpty) {
                          return 'Please enter Password';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 100),
                    //const SizedBox(height: 250),

                    if (_isAuthentication)
                      Center(
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation(materialColor[800]),
                        ),
                      ),
                    if (!_isAuthentication)
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: hElevatedButton(
                          text: widget.buttonLabel,
                          onTap: _onSaved,
                        ),
                      ),
                    const SizedBox(height: 10),

                    if (!_isAuthentication)
                      // Screen Change Text Button
                      Center(
                        child: TextButton(
                          onPressed: () {
                            if (widget.isLoginScreen) {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => const AuthScreen(
                                      title: 'Sign Up',
                                      subtitle:
                                          'Create an account to get started',
                                      buttonLabel: 'Sign Up',
                                      isLoginScreen: false),
                                ),
                              );
                            } else {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => const AuthScreen(
                                    title: 'Log In',
                                    subtitle: 'Log in to your account',
                                    buttonLabel: 'Log In',
                                    isLoginScreen: true,
                                  ),
                                ),
                              );
                            }
                          },
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  style: TextStyle(color: materialColor[100]),
                                  text: widget.isLoginScreen
                                      ? "Don't have an account? "
                                      : "Already have an account? ",
                                ),
                                TextSpan(
                                  text: widget.isLoginScreen
                                      ? 'Sign Up'.toUpperCase()
                                      : 'LogIn',
                                  style: TextStyle(
                                    color: materialColor[100],
                                    decoration: TextDecoration.combine([
                                      TextDecoration.underline,
                                    ]),
                                    decorationColor:
                                        Colors.white, // Set underline color
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
