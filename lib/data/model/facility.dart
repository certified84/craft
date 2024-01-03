class Facility {
  String id;
  String name;
  int numberOfDepartments;
  double totalArea;
  double initialScore;
  double optimizedScore;
  List<Optimization> optimizations;

  Facility(
    this.id,
    this.name,
    this.numberOfDepartments,
    this.totalArea,
    this.initialScore,
    this.optimizedScore,
    this.optimizations,
  );

  factory Facility.fromMap(Map map) {
    Facility item = Facility(
      map['id'],
      map['name'],
      map['numberOfDepartments'],
      map['totalArea'],
      map['initialScore'],
      map['optimizedScore'],
      map['optimizations'],
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
