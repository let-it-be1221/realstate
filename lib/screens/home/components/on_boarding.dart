 
 import 'package:flutter/material.dart';
import 'package:realstate/screens/home/components/main_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';
 
 class OnboardingScreen extends StatelessWidget {
  final List<String> onboardingItems = [
    'Onboarding Item 1',
    'Onboarding Item 2',
    'Onboarding Item 3',
  ];

  Future<void> _completeOnboarding(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seenOnboarding', true);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MainPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: PageView.builder(
              itemCount: onboardingItems.length,
              itemBuilder: (context, index) {
                return Container(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        onboardingItems[index],
                        style: TextStyle(fontSize: 24.0),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () => _completeOnboarding(context),
            child: Text('Continue'),
          ),
        ],
      ),
    );
  }
}