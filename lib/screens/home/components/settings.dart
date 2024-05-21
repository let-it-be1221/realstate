import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:realstate/provider/user_provider.dart';
import 'package:realstate/screens/home/components/add_listing.dart';
import 'package:realstate/screens/home/components/edit_profile.dart';
import 'package:realstate/screens/home/components/pdf.dart';
import 'package:realstate/screens/home/components/support_page.dart';

class Settings extends ConsumerStatefulWidget {
  const Settings({super.key});

  @override
  ConsumerState<Settings> createState() => _SettingsState();
}

class _SettingsState extends ConsumerState<Settings> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        
        title: Text(
          "Settings",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [


           // Text("Settings",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20, color: Colors.red),),
           Divider(
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(ref.watch(userProvider).user.profilePic),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    ref.watch(userProvider).user.name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                SizedBox(width: 50),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(100)),
                  child: IconButton(
                      onPressed: () {
                        Navigator.push(context,  MaterialPageRoute(builder: (context)=>Edit_Profile()));
                      },
                      icon: Icon(
                        Icons.edit,
                        color: Colors.white,
                      )),
                ),
                SizedBox(width: 15,),
              ],
            ),
            ListTile(
              title: Text('My Listings'),
              trailing:
                  IconButton(onPressed: () {}, icon: Icon(Icons.arrow_forward)),
            ),
            Divider(
              indent: 15,
              endIndent: 10,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                SizedBox(
                  width: 15,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "ABOUT",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
                trailing:
                    IconButton(onPressed: () 
                    {
 Navigator.push(context, MaterialPageRoute(builder: ((context) => Pdf(path: 'assets/images/Realtor_Privacy.pdf', text: "Privacy Policy"))));
                    }, 
                    icon: Icon(Icons.arrow_forward)),
                leading: Text(
                  "Privacy Policy",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                )),
            Divider(
              indent: 15,
              endIndent: 10,
            ),
            ListTile(
                trailing:
                    IconButton(
                      onPressed: () 
                      {
                       Navigator.push(context, MaterialPageRoute(builder: ((context) => Pdf(path: 'assets/images/Terms_of_Use.pdf', text: "Terms Of Use"))));
                      },
                       icon: Icon(Icons.arrow_forward)),
                leading: Text(
                  "Terms of use",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                )),
            Divider(
              indent: 15,
              endIndent: 10,
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                SizedBox(
                  width: 15,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "APP",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            ListTile(
                trailing:
                    IconButton(onPressed: () {
                   Navigator.push(context, MaterialPageRoute(builder: ((context) => SupportPage())));   
                    }, icon: Icon(Icons.arrow_forward)),
                leading: Text(
                  "Support",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                )),
            Divider(
              indent: 15,
              endIndent: 10,
            ),
            ListTile(
                trailing:
                    IconButton(onPressed: () {}, icon: Icon(Icons.arrow_forward)),
                leading: Text(
                  "Report a Bug",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                )),
            Divider(
              indent: 15,
              endIndent: 10,
            ),
            ListTile(
                trailing:
                    IconButton(onPressed: () {}, icon: Icon(Icons.arrow_forward)),
                leading: Text(
                  "App Version 1.0",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                )),
            Divider(
              indent: 15,
              endIndent: 10,
            ),
            SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () {},
              child: Row(
                children: [
                  SizedBox(
                    width: 15,
                  ),
                  Icon(Icons.logout_rounded),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: (){
                      FirebaseAuth.instance.signOut();
                ref.watch(userProvider.notifier).logOut();
                    },
                    child: Text(
                      "Logout",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  SizedBox(height: 20,),
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()
         {
          Navigator.push(context, MaterialPageRoute(builder: ((context) => Add_Listing())));
         },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
              Radius.circular(100)), // Adjust the radius to your desired shape
        ),
        backgroundColor: Colors.red,
      ),
    ));
  }
}
