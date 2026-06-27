
import 'package:cloud_firestore/cloud_firestore.dart';

class PatientModel {
  final String id;
  final String name;
  final int age;
  final String phoneNumber;
  final DateTime createdAt;
   bool hasDiabetes;
   bool hasHighBloodPressure;


  PatientModel({
    required this.id,
    required this.name,
    required this.age,
    required this.phoneNumber,
    required this.createdAt,
    this.hasDiabetes = false,
    this.hasHighBloodPressure = false,
  });

  factory PatientModel.fromJson(Map<String, dynamic> json, String docId) {
    return PatientModel(
      id: docId,
      name: json['name'] as String,
      age: (json['age'] as num).toInt(),
      phoneNumber: json['phoneNumber'] as String,
      createdAt: (json['createdAt'] as Timestamp).toDate(),
      hasDiabetes: json['hasDiabetes'] as bool,
      hasHighBloodPressure: json['hasHighBloodPressure'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'age': age,
      'phoneNumber': phoneNumber,
      'createdAt': Timestamp.fromDate(createdAt),
      'hasDiabetes': hasDiabetes,
      'hasHighBloodPressure': hasHighBloodPressure,
    };
  }
}