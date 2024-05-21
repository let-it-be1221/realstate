import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:realstate/provider/user_provider.dart';

class Edit_Profile extends ConsumerWidget {
  final TextEditingController _nameController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Edit Profile'),
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
                  child: Stack(children: [
                    CircleAvatar(
                      radius: 70.0,
                      backgroundImage: NetworkImage(ref
                          .watch(userProvider)
                          .user
                          .profilePic), // Replace with your desired image
                      // child: Align(
                      //   alignment: Alignment.bottomRight,
                      //   child: IconButton(
                      //     onPressed: () {
                      //       // Add your camera button logic here
                      //     },
                      //     icon: Icon(Icons.camera_alt),
                      //     tooltip: 'Take a photo',
                      //   ),
                      // ),
                    ),
                    Positioned(
                        top: 110,
                        left: 0,
                        bottom: 0,
                        right: 0,
                        child: Container(
                          child: ElevatedButton(
                            onPressed: () async {
                              final ImagePicker picker = ImagePicker();
                              // Pick an image.
                              final XFile? pickedImage = await picker.pickImage(
                                  source: ImageSource.gallery,
                                  requestFullMetadata: false);
                              if (pickedImage != null) {
                                ref
                                    .read(userProvider.notifier)
                                    .updateImage(File(pickedImage.path));
                              }
                              // Add your save button logic here
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.orange),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Change",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        ))
                  ]),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    hintText: 'Enter your name',
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
                  onPressed: () {
                    ref
                        .watch(userProvider.notifier)
                        .updateName(_nameController.text);
                    // Add your save button logic here
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.orange),
                  ),
                  child: Text(
                    'Update',
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
