import 'package:craft/components/unordered_list.dart';
import 'package:craft/screens/home.dart';
import 'package:craft/screens/optimization/facility_information.dart';
import 'package:flutter/material.dart';
import 'package:craft/components/buttons.dart';
import '../../theme/colors.dart' as craft_colors;

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
        color: craft_colors.Colors.white,
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
                      "Few things to note before using the application",
                      style: TextStyle(
                        color: craft_colors.Colors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Container(
                        padding: const EdgeInsets.only(left: 18, top: 18),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "The application assumes that:",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 16),
                            UnorderedList(
                              [
                                "All the departments in the layout has equal areas.",
                                "There are no fixed points meaning all departments can be swapped.",
                                "The facility has a single layout structure.",
                                "It uses pairwise exchange for swapping between departments.",
                                "The cost matrix is unity.",
                                "It swaps based on equal areas."
                              ],
                            ),
                          ],
                        ))
                  ],
                ),
                Column(
                  children: [
                    defaultButton(
                      width: _deviceWidth * .8,
                      text: "Get Started",
                      backgroundColor: craft_colors.Colors.primary,
                      textColor: craft_colors.Colors.white,
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) =>
                                const FacilityInformationScreen(),
                          ),
                          (Route<dynamic> route) => false,
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    defaultOutlinedButton(
                      width: _deviceWidth * .8,
                      text: "Skip",
                      borderColor: craft_colors.Colors.primary,
                      textColor: craft_colors.Colors.primary,
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
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
