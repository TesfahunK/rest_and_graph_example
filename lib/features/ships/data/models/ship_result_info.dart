import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:sw_and_rick_morty_app/features/ships/data/models/ship.dart';

class ShipResultInfo {
  final int? next;
  final List<ShipModel> results;
  ShipResultInfo({
    this.next,
    required this.results,
  });

  ShipResultInfo copyWith({
    int? next,
    List<ShipModel>? results,
  }) {
    return ShipResultInfo(
      next: next ?? this.next,
      results: results ?? this.results,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (next != null) {
      result.addAll({'next': next});
    }
    result.addAll({'results': results.map((x) => x.toMap()).toList()});

    return result;
  }

  factory ShipResultInfo.fromMap(Map<String, dynamic> map) {
    return ShipResultInfo(
      next: map['next'] == null
          ? null
          : int.parse(map['next']!.toString().split("=").last.toString()),
      results: List<ShipModel>.from(
          map['results']?.map((x) => ShipModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory ShipResultInfo.fromJson(String source) =>
      ShipResultInfo.fromMap(json.decode(source));

  @override
  String toString() => 'ShipResultInfo(next: $next, results: $results)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ShipResultInfo &&
        other.next == next &&
        listEquals(other.results, results);
  }

  @override
  int get hashCode => next.hashCode ^ results.hashCode;
}
