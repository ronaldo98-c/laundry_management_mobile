class User {
  final int id;
  final String? firstName;
  final String? lastName;
  final String email;

  User({
    required this.id,
    this.firstName,
    this.lastName,
    required this.email
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email']
    );
  }
}