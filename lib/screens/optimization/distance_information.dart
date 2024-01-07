import 'package:craft/components/buttons.dart';
import 'package:craft/components/text_field.dart';
import 'package:craft/data/model/distance.dart';
import 'package:craft/data/model/facility.dart';
import 'package:craft/data/model/optimization.dart';
import 'package:craft/screens/home.dart';
import 'package:craft/screens/optimization/optimization_information.dart';
import 'package:flutter/material.dart';
import '../../theme/colors.dart' as craft_colors;

class DistanceInformationScreen extends StatefulWidget {
  const DistanceInformationScreen({super.key});
  static const routeName = '/distanceInformationArguments';

  @override
  State<StatefulWidget> createState() => _DistanceInformationScreenState();
}

class _DistanceInformationScreenState extends State<DistanceInformationScreen> {
  late double _deviceHeight, _deviceWidth;
  OptimizationArgument optimizationArgument = OptimizationArgument();

  late DistanceArgument? distanceArgument;
  List<List<DistanceMetric>>? distanceMetrics;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    distanceArgument =
        ModalRoute.of(context)!.settings.arguments as DistanceArgument?;
    optimizationArgument.distanceArgument = distanceArgument!;
    int numberOfDepartments =
        distanceArgument?.facility?.numberOfDepartments ?? 0;
    distanceMetrics = List.generate(
        numberOfDepartments,
        (_) => List<DistanceMetric>.filled(
            numberOfDepartments, DistanceMetric("A", "B", "0")));
    for (int i = 0; i < numberOfDepartments; i++) {
      for (int j = 0; j < numberOfDepartments; j++) {
        distanceMetrics?[i][j] = DistanceMetric(
            String.fromCharCode(i + 65), String.fromCharCode(j + 65), "0");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    int numberOfDepartments =
        distanceArgument?.facility?.numberOfDepartments ?? 0;
    // DistanceArgument? distanceArgument =
    //     ModalRoute.of(context)!.settings.arguments as DistanceArgument?;
    // optimizationArgument.distanceArgument = distanceArgument!;
    // Facility facility = distanceArgument.facility!;

    return Scaffold(
      body: Container(
        color: craft_colors.Colors.white,
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.only(
              left: _deviceWidth * 0.05,
              right: _deviceWidth * 0.05,
              top: _deviceHeight * .02,
            ),
            height: _deviceHeight,
            width: _deviceWidth,
            child: Column(
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
                            color: (index > 2)
                                ? const Color(0xFFEEEEEE)
                                : craft_colors.Colors.primary,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Expanded(
                          child: Text(
                            "Enter the distance between each department",
                            style: TextStyle(
                              color: craft_colors.Colors.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ),
                            (Route<dynamic> route) => false,
                          ),
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFFBE7CD),
                            ),
                            padding: const EdgeInsets.all(4),
                            child: const Icon(
                              Icons.close,
                              color: craft_colors.Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "If there are no distances, enter 0. E.g A to A = 0",
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: _deviceHeight * .025),
                  ],
                ),
                SizedBox(height: _deviceHeight * .025),
                Expanded(
                  child: ListView(
                    children: [
                      for (int i = 0; i < numberOfDepartments; i++)
                        for (int j = 0; j < numberOfDepartments; j++)
                          i == j
                              ? Container()
                              : FacilityInput(
                                  hintText:
                                      "From ${String.fromCharCode(i + 65)} to ${String.fromCharCode(j + 65)}",
                                  autofocus: true,
                                  onChanged: (p0) => {
                                    setState(() =>
                                        distanceMetrics?[i][j].metric = p0)
                                  },
                                ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                defaultButton(
                  width: _deviceWidth,
                  text: "Next",
                  backgroundColor: craft_colors.Colors.primary,
                  onPressed: () => {
                    setState(
                      () => optimizationArgument.distanceMetrics =
                          distanceMetrics,
                    ),
                    for (int i = 0;
                        i < distanceArgument!.facility!.numberOfDepartments!;
                        i++)
                      for (int j = 0;
                          j < distanceArgument!.facility!.numberOfDepartments!;
                          j++)
                        debugPrint(
                            "Distance Metrics: ${String.fromCharCode(i + 65)}, ${String.fromCharCode(j + 65)}]: ${distanceMetrics?[i][j].metric}"),
                    Navigator.pushNamed(
                      context,
                      OptimizationInformationScreen.routeName,
                      arguments: optimizationArgument,
                    ),
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
