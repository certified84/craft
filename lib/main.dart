import 'package:craft/screens/home.dart';
import 'package:craft/screens/optimization/distance_information.dart';
import 'package:craft/screens/optimization/flow_metric_information.dart';
import 'package:craft/screens/optimization/optimization_information.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:craft/screens/onboarding.dart';

void main() {
  runApp(const App(home: OnboardingScreen()));
}

class App extends StatelessWidget {
  final Widget? home;
  const App({
    Key? key,
    this.home,
  }) : super(key: key);

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
        // HomeScreen.routeName: (context) => const HomeScreen(),
        FlowMetricInformationScreen.routeName: (context) =>
            const FlowMetricInformationScreen(),
        DistanceInformationScreen.routeName: (context) =>
            const DistanceInformationScreen(),
        OptimizationInformationScreen.routeName: (context) =>
            const OptimizationInformationScreen(),
      },
    );
  }
}
