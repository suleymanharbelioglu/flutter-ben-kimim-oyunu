import 'package:ben_kimim/domain/famous/entity/famous.dart';

class FamousModel {
  final String name;

  FamousModel({required this.name});

  // Create FamousModel from Map
  factory FamousModel.fromMap(Map<String, dynamic> map) {
    return FamousModel(name: map['name'] ?? '');
  }
}

// Extension for conversion
extension FamousModelX on FamousModel {
  FamousEntity toEntity() {
    return FamousEntity(name: name);
  }
}
