String getInitials(String name) {
  List<String> nameParts = name.trim().split(RegExp(r'\s+'));

  if (nameParts.isEmpty || nameParts[0].isEmpty) {
    return '';
  }

  String firstInitial = nameParts[0][0].toUpperCase();

  String secondInitial = '';
  if (nameParts.length > 1) {
    secondInitial = nameParts[1][0].toUpperCase();
  }

  return '$firstInitial$secondInitial';
}