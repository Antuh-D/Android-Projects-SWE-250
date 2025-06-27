class UserModel{
  final String id;
  final String name;
  final String email;
  final String registation;
  final String profilePicture;
  final String department;
  final String university;
  final String role;
  final String coverPicture;


  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.registation,
    required this.profilePicture,
    required this.role,
    required this.department,
    required this.university,
    required this.coverPicture,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'] ?? '',
      name: json['username'] ?? '',  // backend uses username for name
      email: json['email'] ?? '',
      registation: json['registration'] ?? '',
      profilePicture: json['profilePicture'] ?? '',
      department: json['department'] ?? '',
      university: json['university'] ?? '',
      coverPicture : json['coverPicture']??'',
      role: json['role'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'username': name,
      'email': email,
      'registration': registation,
      'profilePicture': profilePicture,
      'coverPicture':coverPicture,
      'department': department,
      'university': university,
      'role': role,
    };
  }
}