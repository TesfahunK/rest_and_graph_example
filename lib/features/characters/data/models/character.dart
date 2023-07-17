import 'dart:convert';

class CharacterModel {
  final String id;
  final String name;
  final String status;
  final String image;
  CharacterModel({
    required this.id,
    required this.name,
    required this.status,
    required this.image,
  });

  CharacterModel copyWith({
    String? id,
    String? name,
    String? status,
    String? image,
  }) {
    return CharacterModel(
      id: id ?? this.id,
      name: name ?? this.name,
      status: status ?? this.status,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'status': status});
    result.addAll({'image': image});

    return result;
  }

  factory CharacterModel.fromMap(Map<String, dynamic> map) {
    return CharacterModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      status: map['status'] ?? '',
      image: map['image'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CharacterModel.fromJson(String source) =>
      CharacterModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CharacterModel(id: $id, name: $name, status: $status, image: $image)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CharacterModel &&
        other.id == id &&
        other.name == name &&
        other.status == status &&
        other.image == image;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ status.hashCode ^ image.hashCode;
  }
}
