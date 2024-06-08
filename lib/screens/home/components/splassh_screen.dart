
import 'package:flutter/material.dart';
import 'package:realstate/screens/home/components/main_pages.dart';
import 'package:realstate/screens/home/components/on_boarding.dart';
import 'package:shared_preferences/shared_preferences.dart';


 class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SharedPreferences? _prefs;

  @override
  void initState() {
    super.initState();
    initializePreferences();
  }

  Future<void> initializePreferences() async {
    _prefs = await SharedPreferences.getInstance();
    bool? seenOnboarding = _prefs!.getBool('seenOnboarding');
    if (seenOnboarding == null || !seenOnboarding) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => OnboardingScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:  Image.asset('assets/images/splash.png')
      ),
    );
  }
}