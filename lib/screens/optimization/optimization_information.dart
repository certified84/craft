import 'package:craft/components/buttons.dart';
import 'package:craft/components/optimization.dart';
import 'package:craft/data/model/facility.dart';
import 'package:craft/data/model/optimization.dart';
import 'package:craft/screens/home.dart';
import 'package:flutter/material.dart';
import '../../theme/colors.dart' as craft_colors;

class OptimizationInformationScreen extends StatefulWidget {
  const OptimizationInformationScreen({super.key});
  static const routeName = '/optimizationInformationArguments';

  @override
  State<StatefulWidget> createState() => _OptimizationInformationScreenState();
}

class _OptimizationInformationScreenState
    extends State<OptimizationInformationScreen> {
  late double _deviceHeight, _deviceWidth;
  final List<Optimization> optimizations = [
    Optimization(4200, "A", "B"),
    Optimization(4150, "C", "D"),
    Optimization(3460, "C", "B"),
    Optimization(2190, "A", "D"),
  ];
  OptimizationArgument? optimizationArgument;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    optimizationArgument =
        ModalRoute.of(context)!.settings.arguments as OptimizationArgument?;

    return Scaffold(
      body: Container(
        color: craft_colors.Colors.white,
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.only(
              left: _deviceWidth * 0.05,
              right: _deviceWidth * 0.05,
              bottom: _deviceHeight * .02,
              top: _deviceHeight * .02,
            ),
            height: _deviceHeight,
            width: _deviceWidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        4,
                        (index) => Expanded(
                          child: Container(
                            margin: EdgeInsets.only(right: index < 3 ? 8 : 0),
                            height: 12,
                            color: craft_colors.Colors.primary,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    const Text(
                      "Optimization Information",
                      style: TextStyle(
                        color: craft_colors.Colors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: _deviceHeight * .05),
                    const Text(
                      "After performing the CRAFT iteration and optimization process, the following results were obtained:",
                      style: TextStyle(
                        color: craft_colors.Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: _deviceHeight * .03),
                    ...optimizations
                        .map((e) => OptimizationComponent(e))
                        .toList(),
                    SizedBox(height: _deviceHeight * .03),
                    const Text(
                      "Based on the results obtained, swap department A with D to achieve the most optimized layout",
                      style: TextStyle(
                        color: craft_colors.Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                defaultButton(
                  width: _deviceWidth,
                  text: "Finish",
                  backgroundColor: craft_colors.Colors.primary,
                  onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ),
                    (Route<dynamic> route) => false,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
