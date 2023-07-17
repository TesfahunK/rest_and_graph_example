// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sw_and_rick_morty_app/config/constants/ui.dart';

// 🌎 Project imports:

class CommonWidgets {
  const CommonWidgets._();
  static Widget masker(Widget widget,
      {LinearGradient? gradient, BlendMode blendMode = BlendMode.srcATop}) {
    return ShaderMask(
        blendMode: blendMode,
        shaderCallback: (bounds) {
          return (gradient ?? UiConstants.leftToRight()).createShader(bounds);
        },
        child: widget);
  }

  static Widget shimmerLoader(
      {required double height,
      required double width,
      BoxShape shape = BoxShape.rectangle}) {
    return Shimmer.fromColors(
      direction: ShimmerDirection.ttb,
      baseColor: const Color(0xffeeeeee),
      highlightColor: const Color(0xfff5f5f5),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(color: Colors.white, shape: shape),
      ),
    );
  }

  static Widget networkImageLoader(
          {required String url,
          required double height,
          required double width,
          double? radius,
          BoxFit fit = BoxFit.cover,
          BoxShape shape = BoxShape.rectangle,
          Widget? placeholder}) =>
      CachedNetworkImage(
        imageUrl: url,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            borderRadius: radius == null ? null : BorderRadius.circular(radius),
            shape: shape,
            image: DecorationImage(fit: fit, image: imageProvider),
          ),
          height: height,
          width: width,
        ),
        placeholder: (context, url) =>
            placeholder ??
            CommonWidgets.shimmerLoader(
                height: height - 1, width: width - 1, shape: shape),
        errorWidget: (context, url, error) =>
            placeholder ??
            Container(
                decoration: BoxDecoration(shape: shape),
                height: height - 1,
                width: width - 1,
                child: const Icon(Icons.error)),
      );

  static Widget emptyList(
      {required IconData icon,
      double iconSize = 80,
      required String msg,
      double fontSize = 16,
      bool mini = false}) {
    return Container(
      alignment: Alignment.center,
      child: mini
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  size: 30,
                  color: UiConstants.accentColor.withOpacity(0.5),
                ),
                const SizedBox(height: 5),
                Text(
                  msg,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14,
                      color: UiConstants.primaryColor.withOpacity(0.4)),
                )
              ],
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  size: iconSize,
                  color: UiConstants.accentColor.withOpacity(0.5),
                ),
                const SizedBox(height: 20),
                Text(
                  msg,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: fontSize,
                      color: UiConstants.primaryColor.withOpacity(0.4)),
                )
              ],
            ),
    );
  }

  static Widget errorWidget(
      {IconData? icon,
      double iconSize = 80,
      required String msg,
      double fontSize = 16,
      VoidCallback? retry}) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon ?? Icons.error,
            size: iconSize,
            color: UiConstants.accentColor.withOpacity(0.5),
          ),
          const SizedBox(height: 20),
          Text(
            msg,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: fontSize,
                color: UiConstants.primaryColor.withOpacity(0.4)),
          ),
          const SizedBox(
            height: 8,
          ),
          TextButton(onPressed: retry, child: const Text("retry"))
        ],
      ),
    );
  }

  static Widget emptyWidget(
      {required String msg, String? asset, double fontSize = 16}) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Image.asset(
              asset ?? "assets/no.png",
              height: 250,
              width: 250,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            msg,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: fontSize,
                color: UiConstants.primaryColor.withOpacity(0.9)),
          )
        ],
      ),
    );
  }

  static Widget errorMiniWidget(
      {IconData? icon,
      double iconSize = 20,
      required String msg,
      double fontSize = 14,
      VoidCallback? retry}) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon ?? Icons.error,
            size: iconSize,
            color: UiConstants.accentColor.withOpacity(0.5),
          ),
          const SizedBox(height: 10),
          Text(
            msg,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: fontSize,
                color: UiConstants.primaryColor.withOpacity(0.4)),
          ),
          const SizedBox(
            height: 8,
          ),
          TextButton(onPressed: retry, child: const Text("retry"))
        ],
      ),
    );
  }
}

class PersistentHeaderWrapper extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double maxHeight;
  final double minHeight;

  PersistentHeaderWrapper(
      {required this.child, required this.maxHeight, required this.minHeight});
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return LayoutBuilder(builder: (context, constraints) {
      return child;
    });
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;
}
