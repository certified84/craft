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

  // final TextEditingController _nameController = TextEditingController();
  // final TextEditingController _totalAreaController = TextEditingController();
  // final TextEditingController _lengthController = TextEditingController();
  // final TextEditingController _breadthController = TextEditingController();
  // final TextEditingController _rowsController = TextEditingController();
  // final TextEditingController _columnsController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    // var disabled = (_nameController.text.isEmpty ||
    //     _totalAreaController.text.isEmpty ||
    //     _lengthController.text.isEmpty ||
    //     _breadthController.text.isEmpty ||
    //     _rowsController.text.isEmpty ||
    //     _columnsController.text.isEmpty);

    var disabled = (facility.name == null ||
        facility.totalArea == null ||
        facility.length == null ||
        facility.breadth == null ||
        facility.rows == null ||
        facility.columns == null);

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
                        3,
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
                    SizedBox(height: _deviceHeight * .05),
                  ],
                ),
                SizedBox(height: _deviceHeight * .025),
                Expanded(
                  child: ListView(
                    children: [
                      FacilityInput(
                        // controller: _nameController,
                        hintText: "Enter the facility name",
                        autofocus: true,
                        onChanged: (p0) => setState(() => facility.name = p0),
                      ),
                      FacilityInput(
                        // controller: _totalAreaController,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        hintText: "Enter the total area of the facility",
                        onChanged: (p0) => setState(
                            () => facility.totalArea = double.parse(p0)),
                      ),
                      FacilityInput(
                        // controller: _lengthController,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        hintText: "Enter the length of each department",
                        onChanged: (p0) =>
                            setState(() => facility.length = double.parse(p0)),
                      ),
                      FacilityInput(
                        // controller: _breadthController,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        hintText: "Enter the breadth of each department",
                        onChanged: (p0) =>
                            setState(() => facility.breadth = double.parse(p0)),
                      ),
                      FacilityInput(
                        // controller: _rowsController,
                        keyboardType: TextInputType.number,
                        hintText: "Enter the number of rows",
                        onChanged: (p0) =>
                            setState(() => facility.rows = int.parse(p0)),
                      ),
                      FacilityInput(
                        // controller: _columnsController,
                        keyboardType: TextInputType.number,
                        hintText: "Enter the number of columns",
                        onChanged: (p0) =>
                            setState(() => facility.columns = int.parse(p0)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                defaultButton(
                  width: _deviceWidth,
                  text: "Next",
                  backgroundColor: disabled
                      ? craft_colors.Colors.primary.withOpacity(.4)
                      : craft_colors.Colors.primary,
                  onPressed: () => {if (!disabled) navigate()},
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void navigate() {
    // facility.name = _nameController.text;
    // facility.totalArea = double.parse(_totalAreaController.text);
    // facility.length = double.parse(_lengthController.text);
    // facility.breadth = double.parse(_breadthController.text);
    // facility.rows = int.parse(_rowsController.text);
    // facility.columns = int.parse(_columnsController.text);

    debugPrint("$facility");

    Navigator.pushNamedAndRemoveUntil(
      context,
      FlowMetricInformationScreen.routeName,
      ModalRoute.withName('/'),
      arguments: facility,
    );
  }
}
