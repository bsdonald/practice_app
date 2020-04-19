import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/character.dart';
import '../providers/characters.dart';
import '../screens/add_screen.dart';

class CharacterTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);
    final character = Provider.of<Character>(context, listen: false);
    return Card(
      child: InkWell(
        splashColor: Colors.blue,
        onTap: () {
          Navigator.of(context).pushNamed('/character-detail', arguments: character.id);
        },
        onLongPress: () {
          Navigator.of(context).pushNamed(AddScreen.routeName, arguments: character.id);
        },
        child: Container(
          child: ListTile(
            leading: Container(
              width: 45,
              child: Image.network(
                character.imageUrl,
                fit: BoxFit.contain,
              ),
            ),
            title: Text(character.name),
            subtitle: Text('level: ${character.level.toString()}'),
            trailing:
                // Row(
                //   children: <Widget>[
                //     IconButton(
                //   icon: Icon(Icons.edit),
                //   onPressed: () {
                //     Navigator.of(context)
                //         .pushNamed(AddScreen.routeName, arguments: character.id);
                //   },
                //   color: Theme.of(context).primaryColor,
                // ),
                IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                try {
                  await Provider.of<Characters>(context, listen: false).removeCharacter(character.id);
                } catch (error) {
                  scaffold.showSnackBar(
                    SnackBar(
                      content: Text(
                        'Deleting failed!',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }
              },
              color: Theme.of(context).errorColor,
            ),
            // ],
            // ),
          ),
        ),
      ),
    );
  }
}
