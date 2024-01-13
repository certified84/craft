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
  List<List<Metric>> distanceMetrics = [];

  List<List<Department>> positions = [];
  List<List<Department>> centroids = [];

  int numberOfDepartments = 0, rows = 0, columns = 0;
  double length = 0, breadth = 0, initialScore = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    optimizationArgument =
        ModalRoute.of(context)!.settings.arguments as OptimizationArgument?;

    // Define the variables needed
    rows = optimizationArgument?.facility?.rows ?? 0;
    columns = optimizationArgument?.facility?.columns ?? 0;
    numberOfDepartments = rows * columns;

    length = optimizationArgument?.facility?.length ?? 0;
    breadth = optimizationArgument?.facility?.breadth ?? 0;

    // Generate default values for the arrays
    positions = List.generate(rows,
        (_) => List<Department>.filled(columns, Department("A", "0", "0")));

    centroids = List.generate(rows,
        (_) => List<Department>.filled(columns, Department("A", "0", "0")));

    distanceMetrics = List.generate(numberOfDepartments,
        (_) => List<Metric>.filled(numberOfDepartments, Metric("A", "B", "0")));

    // Update the values of the positions as required
    int initial = 0;
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < columns; j++) {
        positions[i][j] =
            (Department(String.fromCharCode(65 + initial++), "$i", "$j"));
      }
    }

    double intialCentroidX = length / 2.0;
    double intialCentroidY = breadth / 2.0;
    initial = 0;

    // Obtain the Centroid for each department as required
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < columns; j++) {
        Department department = positions[i][j];
        centroids[i][j] = (Department(
            String.fromCharCode(65 + initial++),
            "${int.parse(department.j) * length + intialCentroidX}",
            "${int.parse(department.i) * breadth + intialCentroidY}"));
      }
    }

    // Calculate the distace between each department
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < columns; j++) {
        var currentElement = centroids[i][j];
        for (int k = 0; k < rows; k++) {
          for (int l = 0; l < columns; l++) {
            var otherElement = centroids[k][l];
            var distance = (double.parse(currentElement.i) -
                        double.parse(otherElement.i))
                    .abs() +
                (double.parse(currentElement.j) - double.parse(otherElement.j))
                    .abs();
            distanceMetrics[i * columns + j][k * columns + l] = Metric(
              currentElement.name,
              otherElement.name,
              "$distance",
            );
          }
        }
      }
    }

    setState(() {
      optimizationArgument?.distanceMetrics = distanceMetrics;
    });
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
                              3,
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
                                  3,
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
                              const SizedBox(height: 8),
                              Text(
                                "Initial score: $initialScore",
                                style: const TextStyle(fontSize: 14),
                              ),
                              SizedBox(height: _deviceHeight * .05),
                              const Text(
                                "Your layout is already the a most optimized layout. Click the button below to finish",
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
                                  3,
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
                              const SizedBox(height: 8),
                              Text(
                                "Initial score: $initialScore",
                                style: const TextStyle(fontSize: 14),
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
    var facilityLayout = FacilityLayout(
      argument.distanceMetrics!,
      argument.flowMetrics!,
    );

    var prev = _calculateObjectiveFunction(facilityLayout, numberOfDepartments);
    initialScore = prev;

    int maxIterations = 1000;
    bool improved = false;
    for (int k = 0; k < maxIterations; k++) {
      for (int i = 0; i < rows; i++) {
        for (int j = 0; j < columns - 1; j++) {
          var newLayout = _swapCentroids(i, j, i, j + 1, argument);
          var newObjective =
              _calculateObjectiveFunction(newLayout, numberOfDepartments);

          debugPrint("Prev $prev, New: $newObjective");

          if (newObjective < prev) {
            debugPrint("Improved: Prev $prev, New: $newObjective");
            optimizations.add(
              Optimization(
                newObjective,
                facilityLayout.distanceMetrics[i][j].i,
                newLayout.distanceMetrics[i][j].i,
              ),
            );
            prev = newObjective;
            facilityLayout = newLayout;
            improved = true;
          }
        }
      }
      if (!improved) {
        break;
      }
    }

    // int maxIterations = 1000;
    // for (int k = 0; k < maxIterations; k++) {
    // for (int i = 0; i < numberOfDepartments; i++) {
    //   for (int j = 0; j < numberOfDepartments - 1; j++) {
    //     // if (i == j || i == j + 1) continue;
    //     var newLayout = _swapDepartments(i, j, i, j + 1, argument);
    //     var newObjective =
    //         _calculateObjectiveFunction(newLayout, numberOfDepartments);
    //     // debugPrint("Prev: $prev");
    //     // debugPrint("New: $newObjective");

    //     facilityLayout.distanceMetrics[0][0].i;
    //     if (newObjective < prev) {
    //       // debugPrint("Improved: Prev $prev, New: $newObjective");
    //       // optimizations.add(
    //       //   Optimization(
    //       //     newObjective,
    //       //     facilityLayout.distanceMetrics[i][j].i,
    //       //     newLayout.distanceMetrics[i][j].i,
    //       //   ),
    //       // );
    //       prev = newObjective;
    //       facilityLayout = newLayout;
    //       improved = true;
    //     }
    //   }
    // }

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

  FacilityLayout _swapCentroids(
      int i1, int j1, int i2, int j2, OptimizationArgument argument) {
    var newLayout =
        FacilityLayout(argument.distanceMetrics!, argument.flowMetrics!);

    var newCentroids = centroids;
    var centroidTemp = newCentroids[i1][j1];

    // debugPrint("Swapping $i1, $j1 with $i2, $j2: Before");
    // debugPrint("Centroid[$i1, $j1]: ${centroids[i1][j1]}");
    // debugPrint("Centroid[$i2, $j2]: ${centroids[i2][j2]}\n");

    newCentroids[i1][j1] = newCentroids[i2][j2];
    newCentroids[i2][j2] = centroidTemp;

    // debugPrint("Swapping $i1, $j1 with $i2, $j2: After");
    // debugPrint("Centroid[$i1, $j1]: ${centroids[i1][j1]}");
    // debugPrint("Centroid[$i2, $j2]: ${centroids[i2][j2]}\n\n");
    newLayout.distanceMetrics =
        _calculateNewDistances(rows, columns, newCentroids);

    return newLayout;
  }

  List<List<Metric>> _calculateNewDistances(
    int rows,
    int columns,
    List<List<Department>> newCentroids,
  ) {
    List<List<Metric>> newDistanceMetric = [];
    newDistanceMetric = List.generate(rows * columns,
        (_) => List<Metric>.filled(rows * columns, Metric("A", "B", "0")));

    // Calculate the distace between each department
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < columns; j++) {
        var currentElement = newCentroids[i][j];
        for (int k = 0; k < rows; k++) {
          for (int l = 0; l < columns; l++) {
            var otherElement = newCentroids[k][l];
            var distance = (double.parse(currentElement.i) -
                        double.parse(otherElement.i))
                    .abs() +
                (double.parse(currentElement.j) - double.parse(otherElement.j))
                    .abs();
            newDistanceMetric[i * columns + j][k * columns + l] = Metric(
              currentElement.name,
              otherElement.name,
              "$distance",
            );
          }
        }
      }
    }
    return newDistanceMetric;
  }

  FacilityLayout _swapDepartments(
      int i1, int j1, int i2, int j2, OptimizationArgument argument) {
    var newLayout =
        FacilityLayout(argument.distanceMetrics!, argument.flowMetrics!);
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
