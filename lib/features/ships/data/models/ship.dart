import 'dart:convert';

class ShipModel {
  final String name;
  final String manufacturer;
  final String passengers;
  final String crew;
  final num length;
  ShipModel({
    required this.name,
    required this.manufacturer,
    required this.passengers,
    required this.crew,
    required this.length,
  });

  ShipModel copyWith({
    String? name,
    String? manufacturer,
    String? passengers,
    String? crew,
    num? length,
  }) {
    return ShipModel(
      name: name ?? this.name,
      manufacturer: manufacturer ?? this.manufacturer,
      passengers: passengers ?? this.passengers,
      crew: crew ?? this.crew,
      length: length ?? this.length,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'name': name});
    result.addAll({'manufacturer': manufacturer});
    result.addAll({'passengers': passengers});
    result.addAll({'crew': crew});
    result.addAll({'length': length});

    return result;
  }

  factory ShipModel.fromMap(Map<String, dynamic> map) {
    return ShipModel(
      name: map['name'] ?? '',
      manufacturer: map['manufacturer'] ?? '',
      passengers: map['passengers'] ?? '',
      crew: map['crew'] ?? '',
      length: 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ShipModel.fromJson(String source) =>
      ShipModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ShipModel(name: $name, manufacturer: $manufacturer, passengers: $passengers, crew: $crew, length: $length)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ShipModel &&
        other.name == name &&
        other.manufacturer == manufacturer &&
        other.passengers == passengers &&
        other.crew == crew &&
        other.length == length;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        manufacturer.hashCode ^
        passengers.hashCode ^
        crew.hashCode ^
        length.hashCode;
  }
}
