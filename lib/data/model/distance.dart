import 'package:craft/data/model/facility.dart';

class DistanceArgument {
  Facility? facility;
  List<FlowMetric>? flowMetrics;

  DistanceArgument({this.facility, this.flowMetrics});

  factory DistanceArgument.fromMap(Map map) {
    DistanceArgument item = DistanceArgument(
      facility: map['facility'],
      flowMetrics: map['flowMetrics'],
    );
    return item;
  }

  Map<String, dynamic> toMap() {
    return {
      'facility': facility,
      'flowMetrics': flowMetrics,
    };
  }
}

class FlowMetric {
  String i;
  String j;
  double metric;

  FlowMetric(
    this.i,
    this.j,
    this.metric,
  );
}
