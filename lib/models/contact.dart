class Contact {
  const Contact({
    required this.name,
    required this.email,
    required this.phone,
    this.imagePath,
  });

  final String name;
  final String email;
  final String phone;
  final String? imagePath;
}
