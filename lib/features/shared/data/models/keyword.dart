// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:skk_iden_mobile/features/shared/data/models/keyword_data.dart';
import 'package:skk_iden_mobile/features/shared/data/models/pagination.dart';

class Keyword {
  List<KeywordData>? keywordData;
  Pagination? pagination;
  Keyword({
    this.keywordData,
    this.pagination,
  });

  Keyword copyWith({
    List<KeywordData>? keywordData,
    Pagination? pagination,
  }) {
    return Keyword(
      keywordData: keywordData ?? this.keywordData,
      pagination: pagination ?? this.pagination,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'keywordData': keywordData?.map((x) => x.toMap()).toList(),
      'pagination': pagination?.toMap(),
    };
  }

  factory Keyword.fromMap(Map<String, dynamic> map) {
    return Keyword(
      keywordData: map['keyword_data'] != null
          ? List<KeywordData>.from(
              (map['keyword_data'] as List<dynamic>).map<KeywordData?>(
                (x) => KeywordData.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      pagination: map['pagination'] != null
          ? Pagination.fromMap(map['pagination'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Keyword.fromJson(String source) =>
      Keyword.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Keyword(keywordData: $keywordData, pagination: $pagination)';

  @override
  bool operator ==(covariant Keyword other) {
    if (identical(this, other)) return true;

    return listEquals(other.keywordData, keywordData) &&
        other.pagination == pagination;
  }

  @override
  int get hashCode => keywordData.hashCode ^ pagination.hashCode;
}
