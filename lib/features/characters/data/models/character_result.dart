import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:sw_and_rick_morty_app/features/characters/data/models/character.dart';
import 'package:sw_and_rick_morty_app/features/characters/data/models/info.dart';

class CharacterResultModel {
  final ResultInfo info;
  final List<CharacterModel> characters;
  CharacterResultModel({
    required this.info,
    required this.characters,
  });

  CharacterResultModel copyWith({
    ResultInfo? info,
    List<CharacterModel>? characters,
  }) {
    return CharacterResultModel(
      info: info ?? this.info,
      characters: characters ?? this.characters,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'info': info.toMap()});
    result.addAll({'characters': characters.map((x) => x.toMap()).toList()});

    return result;
  }

  factory CharacterResultModel.fromMap(Map<String, dynamic> map) {
    return CharacterResultModel(
      info: ResultInfo.fromMap(map['info']),
      characters: List<CharacterModel>.from(
          map['characters']?.map((x) => CharacterModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory CharacterResultModel.fromJson(String source) =>
      CharacterResultModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'CharacterResultModel(info: $info, characters: $characters)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CharacterResultModel &&
        other.info == info &&
        listEquals(other.characters, characters);
  }

  @override
  int get hashCode => info.hashCode ^ characters.hashCode;
}
