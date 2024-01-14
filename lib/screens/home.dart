import 'package:craft/data/model/facility.dart';
import 'package:craft/screens/optimization/facility_information.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vector_graphics/vector_graphics.dart';
import '../../theme/colors.dart' as craft_colors;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const routeName = '/';

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late double _deviceHeight, _deviceWidth;
  List<Facility> optimizedLayouts = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: craft_colors.Colors.primary,
        child: const Icon(Icons.add, size: 24),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const FacilityInformationScreen(),
            ),
          );
        },
      ),
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
            child: optimizedLayouts.isEmpty
                ? const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture(
                        AssetBytesLoader('assets/svgs/no_data.svg.vec'),
                        semanticsLabel: 'Craft Logo',
                      ),
                      SizedBox(height: 8),
                      Text(
                        "You haven't optimized any layouts",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          fontFamily: "SpaceGrotesk",
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Click the button below to add one",
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: "SpaceGrotesk",
                        ),
                      ),
                    ],
                  )
                : const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Previous Layouts",
                        style: TextStyle(
                          color: craft_colors.Colors.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontFamily: "SpaceGrotesk",
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
