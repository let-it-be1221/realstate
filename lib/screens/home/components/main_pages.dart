import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:realstate/provider/user_provider.dart';
import 'package:realstate/screens/home/components/chat.dart';
import 'package:realstate/screens/home/components/drawer.dart';
import 'package:realstate/screens/home/components/favourite.dart';
import 'package:realstate/screens/home/components/search_page.dart';
import 'package:realstate/screens/home/components/settings.dart';
import 'package:realstate/screens/home/home_screen.dart';

class MainPage extends ConsumerStatefulWidget {
  MainPage({super.key});

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  int _selectedIndex = 0;
  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    HomeScreen(),
    Chat(),
    FavoritePage(),
    Settings(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //     onPressed: () {
        //   //Navigator.push(context, MaterialPageRoute(builder: ((context) => RealtorDrawer())));
        //       // showDialog(
        //       //   context: context,
        //       //   builder: (BuildContext context) {
        //       //     return AlertDialog(
        //       //       title: Text('Merry The Angel With Many Wings'),
        //       //       content:
        //       //           Text("Merry! You Know We Can Do It! Never Give Up"),
        //       //       actions: [Text('One Love')],
        //       //     );
        //       //   },
        //       // );
        //     },
        //     icon: Icon(Icons.menu)),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => SearchPage())));
              },
              icon: Icon(Icons.search))
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _navigateBottomBar,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: const Color.fromARGB(255, 241, 55, 117),
                ),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.chat,
                  color: const Color.fromARGB(255, 241, 55, 117),
                ),
                label: 'Chat'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.favorite,
                  color: const Color.fromARGB(255, 241, 55, 117),
                ),
                label: 'Favorite'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings,
                  color: const Color.fromARGB(255, 241, 55, 117),
                ),
                label: 'Settings'),
          ]),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child:  CircleAvatar(
                backgroundImage: const AssetImage('assets/images/user.png'),
              )
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                // Handle drawer item tap for home
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.search),
              title: Text('Search Properties'),
              onTap: () {
                // Handle drawer item tap for search properties
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => SearchPage())));
              },
            ),
            ListTile(
              leading: Icon(Icons.favorite),
              title: Text('Favorites'),
              onTap: () {
                // Handle drawer item tap for favorites
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => FavoritePage())));
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                // Handle drawer item tap for settings
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => Settings())));
              },
            ),
Divider(
  height: 2,
),
             ListTile(
              leading: Icon(Icons.history),
              title: Text('Aboout Us'),
              onTap: () {
                // Handle drawer item tap for search properties
                 
              },
            ),


             ListTile(
              leading: Icon(Icons.code),
              title: Text('Developers'),
              onTap: () {
                // Handle drawer item tap for search properties
                 
              },
            ),

             ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                // Handle drawer item tap for search properties
               FirebaseAuth.instance.signOut();
                ref.watch(userProvider.notifier).logOut();
              },
            ),
          ],
        ),
      ),
    );
  }
}
