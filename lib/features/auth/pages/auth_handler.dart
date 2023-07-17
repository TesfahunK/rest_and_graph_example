import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sw_and_rick_morty_app/features/auth/data/providers/provider.dart';
import 'package:sw_and_rick_morty_app/features/auth/pages/splash_screen.dart';

class AuthHandler extends ConsumerWidget {
  const AuthHandler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return Scaffold(
      body: Builder(builder: (context) {
        if (authState.loading) {
          return const SplashScreen();
        } else {
          return Container();
        }
      }),
    );
  }
}
