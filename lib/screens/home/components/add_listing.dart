import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:realstate/provider/house_provider.dart';
import 'package:realstate/provider/user_provider.dart';

class Add_Listing extends ConsumerStatefulWidget {
  @override
  ConsumerState<Add_Listing> createState() => _Add_ListingState();
}

class _Add_ListingState extends ConsumerState<Add_Listing> {
  final GlobalKey<FormState> _signInkey = GlobalKey();

  final TextEditingController addressController = TextEditingController();

  final TextEditingController priceController = TextEditingController();

  final TextEditingController square_feetController = TextEditingController();

  final TextEditingController bed_roomsController = TextEditingController();

  final TextEditingController bath_roomsController = TextEditingController();

  final TextEditingController kitchenController = TextEditingController();

  final TextEditingController garagesController = TextEditingController();

  final TextEditingController descriptionController = TextEditingController();
  final picker = ImagePicker();
  List<File> images = [];
  String image = '';

  Future<void> getImages() async {
    final pickedFiles = await picker.pickMultiImage();

    setState(() {
      images.addAll(pickedFiles.map((xfile) => File(xfile.path)).toList());
    });
  }

//single image

  Future<void> getImage() async {
    final ImagePicker picker = ImagePicker();
    // Pick an image.
    final XFile? pickedImage = await picker.pickImage(
        source: ImageSource.gallery, requestFullMetadata: false);
    if (pickedImage != null) {
      image = File(pickedImage.path) as String;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Add New Listing'),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back)),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Form(
                    key: _signInkey,
                    child: Stack(children: [
//Cover image
                      // GestureDetector(
                      //   onTap: () async {
                      //     getImage();
                      //   },
                      //   child: CircleAvatar(
                      //     radius: 100,
                      //     foregroundImage: NetworkImage(
                      //         ref.read(userProvider).user.profilePic),
                      //   ),
                      // ),

//List Image
                      GestureDetector(
                        onTap: () async {
                          getImages();
                        },
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.orange,
                                width: 2.0,
                              ),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100)),
                        ),
                      ),
                      Positioned(
                          top: 5,
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Icon(Icons.add_a_photo))
                    ]),
                  ),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: addressController,
                  decoration: InputDecoration(
                    labelText: 'Adress',
                    hintText: 'Enter the adress',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 2.0),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: priceController,
                  decoration: InputDecoration(
                    labelText: 'Price',
                    hintText: 'Enter the price',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 2.0),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: square_feetController,
                  decoration: InputDecoration(
                    labelText: 'Square Feet',
                    hintText: 'Enter the square feet',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 2.0),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: bed_roomsController,
                  decoration: InputDecoration(
                    labelText: 'Bedrooms',
                    hintText: 'number of bed rooms',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 2.0),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: bath_roomsController,
                  decoration: InputDecoration(
                    labelText: 'Bath Room',
                    hintText: 'Enter number of bathrooms',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 2.0),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: kitchenController,
                  decoration: InputDecoration(
                    labelText: 'Kitchen',
                    hintText: 'Enter number of kithcen',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 2.0),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: garagesController,
                  decoration: InputDecoration(
                    labelText: 'Garages',
                    hintText: 'Enter the garages',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 2.0),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: descriptionController,
                  maxLines: 7,
                  decoration: InputDecoration(
                    labelText: 'Desription',
                    hintText: 'Enter the description',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 2.0),
                    ),
                  ),
                ),
                SizedBox(height: 24.0),
                ElevatedButton(
                  onPressed: () async {
                    // Add your save button logic here

                    await ref.watch(houseProvider).postHouse(
                          //image,

                          images,
                          //image,
                          addressController.text,
                          double.parse(priceController.text),
                          int.parse(bed_roomsController.text),
                          int.parse(bath_roomsController.text),
                          int.parse(square_feetController.text),
                          int.parse(kitchenController.text),
                          int.parse(garagesController.text),
                          descriptionController.text,
                          false,
                          'pending...'
                        );
                    addressController.clear();
                    priceController.clear();
                    bed_roomsController.clear();
                    bath_roomsController.clear();
                    square_feetController.clear();
                    kitchenController.clear();
                    garagesController.clear();
                    descriptionController.clear();
                  
                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.orange),
                  ),
                  child: Text(
                    'Upload',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
