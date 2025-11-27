import 'package:cloud_firestore/cloud_firestore.dart';

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

  factory AnimalReport.fromMap(Map<String, dynamic> map) {
    return AnimalReport(
      id: map['id'] as String,
      name: map['name'] as String?,
      category: map['category'] as String,
      color: map['color'] as String,
      age: map['age'] != null ? (map['age'] as num).toInt() : null,
      reward: map['reward'] != null ? (map['reward'] as num).toDouble() : null,
      userName: map['userName'] as String,
      userEmail: map['userEmail'] as String,
      description: map['description'] as String,
      location: map['location'] as String,
      latitude: map['latitude'] != null ? (map['latitude'] as num).toDouble() : null,
      longitude: map['longitude'] != null ? (map['longitude'] as num).toDouble() : null,
      lostDateTime: map['lostDateTime'] is Timestamp
          ? (map['lostDateTime'] as Timestamp).toDate()
          : DateTime.parse(map['lostDateTime'] as String),
      timestamp: map['timestamp'] as int,
      images: map['images'] != null ? List<String>.from(map['images'] as List) : null,
      status: map['status'] as String,
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
