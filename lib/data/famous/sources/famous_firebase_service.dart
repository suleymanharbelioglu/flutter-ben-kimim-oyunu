// Abstract service defines the contract
import 'dart:math';

import 'package:ben_kimim/data/famous/model/famous.dart';
import 'package:ben_kimim/domain/famous/entity/famous.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

abstract class FamousFirebaseService {
  // Load all famous names from Firestore and cache them
  Future<Either> loadCache();

  // Get a random famous name from cache
  FamousEntity getRandomFromCache();
}

// Implementation
class FamousFirebaseServiceImpl extends FamousFirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Cache for fetched famous names
  List<FamousEntity> _cache = [];

  @override
  Future<Either> loadCache() async {
    if (_cache.isNotEmpty) {
      print(_cache.toString());

      return Right("cached is success------------");
    }

    try {
      final snapshot = await _firestore.collection('famous_names').get();
      _cache = snapshot.docs.map((doc) {
        final model = FamousModel.fromMap(doc.data());
        return model.toEntity(); // Use extension here
      }).toList();
      print(_cache.toString());
      return Right("cached is success------------");
    } catch (e) {
      return Left("Error fetching famous names: $e");
    }
  }

  @override
  FamousEntity getRandomFromCache() {
    final randomIndex = Random().nextInt(_cache.length);
    return _cache[randomIndex];
  }
}
