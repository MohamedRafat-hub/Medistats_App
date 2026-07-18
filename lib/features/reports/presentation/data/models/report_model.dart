class LabReportModel {
  final String id;
  final String patientId;
  final String reportName;
  final String fileUrl;
  final String fileType;
  final DateTime uploadedAt;

  LabReportModel({
    required this.id,
    required this.patientId,
    required this.reportName,
    required this.fileUrl,
    required this.fileType,
    required this.uploadedAt,
  });

  factory LabReportModel.fromJson(Map<String, dynamic> json, String docId) {
    return LabReportModel(
      id: docId,
      patientId: json['patientId'] as String,
      reportName: json['reportName'] as String,
      fileUrl: json['fileUrl'] as String,
      fileType: json['fileType'] as String,
      uploadedAt: DateTime.parse(json['uploadedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'patientId': patientId,
      'reportName': reportName,
      'fileUrl': fileUrl,
      'fileType': fileType,
      'uploadedAt': uploadedAt.toIso8601String(),
    };
  }
}