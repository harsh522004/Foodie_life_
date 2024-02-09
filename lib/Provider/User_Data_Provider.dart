import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userDataProvider = FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  try {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      DocumentSnapshot<Map<String, dynamic>> userData =
      await FirebaseFirestore.instance.collection('User').doc(user.uid).get();
      return userData.data()!;
    } else {
      throw Exception('User Not Logged in.');
    }
  } catch (e) {
    // Handle the exception
    print('Error fetching user data: $e');
    throw Exception('Error fetching user data');
  }
});


