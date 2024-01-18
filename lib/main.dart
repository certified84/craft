import 'package:craft/screens/optimization/flow_metric_information.dart';
import 'package:craft/screens/optimization/optimization_information.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:craft/screens/onboarding.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:craft/notifiers/single_notifier.dart';

void main() async {
  await Hive.initFlutter("craftify");
  await Hive.openBox("craftify");
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<SingleNotifier>(
          create: (_) => SingleNotifier([""]))
    ],
    child: const App(home: OnboardingScreen()),
  ));
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
      title: "CRAFTify",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF9FAFB),
      ),
      home: home,
      routes: {
        // HomeScreen.routeName: (context) => const HomeScreen(),
        FlowMetricInformationScreen.routeName: (context) =>
            const FlowMetricInformationScreen(),
        OptimizationInformationScreen.routeName: (context) =>
            const OptimizationInformationScreen(),
      },
    );
  }
}
