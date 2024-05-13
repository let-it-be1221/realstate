import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:realstate/constants/constants.dart';
import 'package:realstate/model/house.dart';
import 'package:realstate/provider/house_provider.dart';
import 'package:realstate/screens/details/details_screen.dart';

class Houses extends ConsumerStatefulWidget {
  @override
  _HousesState createState() => _HousesState();
}

class _HousesState extends ConsumerState<Houses> {
  // isFav = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return
        // Expanded(
        //   child: ListView.builder(
        //     physics: BouncingScrollPhysics(),
        //     itemCount: 2,
        //     itemBuilder: (context, index) {
        //       return _buildHouse(context, index);
        //     },
        //   ),
        // );

        Expanded(
      child: ref.watch(feedProvider).when(
          data: (List<House> house_list) {
            print(
              house_list[0].price.toString(),
            );
            return ListView.builder(
                itemCount: house_list.length,
                itemBuilder: (context, index) {
                  final house = house_list[index];
                  // final List<String> imageUrls = List<String>.from(house.imageUrls.cast<String>());
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              DetailsScreen(house: house, initialIndex: index),
                        ),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: appPadding, vertical: appPadding / 2),
                      child: Container(
                        height: 250,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image(
                                    height: 180,
                                    width: size.width,
                                    fit: BoxFit.cover,
                                    image: NetworkImage(house.imageUrls[0]),
                                  ),
                                ),
                                Positioned(
                                  right: appPadding / 2,
                                  top: appPadding / 2,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: white,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child:
IconButton(
  icon: Icon(
    house.isFav ? Icons.favorite : Icons.favorite_border,
    color: house.isFav ? Colors.red : null,
  ),
  onPressed: () {
    final houseApi = ref.read(houseProvider);
    if (house.isFav) {
      houseApi.removeFromFavorites(house);
    } else {
      houseApi.addToFavorites(house);
    }
  },
),

                                    //  IconButton(
                                    //   icon: Icon(Icons.favorite_rounded),
                                    //   color: house.isFav
                                    //       ? Colors.red
                                    //       : Colors.grey,
                                    //   // icon: house.isFav
                                    //   //     ? Icon(
                                    //   //         Icons.favorite_rounded,
                                    //   //         color: red,
                                    //   //       )
                                    //   //     : Icon(
                                    //   //         Icons.favorite_border_rounded,
                                    //   //         color: black,
                                    //   //       ),
                                    //   onPressed: () {
                                    //     setState(() {
                                    //       ///house.isFav = !house.isFav;
                                    //       if (house.isFav) {
                                    //         ref
                                    //             .watch(houseProvider)
                                    //             .addToFavorites(house);
                                    //       } else
                                    //         ref
                                    //             .watch(houseProvider)
                                    //             .removeFromFavorites(house);
                                    //     });
                                    //   },
                                    // ),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  house.price.toStringAsFixed(3),
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Text(
                                    house.address,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: black.withOpacity(0.4)),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  house.bed_rooms.toStringAsFixed(3),
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  house.bath_rooms.toStringAsFixed(3),
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  house.square_feet.toStringAsFixed(3),
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                });
          },
          error: (error, stackTrace) {
            print("Error: $error");
            return const Center(child: Text("error"));
          },
          loading: () => const CircularProgressIndicator()),
    );
  }
}
