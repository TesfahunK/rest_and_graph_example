import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sw_and_rick_morty_app/features/ships/data/models/ship_result_info.dart';
import 'package:sw_and_rick_morty_app/features/ships/data/providers/ship/type.dart';
import 'package:sw_and_rick_morty_app/features/ships/data/services/service.dart';

final shipStateProvider =
    StateNotifierProvider<ShipResultStateProvider, ShipResultState>(
        (ref) => ShipResultStateProvider(ref.read(shipServiceProvider)));

class ShipResultStateProvider extends StateNotifier<ShipResultState> {
  final ShipService service;

  ShipResultStateProvider(this.service) : super(ShipResultState()) {
    fetchShips();
  }

  Future fetchShips() async {
    state = state.copyWith(loading: true, result: null);

    final result = await service.getShips();

    state = state.copyWith(loading: false, result: result);
  }

  Future fetchMoreShips({required int page}) async {
    final result = await service.getShips(page: page);

    final _previousResult = state.result!.fold((l) => null, (r) => r)!.results;

    result.fold((l) => state = state.copyWith(loading: false), (r) {
      state = state.copyWith(
          loading: false,
          result: result.fold(
              (l) => left(l),
              (r) => right(ShipResultInfo(
                  next: r.next, results: [..._previousResult, ...r.results]))));
    });
  }
}
