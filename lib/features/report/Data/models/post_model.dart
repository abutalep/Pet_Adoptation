class AnimalReport {
  final String id;
  final String? name;
  final String category;
  final String color;
  final int? age;
  final double? reward;
  
  final String userName;
  final String userEmail;
  
  final String description;
  
  final String location; 
  final double? latitude;
  final double? longitude;
  
  final DateTime lostDateTime;
  final int timestamp;
  
  final List<String>? images;
  
  final String status; 

  AnimalReport({
    required this.id,
    this.name,
    required this.category,
    required this.color,
    this.age,
    this.reward,
    required this.userName,
    required this.userEmail,
    required this.description,
    required this.location,
    this.latitude,
    this.longitude,
    required this.lostDateTime,
    required this.timestamp,
    this.images,
    required this.status,
  });

  
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'color': color,
      'age': age,
      'reward': reward,
      'userName': userName,
      'userEmail': userEmail,
      'description': description,
      'location': location,
      'latitude': latitude,
      'longitude': longitude,
      'lostDateTime': lostDateTime.toIso8601String(),
      'timestamp': timestamp,
      'images': images,
      'status': status,
    };
  }

  
  factory AnimalReport.fromMap(Map<String, dynamic> json) {
    return AnimalReport(
      id: json['id'] as String,
      name: json['name'] as String?,
      category: json['category'] as String,
      color: json['color'] as String,
      age: json['age'] as int?,
      reward: json['reward'] != null ? (json['reward'] as num).toDouble() : null,
      userName: json['userName'] as String,
      userEmail: json['userEmail'] as String,
      description: json['description'] as String,
      location: json['location'] as String,
      latitude: json['latitude'] != null ? (json['latitude'] as num).toDouble() : null,
      longitude: json['longitude'] != null ? (json['longitude'] as num).toDouble() : null,
      lostDateTime: DateTime.parse(json['lostDateTime'] as String),
      timestamp: json['timestamp'] as int,
      images: json['images'] != null ? List<String>.from(json['images'] as List) : null,
      status: json['status'] as String,
    );
  }

  
  AnimalReport copyWith({
    String? id,
    String? name,
    String? category,
    String? color,
    int? age,
    double? reward,
    String? userName,
    String? userEmail,
    String? description,
    String? location,
    double? latitude,
    double? longitude,
    DateTime? lostDateTime,
    int? timestamp,
    List<String>? images,
    String? status,
  }) {
    return AnimalReport(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      color: color ?? this.color,
      age: age ?? this.age,
      reward: reward ?? this.reward,
      userName: userName ?? this.userName,
      userEmail: userEmail ?? this.userEmail,
      description: description ?? this.description,
      location: location ?? this.location,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      lostDateTime: lostDateTime ?? this.lostDateTime,
      timestamp: timestamp ?? this.timestamp,
      images: images ?? this.images,
      status: status ?? this.status,
    );
  }
}