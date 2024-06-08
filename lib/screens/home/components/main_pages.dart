import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:realstate/provider/realtor_provider.dart';
import 'package:realstate/screens/home/components/chat.dart';
//import 'package:realstate/screens/home/components/drawer.dart';
import 'package:realstate/screens/home/components/favourite.dart';
import 'package:realstate/screens/home/components/notification.dart';
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
  String appBarTitle = 'Home';
  
  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 0) {
        appBarTitle = 'Home';
      } else if (_selectedIndex == 1) {
        appBarTitle = 'Chat';
      } else if (_selectedIndex == 2) {
        appBarTitle = 'Favorite';
      } else if (_selectedIndex == 3) {
        appBarTitle = 'Settings';
      }
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
        title: Text(appBarTitle),
        centerTitle: true,
        actions: [
          Stack(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Notifications()));
                  },
                  icon: Icon(
                    Icons.notifications,
                  )),
              Positioned(
                  top: 1,
                  left: 23,
                  bottom: 0,
                  right: 0,
                  child: Text(
                    '1',
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ))
            ],
          ),
          SizedBox(
            width: 10,
          ),
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => SearchPage())));
              },
              icon: Icon(Icons.search)),
          SizedBox(
            width: 10,
          )
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
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                          ref.watch(userProvider).realtor.profilePic),
                    ),
                    Text(ref.watch(userProvider).realtor.name)
                  ],
                )),
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
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        titleTextStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        title: const Text(
                          "GC 2024",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        content: Text(
                            " We are 2024 ASTU electrical and computer engineering GC Students"),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                "Close",
                                style: TextStyle(color: Colors.red),
                              ))
                        ],
                      );
                    });
                // Handle drawer item tap for search properties
              },
            ),
            ListTile(
              leading: Icon(Icons.code),
              title: Text('Developers'),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        titleTextStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        title: const Text(
                          "Developers",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        content: Column(
                          children: [
                            ListTile(
                              leading: CircleAvatar(
                                  radius: 30,
                                  child:
                                      Image.asset("assets/images/meron.jpg")),
                              title: Text(
                                "Merron",
                                style: TextStyle(fontSize: 20),
                              ),
                              subtitle: Text("Programmer"),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ListTile(
                              leading: CircleAvatar(
                                  radius: 30,
                                  child:
                                      Image.asset("assets/images/kidst.jpg")),
                              title: Text(
                                "Kidst",
                                style: TextStyle(fontSize: 20),
                              ),
                              subtitle: Text("UI Designer"),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ListTile(
                              leading: CircleAvatar(
                                  radius: 30,
                                  child: Image.asset("assets/images/hana.jpg")),
                              title: Text(
                                "Hanna",
                                style: TextStyle(fontSize: 20),
                              ),
                              subtitle: Text("Document Preparation"),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ListTile(
                              leading: CircleAvatar(
                                  radius: 30,
                                  child:
                                      Image.asset("assets/images/tsion.jpg")),
                              title: Text(
                                "Tsion",
                                style: TextStyle(fontSize: 20),
                              ),
                              subtitle: Text("Coordinator"),
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                "Close",
                                style: TextStyle(color: Colors.red),
                              ))
                        ],
                      );
                    });
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
