import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:realstate/provider/house_provider.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  void _handleSearch() {
    String address = _searchController.text.trim();
    if (address.isNotEmpty) {
      ref.watch(houseProvider).searchProperties(address);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          margin: EdgeInsets.all(8),
          // padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 237, 234, 234),
              borderRadius: BorderRadius.circular(30)),
          child: TextFormField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: "write here to search",
              contentPadding: EdgeInsets.only(left: 15),
              border: InputBorder.none,
            ),
          ),
        ),
        Positioned(
          right: 15,
          top: 14,
          child: IconButton(
              onPressed: () {
                _handleSearch();
              },
              icon: Icon(Icons.search)),
        )
      ]),
    );
  }
}
