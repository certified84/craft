import 'package:craft/data/model/facility.dart';
import 'package:craft/screens/optimization/facility_information.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
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
  Box? _box = Hive.box("craftify");

  @override
  void initState() {
    super.initState();
    debugPrint("BOX: ${_box?.length}");
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
              child: _optimizationsView()
              // optimizedLayouts.isEmpty
              //     ? const Column(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: [
              //           SvgPicture(
              //             AssetBytesLoader('assets/svgs/no_data.svg.vec'),
              //             semanticsLabel: 'Craft Logo',
              //           ),
              //           SizedBox(height: 8),
              //           Text(
              //             "You haven't optimized any layouts",
              //             style: TextStyle(
              //               fontSize: 18,
              //               fontWeight: FontWeight.w600,
              //               fontFamily: "SpaceGrotesk",
              //             ),
              //           ),
              //           SizedBox(height: 8),
              //           Text(
              //             "Click the button below to add one",
              //             style: TextStyle(
              //               fontSize: 12,
              //               fontFamily: "SpaceGrotesk",
              //             ),
              //           ),
              //         ],
              //       )
              //     : const Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Text(
              //             "Previous Layouts",
              //             style: TextStyle(
              //               color: craft_colors.Colors.primary,
              //               fontWeight: FontWeight.bold,
              //               fontSize: 20,
              //               fontFamily: "SpaceGrotesk",
              //             ),
              //           ),
              //         ],
              //       ),
              ),
        ),
      ),
    );
  }

  Widget _optimizationsView() {
    return FutureBuilder(
      future: Hive.openBox('craftify'),
      builder: ((context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            if (snapshot.hasData && (snapshot.data?.length ?? 0) > 0) {
              _box = snapshot.data;
              debugPrint(snapshot.data?.length.toString());
              List tasks = _box!.values.toList();
              return _optimizationList(tasks);
            } else {
              return _emptyList();
            }
          case ConnectionState.waiting:
            return const Center(
                child: CircularProgressIndicator(
              backgroundColor: craft_colors.Colors.primary,
            ));
          default:
            return _emptyList();
        }
      }),
    );
  }

  Widget _emptyList() {
    return const Column(
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
    );
  }

  Widget _optimizationList(List tasks) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) =>
          _facilityCard(index, Facility.fromMap(tasks[index])),
    );
  }

  Widget _facilityCard(int index, Facility facility) {
    return GestureDetector(
      // onTap: () => {
      //   showSingleChoiceDialog(context,
      //       title: "Select an option",
      //       options: ["Edit", "Delete", "Update status"],
      //       callback: (value) => {
      //             print(value),
      //             if (value == "Delete")
      //               {_box?.deleteAt(index)}
      //             else if (value == "Update status")
      //               {
      //                 task.isCompleted = !task.isCompleted,
      //                 _box?.putAt(index, task.toMap()),
      //               }
      //             else
      //               {_displayTaskPopup(index: index, task: task)},
      //             setState(() {})
      //           })
      // },
      // onLongPress: () => {_box?.deleteAt(index), setState(() {})},
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: craft_colors.Colors.primary,
        ),
      ),
    );
  }
}
