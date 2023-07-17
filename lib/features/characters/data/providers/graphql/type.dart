// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:sw_and_rick_morty_app/config/constants/links.dart';

final HttpLink httpLink = HttpLink(AppLinks.graph_url);

final Link link = httpLink;

ValueNotifier<GraphQLClient> client = ValueNotifier(
  GraphQLClient(
    link: link,
    cache: GraphQLCache(store: HiveStore()),
  ),
);

class GraphClientState {
  final GraphQLClient client;
  final ValueNotifier<GraphQLClient> widget_client;
  GraphClientState({
    required this.client,
    required this.widget_client,
  });

  factory GraphClientState.baseClient() {
    return GraphClientState(
        client: GraphQLClient(
          link: link,
          cache: GraphQLCache(store: HiveStore()),
        ),
        widget_client: ValueNotifier(
          GraphQLClient(
            link: link,
            cache: GraphQLCache(store: HiveStore()),
          ),
        ));
  }
  factory GraphClientState.withAuth(String token) {
    final _link = link.concat(AuthLink(
      getToken: () async => 'Bearer $token',
    ));

    return GraphClientState(
        client: GraphQLClient(
          link: _link,
          cache: GraphQLCache(store: HiveStore()),
        ),
        widget_client: ValueNotifier(
          GraphQLClient(
            link: _link,
            cache: GraphQLCache(store: HiveStore()),
          ),
        ));
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GraphClientState &&
        other.client == client &&
        other.widget_client == widget_client;
  }

  @override
  int get hashCode => client.hashCode ^ widget_client.hashCode;
}
