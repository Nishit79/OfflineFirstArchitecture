import 'package:hive/hive.dart';

part 'user_hive_model.g.dart';

@HiveType(typeId: 1)
class UserHiveModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final bool isSynced;

  @HiveField(3)
  final DateTime updatedAt;

  UserHiveModel({
    required this.id,
    required this.name,
    required this.isSynced,
    required this.updatedAt,
  });

  // ✅ copyWith (REQUIRED for immutability)
  UserHiveModel copyWith({
    String? id,
    String? name,
    bool? isSynced,
    DateTime? updatedAt,
  }) {
    return UserHiveModel(
      id: id ?? this.id,
      name: name ?? this.name,
      isSynced: isSynced ?? this.isSynced,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  // ✅ fromJson (used during sync pull)
  factory UserHiveModel.fromJson(Map<String, dynamic> json) {
    return UserHiveModel(
      id: json['id'] as String,
      name: json['name'] as String,
      isSynced: true, // server data is always synced
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  // (Optional but professional)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
