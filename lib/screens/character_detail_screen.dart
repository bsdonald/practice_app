import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/characters.dart';

class CharacterDetailScreen extends StatelessWidget {
  static const routeName = '/character-detail';

  @override
  Widget build(BuildContext context) {
    final characterId = ModalRoute.of(context).settings.arguments as String; //is the id
    final loadedCharacter = Provider.of<Characters>(
      context,
      listen: false,
    ).findById(characterId);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedCharacter.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                loadedCharacter.imageUrl,
                fit: BoxFit.scaleDown,
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Center(
                child: Text(
                  '${loadedCharacter.race} ${loadedCharacter.favoredClass}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Text(
                      'level: ${loadedCharacter.level}',
                    ),
                  ),
                  Container(
                    child: Text(
                      'player: ${loadedCharacter.player}',
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Text(
                      'Max HP: ${loadedCharacter.hitPoints}',
                    ),
                  ),
                  Container(
                    child: Text(
                      'Melee: ${loadedCharacter.meleeModifier}',
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Text(
                      'AC: ${loadedCharacter.armorClass}',
                    ),
                  ),
                  Container(
                    child: Text(
                      'Range: ${loadedCharacter.rangedModifier}',
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
