import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:craft/screens/onboarding.dart';

void main() {
  runApp(const App(OnboardingScreen()));
}

class App extends StatelessWidget {
  final Widget home;
  const App(this.home, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: "Futa-Map",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF9FAFB),
      ),
      home: home,
      routes: {
        // PlaceDetailScreen.routeName: (context) => const PlaceDetailScreen(),
        // NavigationScreen.routeName: (context) => const NavigationScreen(),
      },
    );
  }
}
