import 'package:craft/components/unordered_list.dart';
import 'package:flutter/material.dart';
import 'package:craft/components/buttons.dart';
import '../../theme/colors.dart' as futa_map_colors;

class InformationScreen extends StatefulWidget {
  const InformationScreen({super.key});

  @override
  State<StatefulWidget> createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
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
        color: futa_map_colors.Colors.white,
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.only(
              left: _deviceWidth * 0.05,
              right: _deviceWidth * 0.05,
              bottom: _deviceHeight * .02,
              top: _deviceHeight * .09,
            ),
            height: _deviceHeight,
            width: _deviceWidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const Text(
                      "Few things to note before using the application:",
                      style: TextStyle(
                        color: futa_map_colors.Colors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 18, top: 18),
                      child: const UnorderedList(
                        [
                          "The application assumes all the departments in the layout has equal areas. This means that the no of departments times the area of a department equals the total area of the facility or total area of the facility divided by the number of departments equal the area of each department",
                          "There are no fixed points meaning all departments can be swapped.",
                        ],
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    defaultButton(
                      width: _deviceWidth * .8,
                      text: "Get Started",
                      backgroundColor: futa_map_colors.Colors.primary,
                      textColor: futa_map_colors.Colors.white,
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => const InformationScreen(),
                          ),
                          (Route<dynamic> route) => false,
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    defaultOutlinedButton(
                      width: _deviceWidth * .8,
                      text: "Skip",
                      borderColor: futa_map_colors.Colors.primary,
                      textColor: futa_map_colors.Colors.primary,
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => const InformationScreen(),
                          ),
                          (Route<dynamic> route) => false,
                        );
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
