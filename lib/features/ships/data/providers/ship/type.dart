import 'package:dartz/dartz.dart';

import 'package:sw_and_rick_morty_app/features/ships/data/models/ship_result_info.dart';
import 'package:sw_and_rick_morty_app/features/ships/data/services/types.dart';

class ShipResultState {
  final bool loading;
  final Either<BasicFailure, ShipResultInfo>? result;
  ShipResultState({
    this.loading = true,
    this.result,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ShipResultState &&
        other.loading == loading &&
        other.result == result;
  }

  @override
  int get hashCode => loading.hashCode ^ result.hashCode;

  ShipResultState copyWith({
    bool? loading,
    Either<BasicFailure, ShipResultInfo>? result,
  }) {
    return ShipResultState(
      loading: loading ?? this.loading,
      result: result ?? this.result,
    );
  }
}
