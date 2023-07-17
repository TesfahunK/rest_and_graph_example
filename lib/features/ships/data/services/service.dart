import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sw_and_rick_morty_app/features/ships/data/models/ship_result_info.dart';
import 'package:sw_and_rick_morty_app/features/ships/data/services/types.dart';
import 'package:sw_and_rick_morty_app/features/ships/utils/data/dio_setup.dart';

final shipServiceProvider = Provider((ref) => ShipService(ref));

class ShipService {
  final Ref ref;

  ShipService(this.ref);
  Future<Either<BasicFailure, ShipResultInfo>> getShips({int page = 1}) async {
    try {
      final response =
          await dioClient.get("/", queryParameters: {"page": page});
      final result = ShipResultInfo.fromMap(response.data);

      return right(result);
    } on DioException catch (e) {
      return left(BasicFailure(message: e.message ?? "Error Fetching Ships"));
    }
  }
}
