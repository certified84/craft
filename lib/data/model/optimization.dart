import 'package:craft/data/model/facility.dart';

class OptimizationArgument {
  Facility? facility;
  List<List<Metric>>? flowMetrics;
  List<List<Metric>>? distanceMetrics;

  OptimizationArgument({this.facility, this.flowMetrics, this.distanceMetrics});

  // factory OptimizationArgument.fromMap(Map map) {
  //   OptimizationArgument item = OptimizationArgument(
  //     facility: map['facility'],
  //     distanceMetrics: map['distanceMetrics'],
  //   );
  //   return item;
  // }

  // Map<String, dynamic> toMap() {
  //   return {
  //     'distanceArgument': distanceArgument,
  //     'distanceMetrics': distanceMetrics,
  //   };
  // }
}

class Metric {
  String i;
  String j;
  String metric;

  Metric(
    this.i,
    this.j,
    this.metric,
  );

  @override
  String toString() {
    return "Metric: $i, $j, $metric";
  }
}
