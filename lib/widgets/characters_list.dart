import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/characters.dart';
import './character_tile.dart';

class CharacterList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final charactersData = Provider.of<Characters>(context);
    final characters = charactersData.items;
    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: characters.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: characters[i],
        child: CharacterTile(),
      ),
    );
  }
}
