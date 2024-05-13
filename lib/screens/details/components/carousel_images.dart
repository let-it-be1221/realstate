//import 'package:carousel_pro/carousel_pro.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:realstate/model/house.dart';

class CarouselImages extends StatelessWidget {
  final House house;
  final int initialIndex;

  CarouselImages({required this.house, required this.initialIndex});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.35,
      child: CarouselSlider(
        options: CarouselOptions(
          viewportFraction: 0.8,
          enableInfiniteScroll: true,
          aspectRatio: 16 / 9,
          enlargeCenterPage: true,
          autoPlayCurve: Curves.fastOutSlowIn,
          //  dotSize: 5,
          //dotBgColor: Colors.transparent,
          autoPlay: true,
          autoPlayAnimationDuration: Duration(milliseconds: 800),
        ),
        items:
            // [
            //   Image.asset('assets/images/house1.jpeg'),
            //   Image.asset('assets/images/house2.jpeg'),
            //   Image.asset('assets/images/house3.jpeg'),
            //   Image.asset('assets/images/house4.png'),
            //   Image.asset('assets/images/house5.jpeg'),
            // ],

            house.imageUrls.map((imageUrl) {
          return Image.network(
            imageUrl,
            fit: BoxFit.cover,
          );
        }).toList(),
      ),
    );
  }
}
