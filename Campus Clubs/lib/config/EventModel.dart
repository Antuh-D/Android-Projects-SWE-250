class EventModel {
  final String id;
  final String title;
  final String club;
  final String category;
  final String date;
  final String time;
  final String location;
  final String description;
  final String? image;

  EventModel({
    required this.id,
    required this.title,
    required this.club,
    required this.category,
    required this.date,
    required this.time,
    required this.location,
    required this.description,
    this.image,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['_id'] ?? '',
      title: json['title'],
      club: json['club'],
      category: json['category'],
      date: json['date'],
      time: json['time'],
      location: json['location'],
      description: json['description'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "club": club,
      "category": category,
      "date": date,
      "time": time,
      "location": location,
      "description": description,
      "image": image,
    };
  }
}
