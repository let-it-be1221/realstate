import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:realstate/model/house.dart';
import 'package:realstate/screens/details/components/bottom_buttons.dart';
import 'package:realstate/screens/details/components/carousel_images.dart';
import 'package:realstate/screens/details/components/custom_app_bar.dart';
import 'package:realstate/screens/details/components/house_details.dart';

class DetailsScreen extends StatelessWidget {
final House house;
  final int initialIndex;
  

  const DetailsScreen({required this.house, required this.initialIndex}) ;

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            children: [
              Stack(
                children: [
                  CarouselImages(house: house, initialIndex: initialIndex),
                  CustomAppBar(),
                ],
              ),
              HouseDetails(initialIndex),
            ],
          ),
          BottomButtons(initialIndex),
        ],
      ),
    );
  }
}
