import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:sw_and_rick_morty_app/config/theme/light/main.dart';
import 'package:sw_and_rick_morty_app/features/auth/pages/auth_handler.dart';
import 'package:sw_and_rick_morty_app/features/characters/data/providers/graphql/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initHiveForFlutter();

  runApp(const Application());
}

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderScope(child: Consumer(
      builder: (ctx, ref, child) {
        final client = ref.watch(graphqlstateProvider);
        return GraphQLProvider(
            client: client.widget_client, child: const MyApp());
      },
    ));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Starwars & Rick n Morty',
      theme: mainLightTheme(),
      home: const AuthHandler(),
    );
  }
}
