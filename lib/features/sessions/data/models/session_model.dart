import 'package:cloud_firestore/cloud_firestore.dart';

class SessionModel {
  final String sessionId;
  final String patientId;
  final DateTime createdAt;
  final String diagnosis;
  final String prescription;
  final String notes;

  SessionModel({
    required this.sessionId,
    required this.patientId,
    required this.createdAt,
    required this.diagnosis,
    required this.prescription,
    required this.notes,
  });

  factory SessionModel.fromJson(Map<String, dynamic> json, String docId) {
    return SessionModel(
      sessionId: docId,
      patientId: (json['patientId'] ?? '') as String,
      createdAt: (json['createdAt'] as Timestamp).toDate(),
      diagnosis: (json['diagnosis'] ?? '') as String,
      prescription: (json['prescription'] ?? '') as String,
      notes: (json['notes'] ?? '') as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'patientId': patientId,
      'createdAt': Timestamp.fromDate(createdAt),
      'diagnosis': diagnosis,
      'prescription': prescription,
      'notes': notes,
    };
  }
}
