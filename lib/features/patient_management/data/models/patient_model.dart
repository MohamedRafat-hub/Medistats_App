class PatientModel {
  final String id;
  final String name;
  final int age;
  final String phoneNumber;

  PatientModel({
    required this.id,
    required this.name,
    required this.age,
    required this.phoneNumber,
  });


  factory PatientModel.fromJson(Map<String, dynamic> json, String docId) {
    return PatientModel(
      id: docId,
      name: json['name'] as String,
      age: (json['age'] as num).toInt(),
      phoneNumber: json['phoneNumber'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'age': age,
      'phoneNumber': phoneNumber,
    };
  }
}