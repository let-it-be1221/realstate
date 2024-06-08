import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:realstate/model/house.dart';
import 'package:realstate/model/support.dart';
import 'package:realstate/provider/realtor_provider.dart';

final feedProvider = StreamProvider.autoDispose<List<House>>((ref) {
  return FirebaseFirestore.instance
      .collection("houses")
      .orderBy('postTime', descending: true)
      .snapshots()
      .map((QuerySnapshot<Map<String, dynamic>> event) {
    List<House> house_list = [];
    for (int i = 0; i < event.docs.length; i++) {
      house_list.add(House.fromMap(event.docs[i].data()));
    }
    return house_list;
  });
});

final houseProvider = Provider<HouseApi>((ref) {
   
  return HouseApi(ref);
});

class HouseApi {
  HouseApi(this.ref);
  final Ref ref;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> postHouse(
    List<File> images,
    //String image,
    String address,
    double price,
    int bed_rooms,
    int bath_rooms,
    int square_feet,
    int kitchen,
    int garages,
    String description,
    bool isFav,
    bool status,
    int phone_number,
    String type,
  ) async {
   // LocalUser currentUser = ref.read(userProvider);
    List<String> imageUrls = [];

    for (int i = 0; i < images.length; i++) {
      File image = images[i];
      String imageName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference ref = _storage.ref().child('houses').child(imageName);
      TaskSnapshot snapshot = await ref.putFile(image);
      String imageUrl = await snapshot.ref.getDownloadURL();
      imageUrls.add(imageUrl);
    }

    // String imageName = DateTime.now().millisecondsSinceEpoch.toString();
    // Reference imageref = _storage.ref().child("houses").child(imageName);
    // TaskSnapshot snapshot = await imageref.putFile(image as File);
    // String imageUrl = await snapshot.ref.getDownloadURL();

    //CollectionReference houseRef =
    final docRef = await _firestore
        .collection('houses')
        // await houseRef.doc(currentUser.id).collection('houseList')
        .add(House(
          uid: '',
          address: address,
          price: price,
          bed_rooms: bed_rooms,
          bath_rooms: bath_rooms,
          square_feet: square_feet,
          kitchen: kitchen,
          garages: garages,
          description: description,
          imageUrls: imageUrls,
          postTime: Timestamp.now(),
          isFav: isFav,
          status: status,
          phone_number: phone_number,
          type: type,
        ).toMap());

    final houseUid = docRef.id;
    //print(houseUid);
    await docRef.update({'uid': houseUid});
  }

  Stream<List<House>> get favoriteHousesStream {
    return _firestore
        .collection('houses')
        //.where('uid', isEqualTo: house.uid)
        .where('isFav', isEqualTo: true)
        .snapshots()
        .map((QuerySnapshot<Map<String, dynamic>> snapshot) {
      return snapshot.docs
          .map((QueryDocumentSnapshot<Map<String, dynamic>> doc) {
        return House.fromMap(doc.data());
      }).toList();
    });
  }



  Future<void> requestSupport(String name, String email, String subject) async {
    LocalUser currentUser = ref.read(userProvider);

    CollectionReference reference = await _firestore.collection("support");
    await reference
        .doc(currentUser.id)
        .collection('subject')
        .add(Support(name: name, email: email, subject: subject).toMap());
  }

  Future<void> searchProperties(String address) async {
    try {
      final QuerySnapshot snapshot = await _firestore
          .collection('houses')
          .where('address', isEqualTo: address)
          .get();

      if (snapshot.docs.isNotEmpty) {
        print('yesjhkkkkkkkk');
        // Handle search results
        // Access the documents using snapshot.docs
      } else {
        // No matching results found
        print("Noooooooooooooo");
      }
    } catch (e) {
      // Handle error
    }
  }

  Future<void> addToFavorites(House house) async {
    // House house = ref.read(houseProvider as ProviderListenable<House>);

    try {
      final docSnapshot =
          await _firestore.collection('houses').doc(house.uid).get();
      if (docSnapshot.exists) {
        await _firestore
            .collection('favorites')
            .doc(house.uid)
            .set(house.toMap());

        await _firestore
            .collection('houses')
            .doc(house.uid)
            .update({'isFav': true});
        house.toggleFavorite();
      } else {
        print('Document not found');
      }
    } catch (error) {
      print('Error adding to favorites: $error');
    }
  }

  Future<void> removeFromFavorites(House house) async {
    try {
      final docSnapshot =
          await _firestore.collection('houses').doc(house.uid).get();

      if (docSnapshot.exists) {
        await _firestore.collection('favorites').doc(house.uid).delete();
        await _firestore
            .collection('houses')
            .doc(house.uid)
            .update({'isFav': false});
        house.toggleFavorite();
      } else {
        print('Document not found');
      }
    } catch (error) {
      print('Error removing from favorites: $error');
    }
  }


Future<void> approve(uid) async
{
  try{
final docSnapshot =
          await _firestore.collection('houses').doc(uid).get();
          if(docSnapshot.exists)
          {
            await _firestore
            .collection('houses')
            .doc(uid)
            .update({'status': true});
          }


  }catch(error)
  {

  }
}


Future<void> reject(uid) async
{
  try {
      final docSnapshot =
          await _firestore.collection('houses').doc(uid).get();

      if (docSnapshot.exists) {
        await _firestore.collection('houses').doc(uid).delete();
       
      }  
    } catch (error) {
      print('Error removing from favorites: $error');
    }
}





/////////////////////////////////

// Future<void> addToFavorites(House house) async {
//     try {
//       final user = FirebaseAuth.instance.currentUser;
//       if (user != null) {
//         final userId = user.uid;
//         final houseRef = _firestore
//             .collection('favorites')
//             .doc(userId)
//             .collection('favorites')
//             .doc(house.uid);

//         final docSnapshot = await houseRef.get();
//         if (!docSnapshot.exists) {
//           await houseRef.set(house.toMap());
//           await _firestore
//               .collection('houses')
//               .doc(house.uid)
//               .update({'isFav': true});
//         } else {
//           print('House is already in favorites');
//         }
//       } else {
//         print('User is not signed in');
//       }
//     } catch (error) {
//       print('Error adding to favorites: $error');
//     }
//   }

//   Future<void> removeFromFavorites(House house) async {
//     try {
//       final user = FirebaseAuth.instance.currentUser;
//       if (user != null) {
//         final userId = user.uid;
//         final houseRef = _firestore
//             .collection('favorites')
//             .doc(userId)
//             .collection('favorites')
//             .doc(house.uid);

//         final docSnapshot = await houseRef.get();
//         if (docSnapshot.exists) {
//           await houseRef.delete();
//           await _firestore
//               .collection('houses')
//               .doc(house.uid)
//               .update({'isFav': false});
//         } else {
//           print('House is not in favorites');
//         }
//       } else {
//         print('User is not signed in');
//       }
//     } catch (error) {
//       print('Error removing from favorites: $error');
//     }
//   }
}
