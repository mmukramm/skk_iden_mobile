// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:skk_iden_mobile/features/shared/data/models/definition_detail.dart';

class KeywordDetail {
  String? keywordId;
  String? keyword;
  List<DefinitionDetail>? definition;
  KeywordDetail({
    this.keywordId,
    this.keyword,
    this.definition,
  });

  KeywordDetail copyWith({
    String? keywordId,
    String? keyword,
    List<DefinitionDetail>? definition,
  }) {
    return KeywordDetail(
      keywordId: keywordId ?? this.keywordId,
      keyword: keyword ?? this.keyword,
      definition: definition ?? this.definition,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'keyword_id': keywordId,
      'keyword': keyword,
      'definition': definition?.map((x) => x.toMap()).toList(),
    };
  }

  factory KeywordDetail.fromMap(Map<String, dynamic> map) {
    return KeywordDetail(
      keywordId: map['keyword_id'] != null ? map['keyword_id'] as String : null,
      keyword: map['keyword'] != null ? map['keyword'] as String : null,
      definition: map['definition'] != null
          ? List<DefinitionDetail>.from(
              (map['definition'] as List<dynamic>).map<DefinitionDetail?>(
                (x) => DefinitionDetail.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory KeywordDetail.fromJson(String source) =>
      KeywordDetail.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'KeywordDetail(keyword_id: $keywordId, keyword: $keyword, definition: $definition)';

  @override
  bool operator ==(covariant KeywordDetail other) {
    if (identical(this, other)) return true;

    return other.keywordId == keywordId &&
        other.keyword == keyword &&
        listEquals(other.definition, definition);
  }

  @override
  int get hashCode =>
      keywordId.hashCode ^ keyword.hashCode ^ definition.hashCode;
}
