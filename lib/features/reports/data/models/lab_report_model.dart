class LabReportModel {
  final String id;
  final String patientId;
  final String sessionId;
  final String? reportName;
  final String fileUrl;
  final String fileType;
  final DateTime uploadedAt;
  final String? reportDescription;

  LabReportModel({
    required this.id,
    required this.patientId,
    required this.sessionId,
    this.reportName,
    required this.fileUrl,
    required this.fileType,
    required this.uploadedAt,
    this.reportDescription,
  });

  factory LabReportModel.fromJson(Map<String, dynamic> json, String docId) {
    return LabReportModel(
      id: docId,
      patientId: json['patientId'] as String,
      sessionId: json['sessionId'] as String,
      reportName: json['reportName'] as String?,
      fileUrl: json['fileUrl'] as String,
      fileType: json['fileType'] as String,
      uploadedAt: DateTime.parse(json['uploadedAt'] as String),
      reportDescription: json['reportDescription'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'patientId': patientId,
      'sessionId': sessionId,
      'reportName': reportName,
      'fileUrl': fileUrl,
      'fileType': fileType,
      'uploadedAt': uploadedAt.toIso8601String(),
      'reportDescription': reportDescription,
    };
  }

  LabReportModel copyWith({
    String? id,
    String? patientId,
    String? reportName,
    String? fileUrl,
    String? fileType,
    DateTime? uploadedAt,
    String? reportDescription,
    String? sessionId,
  }) {
    return LabReportModel(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      sessionId: sessionId ?? this.sessionId,
      reportName: reportName ?? this.reportName,
      fileUrl: fileUrl ?? this.fileUrl,
      fileType: fileType ?? this.fileType,
      uploadedAt: uploadedAt ?? this.uploadedAt,
      reportDescription: reportDescription ?? this.reportDescription,
    );
  }
}
