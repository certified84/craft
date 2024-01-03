import 'package:craft/components/buttons.dart';
import 'package:craft/components/text_field.dart';
import 'package:craft/data/model/facility.dart';
import 'package:craft/screens/home.dart';
import 'package:craft/screens/optimization/cost_metric_information%20copy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vector_graphics/vector_graphics.dart';
import '../../theme/colors.dart' as craft_colors;

class FlowMetricInformationScreen extends StatefulWidget {
  const FlowMetricInformationScreen({super.key});

  @override
  State<StatefulWidget> createState() => _FlowMetricInformationScreenState();
}

class _FlowMetricInformationScreenState
    extends State<FlowMetricInformationScreen> {
  late double _deviceHeight, _deviceWidth;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

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
                            "Enter the flow metric for each department",
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
                    SizedBox(height: _deviceHeight * .05),
                    FacilityInput(
                      hintText: "Enter the facility name",
                      autofocus: true,
                      onChanged: (p0) => null,
                    ),
                    FacilityInput(
                      hintText: "Enter the number of departments",
                      autofocus: true,
                      onChanged: (p0) => null,
                    ),
                    FacilityInput(
                      hintText: "Enter the total area of the facility",
                      autofocus: true,
                      onChanged: (p0) => null,
                    ),
                  ],
                ),
                defaultButton(
                  width: _deviceWidth,
                  text: "Next",
                  backgroundColor: craft_colors.Colors.primary,
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CostMetricInformationScreen(),
                    ),
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
