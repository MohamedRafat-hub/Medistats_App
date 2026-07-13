
import 'package:cloud_firestore/cloud_firestore.dart';

class RadiologyModel {
  final String? id;
  final String imageUrl;
  final DateTime uploadedAt;
  final String patientId;
  final String? xrayType;
  final String? notes;
  final String sessionId;

  RadiologyModel({
    this.id,
    required this.imageUrl,
    required this.uploadedAt,
    required this.patientId,
    this.xrayType,
    this.notes,
    required this.sessionId,
  });

  factory RadiologyModel.fromJson(Map<String, dynamic> json, String docId) {
    return RadiologyModel(
      id: docId,
      imageUrl: json['imageUrl'] as String,
      uploadedAt: (json['uploadedAt'] as Timestamp).toDate(),
      patientId: json['patientId'] as String,
      xrayType: json['xrayType'] as String?,
      notes: json['notes'] as String?,
      sessionId: json['sessionId'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'imageUrl': imageUrl,
      'uploadedAt': Timestamp.fromDate(uploadedAt),
      'patientId': patientId,
      'xrayType': xrayType,
      'notes': notes,
      'sessionId': sessionId,
    };
  }

  RadiologyModel copyWith({
    String? id,
    String? imageUrl,
    DateTime? uploadedAt,
    String? patientId,
    String? xrayType,
    String? notes,
    String? sessionId,
  }) {
    return RadiologyModel(
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      uploadedAt: uploadedAt ?? this.uploadedAt,
      patientId: patientId ?? this.patientId,
      xrayType: xrayType ?? this.xrayType,
      notes: notes ?? this.notes,
      sessionId: sessionId ?? this.sessionId,
    );
  }
}