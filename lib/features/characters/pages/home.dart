import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sw_and_rick_morty_app/config/constants/ui.dart';
import 'package:sw_and_rick_morty_app/features/characters/pages/all_characters.dart';
import 'package:sw_and_rick_morty_app/features/shared/other/util/ui/text_theme.dart';
import 'package:sw_and_rick_morty_app/features/ships/pages/ships.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: UiConstants.accentColor,
        title: Text(
          ["Starwars", "Rick n Morty"][_currentIndex],
          style: textThemeOfContext(context)
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.w400, color: Colors.white),
        ),
      ),
      body: [const AllCharacters(), const AllShips()][_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (value) {
            setState(() {
              _currentIndex = value;
            });
          },
          items: const [
            BottomNavigationBarItem(
                label: "Starwars", icon: Icon(FontAwesomeIcons.empire)),
            BottomNavigationBarItem(
                label: "Rick n Morty",
                icon: Icon(FontAwesomeIcons.spaceAwesome))
          ]),
    );
  }
}
