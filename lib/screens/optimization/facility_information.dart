import 'package:craft/components/buttons.dart';
import 'package:craft/components/text_field.dart';
import 'package:craft/data/model/facility.dart';
import 'package:craft/screens/home.dart';
import 'package:craft/screens/optimization/flow_metric_information.dart';
import 'package:flutter/material.dart';
import '../../theme/colors.dart' as craft_colors;

class FacilityInformationScreen extends StatefulWidget {
  const FacilityInformationScreen({super.key});

  @override
  State<StatefulWidget> createState() => _FacilityInformationScreenState();
}

class _FacilityInformationScreenState extends State<FacilityInformationScreen> {
  late double _deviceHeight, _deviceWidth;
  final Facility facility = Facility();

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
              crossAxisAlignment: CrossAxisAlignment.start,
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
                            color: (index > 0)
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
                            "Enter the facility information",
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
                      onChanged: (p0) => setState(() => facility.name = p0),
                    ),
                    FacilityInput(
                      hintText: "Enter the number of departments",
                      autofocus: true,
                      onChanged: (p0) => setState(
                          () => facility.numberOfDepartments = int.parse(p0)),
                    ),
                    FacilityInput(
                      hintText: "Enter the total area of the facility",
                      autofocus: true,
                      onChanged: (p0) =>
                          setState(() => facility.totalArea = double.parse(p0)),
                    ),
                    FacilityInput(
                      hintText: "Enter the length of each department",
                      autofocus: true,
                      onChanged: (p0) =>
                          setState(() => facility.length = double.parse(p0)),
                    ),
                    FacilityInput(
                      hintText: "Enter the breadth of each department",
                      autofocus: true,
                      onChanged: (p0) =>
                          setState(() => facility.breadth = double.parse(p0)),
                    ),
                    FacilityInput(
                      hintText: "Enter the number of rows",
                      autofocus: true,
                      onChanged: (p0) =>
                          setState(() => facility.rows = int.parse(p0)),
                    ),
                    FacilityInput(
                      hintText: "Enter the number of columns",
                      autofocus: true,
                      onChanged: (p0) =>
                          setState(() => facility.columns = int.parse(p0)),
                    ),
                  ],
                ),
                defaultButton(
                  width: _deviceWidth,
                  text: "Next",
                  backgroundColor: craft_colors.Colors.primary,
                  onPressed: () => {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      FlowMetricInformationScreen.routeName,
                      ModalRoute.withName('/'),
                      arguments: facility,
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
