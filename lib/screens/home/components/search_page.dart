import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:realstate/provider/house_provider.dart';
import 'package:realstate/screens/details/details_screen.dart';

import '../../../constants/constants.dart';
import '../../../model/house.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  // void _handleSearch() {
  //   String address = _searchController.text.trim();
  //   if (address.isNotEmpty) {
  //     ref.watch(houseProvider).searchProperties(address);
  //   }
  // }
  String address = '';
  int selectedIndex = -1;
  House house = House(
    uid: '',
   address: '',
    price: 0,
    
     bed_rooms: 0, 
     
     bath_rooms: 0, 
     square_feet: 0, 
     kitchen: 0,
      garages: 0,
       description: '', 
       imageUrls: [],
        postTime: Timestamp.now(), 
        isFav: false, 
        
        status: false,
         phone_number: 0,
          type: '');
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Card(
            child: TextFormField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search...',
                border: InputBorder.none
              ),
              onChanged: (value) {
                setState(() {
                  address = value;
                });
              },
            ),
          ),
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('houses').snapshots(),
            builder: (context, snapshots) {
              return (snapshots.connectionState == ConnectionState.waiting)
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      itemCount: snapshots.data!.docs.length,
                      itemBuilder: ((context, index) {
                        var data = snapshots.data!.docs[index].data()
                            as Map<String, dynamic>;
                        if (address.isEmpty) {
                          return
//                         ListTile(
//   title: Text(data['type'] != null ? data['type'] : ''),
//   subtitle: Text(data['address'] != null ? data['address'] : ''),
//   leading: CircleAvatar(
//     backgroundImage: data['imageUrls[0]'] != null
//         ? NetworkImage(data['imageUrls[0]']!)
//         : AssetImage('assets/images/hi.jpg') as ImageProvider,
//   ),
// );

                              Center(
                            child: Text("Nothing is Searched"),
                          );
                        } else if (data['address']
                            .toString()
                            .toLowerCase()
                            .startsWith(address.toLowerCase())) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedIndex =
                                    index; // Update the selected house index
                              });
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => DetailsScreen(
                                      house: house, initialIndex: index),
                                ),
                              );
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: appPadding,
                                  vertical: appPadding / 2),
                              child: Container(
                                height: 250,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Image(
                                            height: 180,
                                            width: size.width,
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                data['imageUrls[0]'] != null
                                                    ? data['imageUrls[0]']
                                                    : ''),
                                          ),
                                        ),
                                        Positioned(
                                          right: appPadding / 2,
                                          top: appPadding / 2,
                                          child: Container(
                                              decoration: BoxDecoration(
                                                  color: white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
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
                                               // icon: Icon(Icons.favorite),
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
                                          'Price   ${data['price'] != null ? data['price'] : ''} birr',
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
                                            'Address    ${data['address'] != null ? data['address'] : ''}',
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
                                          'Bed rooms  ${data['bed_rooms'] != null ? data['bed_rooms'].toString() : ''}',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Text(
                                          'Bath rooms ${data['bath_rooms'] != null ? data['bath_rooms'].toString() : ''}',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Text(
                                          'Feet ${data['square_feet'] != null ? data['square_feet'].toString() : ''}',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Container(
                                          height: 20,
                                          width: 48,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              color: Colors.red),
                                          child: Text(
                                            data['type'] != null
                                                ? data['type']
                                                : '',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white),
                                            textAlign: TextAlign.center,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                      }));
            }));
  }
}
