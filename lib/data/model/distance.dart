import 'package:craft/data/model/facility.dart';
import 'package:craft/data/model/optimization.dart';

class DistanceArgument {
  Facility? facility;
  List<List<Metric>>? flowMetrics;

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
