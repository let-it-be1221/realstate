import 'package:flutter/material.dart';
//import 'package:realstate/screens/home/components/bottom_buttons.dart';
 
import 'package:realstate/screens/home/components/custom_app_bar.dart';
import 'package:realstate/screens/home/components/houses.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
 
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            children: [
             // CustomAppBar(),
              //Categories(),
              Houses(),
            ],
          ),
         // BottomButtons(),
        ],
      ),
    );
  }
}
