// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DefinitionDetail {
  String? id;
  String? definition;
  String? createdAt;

  DefinitionDetail({
    this.id,
    this.definition,
    this.createdAt,
  });

  DefinitionDetail copyWith({
    String? id,
    String? definition,
    String? createdAt,
  }) {
    return DefinitionDetail(
      id: id ?? this.id,
      definition: definition ?? this.definition,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'definition': definition,
      'created_at': createdAt,
    };
  }

  factory DefinitionDetail.fromMap(Map<String, dynamic> map) {
    return DefinitionDetail(
      id: map['id'] != null ? map['id'] as String : null,
      definition: map['definition'] != null ? map['definition'] as String : null,
      createdAt: map['created_at'] != null ? map['created_at'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DefinitionDetail.fromJson(String source) => DefinitionDetail.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'DefinitionDetail(id: $id, definition: $definition, createdAt: $createdAt)';

  @override
  bool operator ==(covariant DefinitionDetail other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.definition == definition &&
      other.createdAt == createdAt;
  }

  @override
  int get hashCode => id.hashCode ^ definition.hashCode ^ createdAt.hashCode;
}
