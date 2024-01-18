import 'package:craft/data/model/optimization.dart';

class Facility {
  int? id;
  String? name;
  double? totalArea;
  double? length;
  double? breadth;
  int? rows;
  int? columns;
  double? initialScore;
  double? optimizedScore;
  List<Optimization>? optimizations;

  Facility({
    this.id,
    this.name,
    this.totalArea,
    this.length,
    this.breadth,
    this.rows,
    this.columns,
    this.initialScore,
    this.optimizedScore,
    this.optimizations,
  });

  factory Facility.fromMap(Map map) {
    Facility item = Facility(
      id: map['id'],
      name: map['name'],
      totalArea: map['totalArea'],
      length: map['length'],
      breadth: map['breadth'],
      rows: map['rows'],
      columns: map['columns'],
      initialScore: map['initialScore'],
      optimizedScore: map['optimizedScore'],
      optimizations: map['optimizations'],
    );
    return item;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'totalArea': totalArea,
      'initialScore': initialScore,
      'optimizedScore': optimizedScore,
      'optimizations': optimizations
    };
  }

  @override
  String toString() =>
      "Facility: $name, $totalArea, $length, $breadth, $rows, $columns, $initialScore, $optimizedScore, $optimizations";
}

class Optimization {
  int? id;
  double score;
  String i;
  String j;

  Optimization(
    this.score,
    this.i,
    this.j,
  );
}

class FacilityLayout {
  List<List<Metric>> distanceMetrics;
  List<List<Metric>> flowMetrics;
  String? from;
  String? to;

  FacilityLayout(this.distanceMetrics, this.flowMetrics, {this.from, this.to});
}

class Department {
  String name;
  String i;
  String j;

  Department(this.name, this.i, this.j);

  @override
  String toString() {
    return "Department: $name, $i, $j";
  }
}
