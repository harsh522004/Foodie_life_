import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userDataProvider =
    FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  User? user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    DocumentSnapshot<Map<String, dynamic>> userData =
        await FirebaseFirestore.instance.collection('User').doc(user.uid).get();
    return userData.data()!;
  } else {
    throw Exception('User Not Logged in.');
  }
});
