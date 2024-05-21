import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:realstate/constants/constants.dart';
import 'package:realstate/model/house.dart';
import 'package:realstate/provider/house_provider.dart';
import 'package:realstate/provider/user_provider.dart';

class HouseDetails extends ConsumerStatefulWidget {
  final int index;
  HouseDetails(this.index);
  int? phoneNumber;
  @override
  // ignore: library_private_types_in_public_api
  _HouseDetailsState createState() => _HouseDetailsState();
}

class _HouseDetailsState extends ConsumerState<HouseDetails> {
  @override
  Widget build(BuildContext context) {
    // final house = ref.watch(feedProvider);
    //String price = house.price;
    return Expanded(
      child:

          ////////////////////////////////////

          ref.watch(feedProvider).when(
                data: (List<House> house_list) {
                  return ListView(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: appPadding,
                          left: appPadding,
                          right: appPadding,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  house_list[widget.index].price.toString(),
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  house_list[widget.index].address,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: black.withOpacity(0.4),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              '${DateFormat(' HH').format(house_list[widget.index].postTime.toDate())} hours ago',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: appPadding, bottom: appPadding),
                        child: Text(
                          'House information',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        height: 130,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                left: appPadding,
                                bottom: appPadding,
                              ),
                              child: Container(
                                width: 100,
                                decoration: BoxDecoration(
                                    color: white,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: black.withOpacity(0.4),
                                    )),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      house_list[widget.index]
                                          .square_feet
                                          .toString(),
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Square foot',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: appPadding,
                                bottom: appPadding,
                              ),
                              child: Container(
                                width: 100,
                                decoration: BoxDecoration(
                                    color: white,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: black.withOpacity(0.4),
                                    )),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      house_list[widget.index]
                                          .bed_rooms
                                          .toString(),
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Bedrooms',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: appPadding,
                                bottom: appPadding,
                              ),
                              child: Container(
                                width: 100,
                                decoration: BoxDecoration(
                                    color: white,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: black.withOpacity(0.4),
                                    )),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      house_list[widget.index]
                                          .bath_rooms
                                          .toString(),
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Bathrooms',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: appPadding,
                                bottom: appPadding,
                              ),
                              child: Container(
                                width: 100,
                                decoration: BoxDecoration(
                                    color: white,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: black.withOpacity(0.4),
                                    )),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      house_list[widget.index]
                                          .garages
                                          .toString(),
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Garages',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: appPadding,
                          right: appPadding,
                          bottom: appPadding * 4,
                        ),
                        child: Text(
                          house_list[widget.index].description,
                          style: TextStyle(
                            color: black.withOpacity(0.4),
                            height: 1.5,
                          ),
                        ),
                      )
                    ],
                  );

                  // },
                  // );
                },
                error: (error, stackTrace) {
                  print("Error: $error");
                  return const Center(
                    child: Text("error"),
                  );
                },
                loading: () => const CircularProgressIndicator(),
              ),
    );
  }
}
