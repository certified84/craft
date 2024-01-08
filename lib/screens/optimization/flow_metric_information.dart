import 'package:craft/components/buttons.dart';
import 'package:craft/components/text_field.dart';
import 'package:craft/data/model/distance.dart';
import 'package:craft/data/model/facility.dart';
import 'package:craft/screens/home.dart';
import 'package:craft/screens/optimization/distance_information.dart';
import 'package:flutter/material.dart';
import '../../theme/colors.dart' as craft_colors;

class FlowMetricInformationScreen extends StatefulWidget {
  const FlowMetricInformationScreen({super.key});
  static const routeName = '/flowMetricsArguments';

  @override
  State<StatefulWidget> createState() => _FlowMetricInformationScreenState();
}

class _FlowMetricInformationScreenState
    extends State<FlowMetricInformationScreen> {
  late double _deviceHeight, _deviceWidth;
  DistanceArgument distanceArgument = DistanceArgument();

  late Facility? facility;
  List<List<FlowMetric>>? flowMetrics;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    facility = ModalRoute.of(context)!.settings.arguments as Facility?;
    distanceArgument.facility = facility!;
    int numberOfDepartments = facility?.numberOfDepartments ?? 0;
    flowMetrics = List.generate(
        numberOfDepartments,
        (_) => List<FlowMetric>.filled(
            numberOfDepartments, FlowMetric("A", "B", "0")));
    for (int i = 0; i < numberOfDepartments; i++) {
      for (int j = 0; j < numberOfDepartments; j++) {
        flowMetrics?[i][j] = FlowMetric(
            String.fromCharCode(i + 65), String.fromCharCode(j + 65), "0");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    int numberOfDepartments = facility?.numberOfDepartments ?? 0;
    // Facility? facility =
    //     ModalRoute.of(context)!.settings.arguments as Facility?;
    // distanceArgument.facility = facility!;

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
                            color: (index > 1)
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
                            "Enter the flow metric between each department",
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
                      "If there are no metrics, enter 0. E.g A to A = 0",
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
                                autofocus: i + j == 1,
                                onChanged: (p0) => {
                                  setState(() => flowMetrics?[i][j].metric = p0)
                                },
                              ),
                    const SizedBox(height: 40),
                  ],
                )),
                const SizedBox(height: 15),
                defaultButton(
                  width: _deviceWidth,
                  text: "Next",
                  backgroundColor: craft_colors.Colors.primary,
                  onPressed: () => {
                    setState(() => distanceArgument.flowMetrics = flowMetrics),
                    for (int i = 0; i < facility!.numberOfDepartments!; i++)
                      for (int j = 0; j < facility!.numberOfDepartments!; j++)
                        debugPrint(
                            "Flow Metrics: ${String.fromCharCode(i + 65)}, ${String.fromCharCode(j + 65)}]: ${flowMetrics?[i][j].metric}"),
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      DistanceInformationScreen.routeName,
                      ModalRoute.withName('/'),
                      arguments: distanceArgument,
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
