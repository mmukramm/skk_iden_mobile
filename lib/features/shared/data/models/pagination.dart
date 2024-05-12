// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Pagination {
  int? currentPage;
  int? totalPage;
  int? totalData;
  int? nextPage;
  int? prevPage;
  Pagination({
    this.currentPage,
    this.totalPage,
    this.totalData,
    this.nextPage,
    this.prevPage,
  });


  Pagination copyWith({
    int? currentPage,
    int? totalPage,
    int? totalData,
    int? nextPage,
    int? prevPage,
  }) {
    return Pagination(
      currentPage: currentPage ?? this.currentPage,
      totalPage: totalPage ?? this.totalPage,
      totalData: totalData ?? this.totalData,
      nextPage: nextPage ?? this.nextPage,
      prevPage: prevPage ?? this.prevPage,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'currentPage': currentPage,
      'totalPage': totalPage,
      'totalData': totalData,
      'nextPage': nextPage,
      'prevPage': prevPage,
    };
  }

  factory Pagination.fromMap(Map<String, dynamic> map) {
    return Pagination(
      currentPage: map['current_page'] != null ? map['current_page'] as int : null,
      totalPage: map['total_page'] != null ? map['total_page'] as int : null,
      totalData: map['total_data'] != null ? map['total_data'] as int : null,
      nextPage: map['next_page'] != null ? map['next_page'] as int : null,
      prevPage: map['prev_page'] != null ? map['prev_page'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Pagination.fromJson(String source) => Pagination.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Pagination(currentPage: $currentPage, totalPage: $totalPage, totalData: $totalData, nextPage: $nextPage, prevPage: $prevPage)';
  }

  @override
  bool operator ==(covariant Pagination other) {
    if (identical(this, other)) return true;
  
    return 
      other.currentPage == currentPage &&
      other.totalPage == totalPage &&
      other.totalData == totalData &&
      other.nextPage == nextPage &&
      other.prevPage == prevPage;
  }

  @override
  int get hashCode {
    return currentPage.hashCode ^
      totalPage.hashCode ^
      totalData.hashCode ^
      nextPage.hashCode ^
      prevPage.hashCode;
  }
}
