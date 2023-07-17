import 'package:flutter/material.dart';
import 'package:sw_and_rick_morty_app/config/constants/assets.dart';
import 'package:sw_and_rick_morty_app/config/constants/ui.dart';
import 'package:sw_and_rick_morty_app/features/shared/other/widgets/loader.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration:
          BoxDecoration(gradient: UiConstants.rightCornerToLeftCorner()),
      child: Column(
        children: [
          const Spacer(),
          Container(
            clipBehavior: Clip.antiAlias,
            height: 200,
            width: 200,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Image.asset(ImageAssets.logo),
          ),
          const Spacer(),
          const SafeArea(
            child: Loader(
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }
}
