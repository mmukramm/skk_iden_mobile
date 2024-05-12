import 'dart:convert';

class KeywordData {
  String? keywordId;
  String? keyword;
  String? definition;
  String? user;
  String? createdAt;
  KeywordData({
    this.keywordId,
    this.keyword,
    this.definition,
    this.user,
    this.createdAt,
  });

  KeywordData copyWith({
    String? keywordId,
    String? keyword,
    String? definition,
    String? user,
    String? createdAt,
  }) {
    return KeywordData(
      keywordId: keywordId ?? this.keywordId,
      keyword: keyword ?? this.keyword,
      definition: definition ?? this.definition,
      user: user ?? this.user,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'keywordId': keywordId,
      'keyword': keyword,
      'definition': definition,
      'user': user,
      'createdAt': createdAt,
    };
  }

  factory KeywordData.fromMap(Map<String, dynamic> map) {
    return KeywordData(
      keywordId: map['keyword_id'] != null ? map['keyword_id'] as String : null,
      keyword: map['keyword'] != null ? map['keyword'] as String : null,
      definition: map['definition'] != null ? map['definition'] as String : null,
      user: map['user'] != null ? map['user'] as String : null,
      createdAt: map['created_at'] != null ? map['created_at'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory KeywordData.fromJson(String source) => KeywordData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'KeywordData(keywordId: $keywordId, keyword: $keyword, definition: $definition, user: $user, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant KeywordData other) {
    if (identical(this, other)) return true;
  
    return 
      other.keywordId == keywordId &&
      other.keyword == keyword &&
      other.definition == definition &&
      other.user == user &&
      other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return keywordId.hashCode ^
      keyword.hashCode ^
      definition.hashCode ^
      user.hashCode ^
      createdAt.hashCode;
  }
}
