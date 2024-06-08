// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:realstate/model/house.dart';
import 'package:realstate/model/user.dart';

final userProvider = StateNotifierProvider<UserNotifier, LocalUser>((ref) {
  return UserNotifier();
});

class LocalUser {
  final String id;
  final FirebaseUser realtor;
  LocalUser({required this.id, required this.realtor});

  LocalUser copyWith({
    String? id,
    FirebaseUser? realtor,
  }) {
    return LocalUser(
      id: id ?? this.id,
      realtor: realtor ?? this.realtor,
    );
  }
}

class UserNotifier extends StateNotifier<LocalUser> {
  UserNotifier()
      : super(LocalUser(
            id: "error",
            realtor: FirebaseUser(
                email: "error", name: 'error', profilePic: 'error')));
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

// Login

  Future<void> login(String email) async {
    QuerySnapshot response = await _firestore
        .collection("realtors")
        .where('email', isEqualTo: email)
        .get();
    if (response.docs.isEmpty) {
      print('No firestore user associated with to authenticated email $email');
      return;
    }
    if (response.docs.length != 1) {
      print('More than one firestor user associated with email $email');
      return;
    }
    state = LocalUser(
        id: response.docs[0].id,
        realtor: FirebaseUser.fromMap(
            response.docs[0].data() as Map<String, dynamic>));
  }

// Sign Up


  Future<void> signUp(String email) async {
    DocumentReference response = await _firestore.collection("realtors").add(
        FirebaseUser(
                email: email,
                name: 'NoName',
                profilePic:
                    'https://cdn-icons-png.flaticon.com/128/847/847969.png')
            .toMap());
    DocumentSnapshot snapshot = await response.get();
    state = LocalUser(
        id: response.id,
        realtor: FirebaseUser.fromMap(snapshot.data() as Map<String, dynamic>));
  }

// Update Name

  Future<void> updateName(String name) async {
    await _firestore.collection("realtors").doc(state.id).update({'name': name,});
    state = state.copyWith(realtor: state.realtor.copyWith(name: name));
  }

  // Update Image
  Future<void> updateImage(File image) async {
    Reference ref = _storage.ref().child("realtors").child(state.id);
    TaskSnapshot snapshot = await ref.putFile(image);
    String profilePicUrl = await snapshot.ref.getDownloadURL();
    await _firestore
        .collection("realtors")
        .doc(state.id)
        .update({'profilePic': profilePicUrl});
    state = state.copyWith(realtor: state.realtor.copyWith(profilePic: profilePicUrl));
  }



  


 







// Logout

  void logOut() {
    state = LocalUser(
        id: "error",
        realtor: FirebaseUser(email: "error", name: 'error', profilePic: 'error'));
  }
}
