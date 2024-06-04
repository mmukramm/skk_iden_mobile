import 'dart:convert';

class UserModel {
  final String id;
  final String name;
  final String username;
  final bool isAdmin;
  final String createdAt;
  UserModel({
    required this.id,
    required this.name,
    required this.username,
    required this.isAdmin,
    required this.createdAt,
  });


  UserModel copyWith({
    String? id,
    String? name,
    String? username,
    bool? isAdmin,
    String? createdAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      username: username ?? this.username,
      isAdmin: isAdmin ?? this.isAdmin,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'username': username,
      'is_admin': isAdmin,
      'created_at': createdAt,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      name: map['name'] as String,
      username: map['username'] as String,
      isAdmin: map['is_admin'] as bool,
      createdAt: map['created_at'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, username: $username, isAdmin: $isAdmin, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.username == username &&
      other.isAdmin == isAdmin &&
      other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      username.hashCode ^
      isAdmin.hashCode ^
      createdAt.hashCode;
  }
}
