class ClubModel {
  final String id;
  final String name;
  final String subtitle;
  final String description;
  final String category;
  final String email;
  final String phone;
  final String facebookLink;
  final String website;
  final int members;
  final int followers;
  final String image;
  final String president;
  final String vicePresident;
  final String facultyAdvisor;
  final DateTime createdAt;
  final bool isApproved;

  ClubModel({
    required this.id,
    required this.name,
    required this.subtitle,
    required this.description,
    required this.category,
    required this.email,
    required this.phone,
    required this.facebookLink,
    required this.website,
    required this.members,
    required this.followers,
    required this.image,
    required this.president,
    required this.vicePresident,
    required this.facultyAdvisor,
    required this.createdAt,
    required this.isApproved,
  });

  factory ClubModel.fromJson(Map<String, dynamic> json) {
    return ClubModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      subtitle: json['subtitle'] ?? '',
      description: json['description'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      category: json['category'] ?? '',
      image: json['image'] ?? '',
      facebookLink: json['facebookLink'] ?? '',
      website: json['website'] ?? '',
      members: json['members'] ?? 0,
      followers: json['followers'] ?? 0,
      president: json['president'] ?? '',
      vicePresident: json['vicePresident'] ?? '',
      facultyAdvisor: json['facultyAdvisor'] ?? '',
      isApproved: json['isApproved'] ?? false,
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
    );
  }
}
