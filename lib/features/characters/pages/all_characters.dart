import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:logger/logger.dart';
import 'package:sw_and_rick_morty_app/config/constants/ui.dart';
import 'package:sw_and_rick_morty_app/features/characters/data/models/character_result.dart';
import 'package:sw_and_rick_morty_app/features/characters/utils/queries/queries.dart';
import 'package:sw_and_rick_morty_app/features/shared/other/util/ui/widgets.dart';
import 'package:sw_and_rick_morty_app/features/shared/other/widgets/loader.dart';

FetchMoreOptions fetchMoreConfig(Map<String, dynamic> variables) =>
    FetchMoreOptions(
      variables: variables,
      updateQuery: (previousResultData, fetchMoreResultData) {
        final List<dynamic> merged = [
          ...previousResultData!['characters']['characters'] as List<dynamic>,
          ...fetchMoreResultData!['characters']['characters'] as List<dynamic>
        ];

        // to avoid a lot of work, lets just update the list of repos in returned
        // data with new data, this also ensures we have the endCursor already set
        // correctly

        fetchMoreResultData['characters']['characters'] = merged;

        return fetchMoreResultData;
      },
    );

class AllCharacters extends StatelessWidget {
  const AllCharacters({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Query(
        options: QueryOptions(
            fetchPolicy: FetchPolicy.cacheAndNetwork,
            variables: const {"page": 1},
            document: allCharactersQuery()),
        builder: (result, {fetchMore, refetch}) {
          if (result.isLoading && result.data == null) {
            return const Center(
              child: Loader(),
            );
          } else if (result.data != null) {
            final _result =
                CharacterResultModel.fromMap(result.data!['characters']);
            return NotificationListener<ScrollNotification>(
                onNotification: (notification) {
                  if (notification is ScrollEndNotification) {
                    if (notification.metrics.pixels ==
                        notification.metrics.maxScrollExtent) {
                      if (_result.info.next != null) {
                        fetchMore!(
                            fetchMoreConfig({"page": _result.info.next}));
                      }
                    }
                  }

                  return false;
                },
                child: RefreshIndicator(
                  onRefresh: () async => await refetch!(),
                  child: CustomScrollView(
                    slivers: [
                      SliverList(
                          delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final item = _result.characters[index];
                          return Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: UiConstants.primaryColor),
                                borderRadius: BorderRadius.circular(10)),
                            child: ListTile(
                              leading: CommonWidgets.networkImageLoader(
                                  url: item.image,
                                  height: 50,
                                  width: 50,
                                  shape: BoxShape.circle),
                              title: Text(item.name),
                              subtitle: Text(item.status),
                            ),
                          );
                        },
                        childCount: _result.characters.length,
                      )),
                      SliverToBoxAdapter(
                        child: SizedBox(
                            height: 100,
                            child: Center(
                                child: result.isLoading
                                    ? const Loader()
                                    : const SizedBox.shrink())),
                      )
                    ],
                  ),
                ));
          } else if (result.hasException) {
            final exception = result.exception!.linkException;
            final String error = exception is LinkException
                ? "Newtwork Error Please try again"
                : result.exception!.graphqlErrors.first.message;

            return CommonWidgets.errorWidget(
                retry: () => refetch!(), msg: error);
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
