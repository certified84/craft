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
  List<Optimization>? optimizations;
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
            child: optimizations == null
                ? Column(
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
                                  margin:
                                      EdgeInsets.only(right: index < 3 ? 8 : 0),
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
                            "Click the button below to optimize the layout",
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
                        text: "Optimize Layout",
                        backgroundColor: craft_colors.Colors.primary,
                        onPressed: () => {
                          _optimizeLayout(optimizationArgument!).then(
                            (value) => {setState(() => optimizations = value)},
                          )
                        },
                      )
                    ],
                  )
                : (optimizations?.isEmpty == true)
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: List.generate(
                                  4,
                                  (index) => Expanded(
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          right: index < 3 ? 8 : 0),
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
                                "You layout is already the a most optimized layout. Click the button below to finish",
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
                            onPressed: () =>
                                Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) => const HomeScreen(),
                              ),
                              (Route<dynamic> route) => false,
                            ),
                          )
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: List.generate(
                                  4,
                                  (index) => Expanded(
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          right: index < 3 ? 8 : 0),
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
                              ...?optimizations
                                  ?.map((e) => OptimizationComponent(e))
                                  .toList(),
                              SizedBox(height: _deviceHeight * .03),
                              Text(
                                "Based on the results obtained, swap department ${optimizations?.last.i} with ${optimizations?.last.j} to achieve the most optimized layout",
                                style: const TextStyle(
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
                            onPressed: () =>
                                Navigator.of(context).pushAndRemoveUntil(
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

  Future<List<Optimization>> _optimizeLayout(OptimizationArgument argument) {
    List<Optimization> optimizations = [];
    int numberOfDepartments =
        argument.distanceArgument!.facility!.numberOfDepartments!;
    var facilityLayout = FacilityLayout(
      argument.distanceMetrics!,
      argument.distanceArgument!.flowMetrics!,
    );
    var improved = false;
    var prev = _calculateObjectiveFunction(facilityLayout, numberOfDepartments);
    debugPrint("Prev: $prev");

    int maxIterations = 1000;
    // for (int k = 0; k < maxIterations; k++) {
    for (int i = 0; i < numberOfDepartments; i++) {
      for (int j = 0; j < numberOfDepartments - 1; j++) {
        // if (i == j || i == j + 1) continue;
        var newLayout = _swapDepartments(i, j, i, j + 1, argument);
        var newObjective =
            _calculateObjectiveFunction(newLayout, numberOfDepartments);
        // debugPrint("Prev: $prev");
        // debugPrint("New: $newObjective");

        facilityLayout.distanceMetrics[0][0].i;
        if (newObjective < prev) {
          // debugPrint("Improved: Prev $prev, New: $newObjective");
          // optimizations.add(
          //   Optimization(
          //     newObjective,
          //     facilityLayout.distanceMetrics[i][j].i,
          //     newLayout.distanceMetrics[i][j].i,
          //   ),
          // );
          prev = newObjective;
          facilityLayout = newLayout;
          improved = true;
        }
      }
    }

    // prev = _calculateObjectiveFunction(facilityLayout, numberOfDepartments);

    // for (int j = 0; j < numberOfDepartments; j++) {
    //   for (int i = 0; i < numberOfDepartments - 1; i++) {
    //     var newLayout = _swapDepartments(i, j, i + 1, j, argument);
    //     var newObjective =
    //         _calculateObjectiveFunction(newLayout, numberOfDepartments);

    //     if (newObjective < prev) {
    //       debugPrint("Improved");
    //       prev = newObjective;
    //       facilityLayout = newLayout;
    //       improved = true;
    //       optimizations.add(Optimization(newObjective,
    //           String.fromCharCode(i + 65), String.fromCharCode(j + 65)));
    //     }
    //   }
    // }

    // debugPrint("Improved? $improved, optimization: ${optimizations.length}");

    //   if (!improved) {
    //     break;
    //   }
    // }
    return Future.value(optimizations);
  }

  FacilityLayout _swapDepartments(
      int i1, int j1, int i2, int j2, OptimizationArgument argument) {
    var newLayout = FacilityLayout(
        argument.distanceMetrics!, argument.distanceArgument!.flowMetrics!);
    var distanceMetricTemp = newLayout.distanceMetrics[i1][j1];

    debugPrint("Swapping $i1, $j1 with $i2, $j2: Before");
    debugPrint("Distance[$i1, $j1]: ${argument.distanceMetrics![i1][j1]}");
    debugPrint("Distance[$i2, $j2]: ${argument.distanceMetrics![i2][j2]}\n");

    newLayout.distanceMetrics[i1][j1] = newLayout.distanceMetrics[i2][j2];
    newLayout.distanceMetrics[i2][j2] = distanceMetricTemp;

    debugPrint("Swapping $i1, $j1 with $i2, $j2: After");
    debugPrint("Distance[$i1, $j1]: ${argument.distanceMetrics![i1][j1]}");
    debugPrint("Distance[$i2, $j2]: ${argument.distanceMetrics![i2][j2]}\n\n");

    return newLayout;
  }

  double _calculateObjectiveFunction(
    FacilityLayout layout,
    int numberOfDepartments,
  ) {
    var costMetric = _calculateCostMetric(layout, numberOfDepartments);
    var objective = 0.0;
    for (int i = 0; i < numberOfDepartments; i++) {
      for (int j = 0; j < numberOfDepartments; j++) {
        objective += costMetric[i][j];
      }
    }
    // debugPrint("Objective: $objective");
    return objective;
  }

  List<List<double>> _calculateCostMetric(
    FacilityLayout layout,
    int numberOfDepartments,
  ) {
    List<List<double>> costMetric = List.generate(
      numberOfDepartments,
      (_) => List<double>.filled(numberOfDepartments, 0),
    );

    for (int i = 0; i < numberOfDepartments; i++) {
      for (int j = 0; j < numberOfDepartments; j++) {
        try {
          double flowMetric = double.parse(layout.flowMetrics[i][j].metric);
          double distanceMetric =
              double.parse(layout.distanceMetrics[i][j].metric);
          costMetric[i][j] = flowMetric * distanceMetric;
          // debugPrint(
          //     "Flow[${String.fromCharCode(i + 65)}]: $flowMetric, Distance[${String.fromCharCode(j + 65)}]: $distanceMetric, Cost: ${flowMetric * distanceMetric}}");
        } catch (e) {
          // debugPrint("i: $i, j: $j");
          // debugPrint('Error parsing double: $e');
        }
      }
    }
    return costMetric;
  }
}
