import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/http_exception.dart';

import './character.dart';

class Characters with ChangeNotifier {
  List<Character> _items = [
    // Character(
    //   id: 'c1',
    //   name: 'Reily',
    //   race: 'Aasimar',
    //   favoredClass: 'Monk',
    //   level: 2,
    //   Player: 'Braden',
    //   imageUrl: 'https://i.pinimg.com/originals/6b/98/17/6b9817699060e79bad580aa8648db2a7.jpg',
    // ),
    // Character(
    //   id: 'c2',
    //   name: 'Aridian',
    //   race: 'Aasimar',
    //   favoredClass: 'Paladin',
    //   level: 2,
    //   Player: 'Randall',
    //   imageUrl: 'https://i.pinimg.com/originals/ab/1f/44/ab1f44dbede9b2525b75cff5a98d6c64.jpg',
    // )
    // Character(
    //   id: 'c2',
    //   name: 'Aridian',
    //   race: 'Aasimar',
    //   favoredClass: 'Paladin',
    //   level: 2,
    //   Player: 'Branden',
    //   imageUrl: "https://units.wesnoth.org/1.12/pics/core%24images%24portraits%24saurians%24transparent%24skirmisher.png",
    //)
  ];

  List<Character> get items {
    return [..._items];
  }

  Character findById(String id) {
    return _items.firstWhere((char) => char.id == id);
  }

  Future<void> fetchAndSetCharacters() async {
    final url = 'https://flutter-test-project-99e11.firebaseio.com/characters.json';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      final List<Character> loadedCharacters = [];
      extractedData.forEach((charId, charData) {
        loadedCharacters.add(Character(
          id: charId,
          name: charData['name'],
          race: charData['race'],
          favoredClass: charData['favoredClass'],
          level: charData['level'],
          player: charData['player'],
          imageUrl: charData['imageUrl'],
          armorClass: charData['armorClass'],
          hitPoints: charData['hitPoints'],
          meleeModifier: charData['meleeModifier'],
          rangedModifier: charData['rangedModifier'],
        ));
      });
      _items = loadedCharacters;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addCharacter(Character character) async {
    final url = 'https://flutter-test-project-99e11.firebaseio.com/characters.json';
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'name': character.name,
          'race': character.race,
          'favoredClass': character.favoredClass,
          'level': character.level,
          'player': character.player,
          'imageUrl': character.imageUrl,
          'armorClass': character.armorClass,
          'hitPoints': character.hitPoints,
          'meleeModifier': character.meleeModifier,
          'rangedModifier': character.rangedModifier,
        }),
      );

      final newCharacter = Character(
        id: json.decode(response.body)['name'],
        name: character.name,
        race: character.race,
        favoredClass: character.favoredClass,
        level: character.level,
        player: character.player,
        imageUrl: character.imageUrl,
        armorClass: character.armorClass,
          hitPoints: character.hitPoints,
          meleeModifier: character.meleeModifier,
          rangedModifier: character.rangedModifier,
      );
      _items.add(newCharacter);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> removeCharacter(String id) async {
    final url = 'https://flutter-test-project-99e11.firebaseio.com/characters/$id.json';
    final existingCharacterIndex = _items.indexWhere((char) => char.id == id);
    var existingCharacter = _items[existingCharacterIndex];
    _items.removeAt(existingCharacterIndex);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(existingCharacterIndex, existingCharacter);
      notifyListeners();
      throw HttpException('Could not delete charuct.');
    }
    existingCharacter = null;
  }
}
