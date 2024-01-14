import 'package:craft/components/buttons.dart';
import 'package:craft/components/text_field.dart';
import 'package:craft/data/model/facility.dart';
import 'package:craft/data/model/optimization.dart';
import 'package:craft/screens/home.dart';
import 'package:craft/screens/optimization/optimization_information.dart';
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
  OptimizationArgument optimizationArgument = OptimizationArgument();

  late Facility? facility;
  List<List<Metric>>? flowMetrics;
  int numberOfDepartments = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    facility = ModalRoute.of(context)!.settings.arguments as Facility?;
    optimizationArgument.facility = facility!;
    numberOfDepartments = facility!.rows! * facility!.columns!;
    flowMetrics = List.generate(numberOfDepartments,
        (_) => List<Metric>.filled(numberOfDepartments, Metric("A", "B", "")));

    for (int i = 0; i < numberOfDepartments; i++) {
      for (int j = 0; j < numberOfDepartments; j++) {
        flowMetrics?[i][j] = Metric(
            String.fromCharCode(i + 65), String.fromCharCode(j + 65), "");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    var disabled = false;
    for (int i = 0; i < numberOfDepartments; i++) {
      for (int j = 0; j < numberOfDepartments; j++) {
        disabled = disabled && flowMetrics?[i][j].metric == "";
      }
    }

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
                        3,
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
                              fontFamily: "SpaceGrotesk",
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
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color:
                                  craft_colors.Colors.primary.withOpacity(.75),
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
                  backgroundColor: disabled
                      ? craft_colors.Colors.primary.withOpacity(.4)
                      : craft_colors.Colors.primary,
                  onPressed: () => {
                    setState(
                        () => optimizationArgument.flowMetrics = flowMetrics),
                    for (int i = 0; i < numberOfDepartments; i++)
                      for (int j = 0; j < numberOfDepartments; j++)
                        debugPrint(
                            "Flow Metrics: ${String.fromCharCode(i + 65)}, ${String.fromCharCode(j + 65)}]: ${flowMetrics?[i][j].metric}"),
                    if (!disabled)
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        OptimizationInformationScreen.routeName,
                        ModalRoute.withName('/'),
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
