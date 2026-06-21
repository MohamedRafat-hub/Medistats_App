class PatientSession {
  final String title;
  final String dateLabel;
  final String diagnosis;
  final String prescription;
  final String notes;
  final bool isLatest;

  const PatientSession({
    required this.title,
    required this.dateLabel,
    required this.diagnosis,
    required this.prescription,
    required this.notes,
    this.isLatest = false,
  });
}
