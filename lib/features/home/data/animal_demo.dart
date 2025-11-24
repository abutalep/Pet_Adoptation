class AnimalDemo {
  final String name;
  final String imageUrl;
  final String location;
  final String timeAgo;

  final String status;
  final String category;
  final String color;
  final String age;

  final String ownerName;
  final String ownerEmail;

  final String description;
  final double? reward;

  const AnimalDemo({
    required this.name,
    required this.imageUrl,
    required this.location,
    required this.timeAgo,

    this.status = "Lost",
    this.category = "",
    this.color = "",
    this.age = "",

    this.ownerName = "",
    this.ownerEmail = "",
    this.description = "",
    this.reward,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'imageUrl': imageUrl,
      'location': location,
      'timeAgo': timeAgo,
      'status': status,
      'category': category,
      'color': color,
      'age': age,
      'ownerName': ownerName,
      'ownerEmail': ownerEmail,
      'description': description,
      'reward': reward,
    };
  }

  factory AnimalDemo.fromMap(Map<String, dynamic> map) {
    return AnimalDemo(
      name: map['name'],
      imageUrl: map['imageUrl'],
      location: map['location'],
      timeAgo: map['timeAgo'],
      status: map['status'],
      category: map['category'],
      color: map['color'],
      age: map['age'],
      ownerName: map['ownerName'],
      ownerEmail: map['ownerEmail'],
      description: map['description'],
      reward: map['reward'],
    );
  }
}
