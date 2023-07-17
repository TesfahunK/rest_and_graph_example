import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sw_and_rick_morty_app/config/constants/ui.dart';
import 'package:sw_and_rick_morty_app/features/shared/other/util/ui/widgets.dart';
import 'package:sw_and_rick_morty_app/features/shared/other/widgets/loader.dart';
import 'package:sw_and_rick_morty_app/features/ships/data/providers/ship/provider.dart';

class AllShips extends ConsumerWidget {
  const AllShips({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shipState = ref.watch(shipStateProvider);
    final controller = ref.read(shipStateProvider.notifier);
    return Scaffold(
        body: NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification is ScrollEndNotification) {
                if (notification.metrics.pixels ==
                    notification.metrics.maxScrollExtent) {
                  final next = shipState.result?.isRight() ?? false;

                  if (next) {
                    final int? page =
                        shipState.result!.fold((l) => null, (r) => r)!.next;

                    if (page != null) {
                      controller.fetchMoreShips(page: page);
                    }
                  }
                }
              }

              return false;
            },
            child: RefreshIndicator(
                onRefresh: () async => await controller.fetchShips(),
                child: Builder(
                  builder: (context) {
                    if (shipState.loading) {
                      return const Center(
                        child: Loader(),
                      );
                    } else {
                      return shipState.result!.fold(
                        (l) => CommonWidgets.errorWidget(
                            msg: l.message,
                            retry: () => controller.fetchShips()),
                        (r) => CustomScrollView(
                          slivers: [
                            SliverList(
                                delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                final item = r.results[index];
                                return Container(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: UiConstants.primaryColor),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: ListTile(
                                    leading: const Icon(
                                      FontAwesomeIcons.shuttleSpace,
                                      size: 45,
                                    ),
                                    title: Text(item.name),
                                    subtitle: Text(item.manufacturer),
                                    trailing: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(Icons.group),
                                        Text(item.crew)
                                      ],
                                    ),
                                  ),
                                );
                              },
                              childCount: r.results.length,
                            )),
                            // SliverToBoxAdapter(
                            //   child: SizedBox(
                            //       height: 100,
                            //       child: Center(
                            //           child: result.isLoading
                            //               ? const Loader()
                            //               : const SizedBox.shrink())),
                            // )
                          ],
                        ),
                      );
                    }
                  },
                ))));
  }
}
