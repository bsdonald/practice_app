import 'package:flutter/foundation.dart';


class Character with ChangeNotifier {
  final String id;
  final String name;
  final String race;
  final String favoredClass;
  final int level;
  final String player;
  final String imageUrl;
  final int armorClass;
  final int hitPoints;
  final int meleeModifier;
  final int rangedModifier;

  Character ({
    @required this.id,
    @required this.name,
    @required this.race,
    @required this.favoredClass,
    @required this.level,
    @required this.player,
    @required this.imageUrl,
    @required this.armorClass,
    @required this.hitPoints,
    @required this.meleeModifier,
    @required this.rangedModifier,
  });
}