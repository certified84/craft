import 'package:craft/data/model/distance.dart';
import 'package:craft/data/model/optimization.dart';

class Facility {
  String? id;
  String? name;
  int? numberOfDepartments;
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
    this.numberOfDepartments,
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
      numberOfDepartments: map['numberOfDepartments'],
      totalArea: map['totalArea'],
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
      'numberOfDepartments': numberOfDepartments,
      'totalArea': totalArea,
      'initialScore': initialScore,
      'optimizedScore': optimizedScore,
      'optimizations': optimizations
    };
  }
}

class Optimization {
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

  FacilityLayout(
    this.distanceMetrics,
    this.flowMetrics,
  );
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
