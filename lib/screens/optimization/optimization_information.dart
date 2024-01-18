import 'package:craft/components/buttons.dart';
import 'package:craft/components/optimization.dart';
import 'package:craft/data/model/facility.dart';
import 'package:craft/data/model/optimization.dart';
import 'package:craft/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
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

  final Box _box = Hive.box("craftify");
  List<Optimization>? optimizations;
  Facility facility = Facility();

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
    facility = optimizationArgument!.facility!;

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

    setState(() {
      optimizationArgument?.distanceMetrics =
          _calculateDistances(rows, columns, centroids);
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
                              fontFamily: "SpaceGrotesk",
                            ),
                          ),
                          SizedBox(height: _deviceHeight * .05),
                          const Text(
                            "Click the button below to optimize the layout",
                            style: TextStyle(
                              color: craft_colors.Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              fontFamily: "SpaceGrotesk",
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
                                  fontFamily: "SpaceGrotesk",
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "Initial score: $initialScore",
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontFamily: "SpaceGrotesk",
                                ),
                              ),
                              SizedBox(height: _deviceHeight * .05),
                              const Text(
                                "Your layout is already the a most optimized layout. Click the button below to finish",
                                style: TextStyle(
                                  color: craft_colors.Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  fontFamily: "SpaceGrotesk",
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
                                  fontFamily: "SpaceGrotesk",
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "Initial score: $initialScore",
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontFamily: "SpaceGrotesk",
                                ),
                              ),
                              SizedBox(height: _deviceHeight * .05),
                              const Text(
                                "After performing the CRAFT iteration and optimization process, the following results were obtained:",
                                style: TextStyle(
                                  color: craft_colors.Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  fontFamily: "SpaceGrotesk",
                                ),
                              ),
                              SizedBox(height: _deviceHeight * .03),
                              ...?optimizations
                                  ?.map((e) => OptimizationComponent(e))
                                  .toList(),
                              SizedBox(height: _deviceHeight * .03),
                              // Text(
                              //   "Based on the results obtained, swap department ${optimizations?.last.i} with ${optimizations?.last.j} to achieve the most optimized layout",
                              //   style: const TextStyle(
                              //     color: craft_colors.Colors.black,
                              //     fontWeight: FontWeight.w600,
                              //     fontSize: 14,
                              // fontFamily: "SpaceGrotesk",
                              //   ),
                              // ),
                            ],
                          ),
                          defaultButton(
                            width: _deviceWidth,
                            text: "Finish",
                            backgroundColor: craft_colors.Colors.primary,
                            onPressed: () => {
                              facility.optimizations = optimizations!,
                              facility.initialScore = initialScore,
                              // _box.add(facility.toMap()),
                              // debugPrint("BOX: ${_box.values.firstOrNull()}"),
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (context) => const HomeScreen(),
                                ),
                                (Route<dynamic> route) => false,
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

  Future<List<Optimization>> _optimizeLayout(OptimizationArgument argument) {
    List<Optimization> optimizations = [];
    var facilityLayout = FacilityLayout(
      argument.distanceMetrics!,
      argument.flowMetrics!,
    );

    initialScore =
        _calculateObjectiveFunction(facilityLayout, numberOfDepartments);

    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < columns; j++) {
        for (int k = i; k < rows; k++) {
          int l = (k == i) ? j + 1 : 0;
          for (; l < columns; l++) {
            if (k == i && l == j) continue;

            var newLayout = _swapCentroids(i, j, k, l, argument);
            var score =
                _calculateObjectiveFunction(newLayout, numberOfDepartments);
            var optimization = Optimization(
              score,
              newLayout.from!,
              newLayout.to!,
            );
            optimizations.add(optimization);
          }
        }
      }
    }
    return Future.value(optimizations);
  }

  FacilityLayout _swapCentroids(
    int i1,
    int j1,
    int i2,
    int j2,
    OptimizationArgument argument,
  ) {
    var newLayout =
        FacilityLayout(argument.distanceMetrics!, argument.flowMetrics!);

    var newCentroids = centroids
        .map((list) => list
            .map((department) =>
                Department(department.name, department.i, department.j))
            .toList())
        .toList();

    var centroid1 = newCentroids[i1][j1];
    var centroid2 = newCentroids[i2][j2];

    newLayout.from = centroids[i1][j1].name;
    newLayout.to = centroid2.name;

    var i = centroid1.i;
    var j = centroid1.j;

    var ii = centroid2.i;
    var jj = centroid2.j;

    newCentroids[i2][j2].i = i;
    newCentroids[i2][j2].j = j;

    newCentroids[i1][j1].i = ii;
    newCentroids[i1][j1].j = jj;

    newLayout.distanceMetrics =
        _calculateDistances(rows, columns, newCentroids);

    return newLayout;
  }

  List<List<Metric>> _calculateDistances(
    int rows,
    int columns,
    List<List<Department>> centroids,
  ) {
    List<List<Metric>> distanceMetric = [];
    distanceMetric = List.generate(rows * columns,
        (_) => List<Metric>.filled(rows * columns, Metric("A", "B", "0")));

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
            distanceMetric[i * columns + j][k * columns + l] = Metric(
              currentElement.name,
              otherElement.name,
              "$distance",
            );
          }
        }
      }
    }
    return distanceMetric;
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
          // ignore: empty_catches
        } catch (e) {}
      }
    }
    return costMetric;
  }
}
