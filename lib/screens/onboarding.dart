import 'package:craft/screens/information.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:craft/components/buttons.dart';
import 'package:vector_graphics/vector_graphics.dart';
import '../../theme/colors.dart' as craft_colors;

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<StatefulWidget> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
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
        padding: EdgeInsets.symmetric(
          horizontal: _deviceWidth * 0.05,
          vertical: _deviceHeight * .02,
        ),
        height: _deviceHeight,
        width: _deviceWidth,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SvgPicture(
                    AssetBytesLoader('assets/svgs/craft_logo.svg.vec'),
                    semanticsLabel: 'Craft Logo',
                  ),
                  SizedBox(
                    width: _deviceWidth * .8,
                    child: const Text(
                      "A simple tool to help you optimize your facility layout based on the Computerized Relative Allocation of Facilities Technique.",
                      style: TextStyle(
                        color: craft_colors.Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        fontFamily: "SpaceGrotesk",
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      defaultButton(
                        width: _deviceWidth * .8,
                        text: "Continue",
                        backgroundColor: craft_colors.Colors.primary,
                        textColor: craft_colors.Colors.white,
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
                  ),
                  SizedBox(
                    width: _deviceWidth * .9,
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        const Text(
                          "By continuing, you agree to our",
                          style: TextStyle(
                            color: craft_colors.Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                            fontFamily: "SpaceGrotesk",
                          ),
                        ),
                        TextButton(
                          onPressed: () => {},
                          child: const Text(
                            "Terms",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: craft_colors.Colors.primary,
                              fontFamily: "SpaceGrotesk",
                            ),
                          ),
                        ),
                        const Text(
                          "and",
                          style: TextStyle(
                            color: craft_colors.Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                            fontFamily: "SpaceGrotesk",
                          ),
                        ),
                        TextButton(
                          onPressed: () => {},
                          child: const Text(
                            "Privacy Policy",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: craft_colors.Colors.primary,
                              fontFamily: "SpaceGrotesk",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
