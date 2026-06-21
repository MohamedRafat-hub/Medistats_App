class Patient {
  final String firstName;
  final String lastName;
  final int age;
  final String phoneNumber;
  final List<String> conditions;

  const Patient({
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.phoneNumber,
    required this.conditions,
  });
}
