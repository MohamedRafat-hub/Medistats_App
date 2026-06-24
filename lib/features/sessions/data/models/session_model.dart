import 'package:cloud_firestore/cloud_firestore.dart';

class SessionModel {
  final String sessionId;
  final String patientId;
  final String title;
  final DateTime createdAt;
  final String diagnosis;
  final String prescription;
  final String notes;

  SessionModel({
    required this.sessionId,
    required this.patientId,
    required this.title,
    required this.createdAt,
    required this.diagnosis,
    required this.prescription,
    required this.notes,
  });

  factory SessionModel.fromJson(Map<String, dynamic> json, String docId) {
    return SessionModel(
      sessionId: docId,
      patientId: (json['patient_id'] ?? '') as String,
      title: (json['title'] ?? '') as String,
      createdAt: (json['created_at'] as Timestamp).toDate(),
      diagnosis: (json['diagnosis'] ?? '') as String,
      prescription: (json['prescription'] ?? '') as String,
      notes: (json['notes'] ?? '') as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'patient_id': patientId,
      'title': title,
      'created_at': Timestamp.fromDate(createdAt),
      'diagnosis': diagnosis,
      'prescription': prescription,
      'notes': notes,
    };
  }
}
