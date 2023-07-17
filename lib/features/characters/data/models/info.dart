import 'dart:convert';

class ResultInfo {
  final int count;
  final int pages;
  final int? next;
  final int? prev;
  ResultInfo({
    required this.count,
    required this.pages,
    this.next,
    this.prev,
  });

  ResultInfo copyWith({
    int? count,
    int? pages,
    int? next,
    int? prev,
  }) {
    return ResultInfo(
      count: count ?? this.count,
      pages: pages ?? this.pages,
      next: next ?? this.next,
      prev: prev ?? this.prev,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'count': count});
    result.addAll({'pages': pages});
    if (next != null) {
      result.addAll({'next': next});
    }
    if (prev != null) {
      result.addAll({'prev': prev});
    }

    return result;
  }

  factory ResultInfo.fromMap(Map<String, dynamic> map) {
    return ResultInfo(
      count: map['count']?.toInt() ?? 0,
      pages: map['pages']?.toInt() ?? 0,
      next: map['next']?.toInt(),
      prev: map['prev']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ResultInfo.fromJson(String source) =>
      ResultInfo.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ResultInfo(count: $count, pages: $pages, next: $next, prev: $prev)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ResultInfo &&
        other.count == count &&
        other.pages == pages &&
        other.next == next &&
        other.prev == prev;
  }

  @override
  int get hashCode {
    return count.hashCode ^ pages.hashCode ^ next.hashCode ^ prev.hashCode;
  }
}
