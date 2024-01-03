import 'package:craft/data/model/facility.dart';
import 'package:flutter/material.dart';
import '../../theme/colors.dart' as craft_colors;

class OptimizationComponent extends StatelessWidget {
  const OptimizationComponent(this.optimization, {super.key});
  final Optimization optimization;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      child: Row(
        children: [
          Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: craft_colors.Colors.primary,
            ),
            margin: const EdgeInsets.symmetric(horizontal: 15),
            width: 10,
            height: 10,
          ),
          Expanded(
            child: Text(
              "Swapping Department ${optimization.i} with ${optimization.j}, gave a total score of ${optimization.score}",
              style: TextStyle(fontWeight: FontWeight.w400),
            ),
          )
        ],
      ),
    );
  }
}
