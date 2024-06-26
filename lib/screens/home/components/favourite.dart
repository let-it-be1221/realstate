import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:realstate/constants/constants.dart';
//import 'package:realstate/model/house.dart';
import 'package:realstate/provider/house_provider.dart';
import 'package:realstate/screens/details/details_screen.dart';

class FavoritePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(houseProvider).favoriteHousesStream;
     Size size = MediaQuery.of(context).size;

    return Scaffold(
        // appBar: AppBar(
        //   title: Text('Favorites'),
        // ),
        body: StreamBuilder(
            stream: favorites,
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No favorites yet'));
              } else {
                final favorites = snapshot.data!;
                return ListView.builder(
                  itemCount: favorites.length,
                  itemBuilder: (context, index) {
                    final house = favorites[index];
                    return
                     GestureDetector(
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
                                      child: IconButton(
                                        onPressed: () {
                                          final houseApi =
                                              ref.read(houseProvider);
                                          if (house.isFav) {
                                            houseApi.removeFromFavorites(house);
                                          } else {
                                            houseApi.addToFavorites(house);
                                          }
                                        },
                                        icon: Icon(
                                          house.isFav
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          color:
                                              house.isFav ? Colors.red : null,
                                        ),
                                      )),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'Price   ${house.price} birr',
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
                                    'Address    ${house.address}',
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
                                  'Bed rooms  ${house.bed_rooms.toString()}',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  'Bath rooms ${house.bath_rooms.toString()}',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  'Feet ${house.square_feet.toString()}',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
SizedBox(
                                  width:15,
                                ),
Container(
  height: 20,
  width: 48,
  decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color: Colors.red),
  child: Text(house.type,style: TextStyle(fontSize: 15,color: Colors.white),textAlign: TextAlign.center,),
)

                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                  },
                );
              }
            })));
  }
}
