import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userDataProvider =
    FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  try {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      int retryCount = 0;

      DocumentSnapshot<Map<String, dynamic>>? userData;
      while (retryCount < 5 && (userData == null || !userData.exists)) {
        userData = await FirebaseFirestore.instance
            .collection('User')
            .doc(user.uid)
            .get();
        if (!userData.exists) {
          await Future.delayed(const Duration(milliseconds: 200));
        }
        retryCount++;
      }
      if (userData != null && userData.exists) {
        return userData.data()!;
      } else {
        throw Exception('User data not found.');
      }
    } else {
      throw Exception('User Not Logged in.');
    }
  } catch (e) {
    // Handle the exception
    print('Error fetching user data from provider: $e');
    throw Exception('Error fetching user data from provider');
  }
});
