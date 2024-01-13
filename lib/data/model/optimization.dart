import 'package:craft/data/model/distance.dart';

class OptimizationArgument {
  DistanceArgument? distanceArgument;
  List<List<Metric>>? distanceMetrics;

  OptimizationArgument({this.distanceArgument, this.distanceMetrics});

  factory OptimizationArgument.fromMap(Map map) {
    OptimizationArgument item = OptimizationArgument(
      distanceArgument: map['facility'],
      distanceMetrics: map['distanceMetrics'],
    );
    return item;
  }

  Map<String, dynamic> toMap() {
    return {
      'distanceArgument': distanceArgument,
      'distanceMetrics': distanceMetrics,
    };
  }
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
