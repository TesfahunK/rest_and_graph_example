import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sw_and_rick_morty_app/features/characters/data/providers/graphql/type.dart';

final graphqlstateProvider =
    StateNotifierProvider<GraphqlStateProvider, GraphClientState>(
        (ref) => GraphqlStateProvider());

class GraphqlStateProvider extends StateNotifier<GraphClientState> {
  GraphqlStateProvider() : super(GraphClientState.baseClient());

  void updateAuth(String token) {
    state = GraphClientState.withAuth(token);
  }
}
