import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:realstate/constants/constants.dart';
import 'package:realstate/firebase_options.dart';
import 'package:realstate/provider/user_provider.dart';
import 'package:realstate/screens/home/components/login.dart';
import 'package:realstate/screens/home/components/main_pages.dart';
import 'package:realstate/screens/home/components/settings.dart';
import 'package:realstate/screens/home/home_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ProviderScope(child:MyApp()));

   
}

class MyApp extends ConsumerWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Real Estate App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: white
      ),
     // home: MainPage(),
     home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              ref.watch(userProvider.notifier).login(snapshot.data!.email!);
              return MainPage();
            }
            return Login();
          }
          ),
    );
  }
}

 