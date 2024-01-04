import 'package:craft/data/model/distance.dart';

class OptimizationArgument {
  DistanceArgument? distanceArgument;
  List<DistanceMetric>? distanceMetrics;

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

class DistanceMetric {
  String i;
  String j;
  double metric;

  DistanceMetric(
    this.i,
    this.j,
    this.metric,
  );
}
