import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/character.dart';
import '../providers/characters.dart';

class AddScreen extends StatefulWidget {
  static const routeName = '/add-character';

  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final _form = GlobalKey<FormState>();
  final _playerFocusNode = FocusNode();
  final _raceFocusNode = FocusNode();
  final _favoredClassFocusNode = FocusNode();
  final _levelFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _hitPointsFocusNode = FocusNode();
  final _armorClassFocusNode = FocusNode();
  final _meleeModifierFocusNode = FocusNode();
  final _rangedModifierFocusNode = FocusNode();
  var _isInit = true;
  var _isLoading = false;
  var _editedCharacter = Character(
    id: null,
    name: '',
    race: '',
    favoredClass: '',
    level: 0,
    player: '',
    imageUrl: '',
    hitPoints: 0,
    armorClass: 0,
    meleeModifier: 0,
    rangedModifier: 0,
  );

  var _initValues = {
    'name': '',
    'race': '',
    'favoredClass': '',
    'level': '',
    'player': '',
    'imageUrl': '',
    'hitPoints': '',
    'armorClass': '',
    'meleeModifier': '',
    'rangedModifier': '',
  };

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _raceFocusNode.dispose();
    _favoredClassFocusNode.dispose();
    _levelFocusNode.dispose();
    _playerFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    _hitPointsFocusNode.dispose();
    _armorClassFocusNode.dispose();
    _meleeModifierFocusNode.dispose();
    _rangedModifierFocusNode.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if ((!_imageUrlController.text.startsWith('http') && !_imageUrlController.text.startsWith('https')) ||
          (!_imageUrlController.text.endsWith('.png') && !_imageUrlController.text.endsWith('.jpg') && !_imageUrlController.text.endsWith('.jpeg'))) {
        return;
      }
      setState(() {});
    }
  }

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final characterId = ModalRoute.of(context).settings.arguments as String;
      if (characterId != null) {
        _editedCharacter =
            Provider.of<Characters>(context, listen: false).findById(characterId);
        _initValues = {
    'name': _editedCharacter.name,
    'race': _editedCharacter.race,
    'favoredClass': _editedCharacter.favoredClass,
    'level': _editedCharacter.level.toString(),
    'player': _editedCharacter.player,
    // 'imageUrl': _editedCharacter.imageUrl,
    'imageUrl': '',
    'hitPoints': _editedCharacter.hitPoints.toString(),
    'armorClass': _editedCharacter.armorClass.toString(),
    'meleeModifier': _editedCharacter.meleeModifier.toString(),
    'rangedModifier': _editedCharacter.rangedModifier.toString(),
        };
        _imageUrlController.text = _editedCharacter.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Future<void> _saveForm() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });
    if (_editedCharacter.id != null) {
      await Provider.of<Characters>(context, listen: false)
          .updateCharacter(_editedCharacter.id, _editedCharacter);
    } else {
      try {
        await Provider.of<Characters>(context, listen: false)
            .addCharacter(_editedCharacter);
      } catch (error) {
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('An Error Occurred!'),
            content: Text('Something went wrong.'),
            actions: <Widget>[
              FlatButton(
                child: Text('Okay'),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              ),
            ],
          ),
        );
      } 
    //   finally {
    //     setState(() {
    //       _isLoading = false;
    //     });
    //     Navigator.of(context).pop();
    //   }
    }
    setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Character'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.person_add),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _form,
          child: ListView(
            children: <Widget>[
              TextFormField(
                initialValue: _initValues['name'],
                decoration: InputDecoration(labelText: 'Name'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_raceFocusNode);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a name.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _editedCharacter = Character(
                    id: _editedCharacter.id,
                    name: value,
                    race: _editedCharacter.race,
                    favoredClass: _editedCharacter.favoredClass,
                    level: _editedCharacter.level,
                    player: _editedCharacter.player,
                    imageUrl: _editedCharacter.imageUrl,
                    armorClass: _editedCharacter.armorClass,
                    hitPoints: _editedCharacter.hitPoints,
                    meleeModifier: _editedCharacter.meleeModifier,
                    rangedModifier: _editedCharacter.rangedModifier,
                  );
                },
              ),
              TextFormField(
                initialValue: _initValues['race'],
                decoration: InputDecoration(labelText: 'Race'),
                focusNode: _raceFocusNode,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_favoredClassFocusNode);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter the race.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _editedCharacter = Character(
                    id: _editedCharacter.id,
                    name: _editedCharacter.name,
                    race: value,
                    favoredClass: _editedCharacter.favoredClass,
                    level: _editedCharacter.level,
                    player: _editedCharacter.player,
                    imageUrl: _editedCharacter.imageUrl,
                    armorClass: _editedCharacter.armorClass,
                    hitPoints: _editedCharacter.hitPoints,
                    meleeModifier: _editedCharacter.meleeModifier,
                    rangedModifier: _editedCharacter.rangedModifier,
                  );
                },
              ),
              TextFormField(
                initialValue: _initValues['favoredClass'],
                decoration: InputDecoration(labelText: 'Favored Class'),
                focusNode: _favoredClassFocusNode,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_levelFocusNode);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter the favored class.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _editedCharacter = Character(
                    id: _editedCharacter.id,
                    name: _editedCharacter.name,
                    race: _editedCharacter.race,
                    favoredClass: value,
                    level: _editedCharacter.level,
                    player: _editedCharacter.player,
                    imageUrl: _editedCharacter.imageUrl,
                    armorClass: _editedCharacter.armorClass,
                    hitPoints: _editedCharacter.hitPoints,
                    meleeModifier: _editedCharacter.meleeModifier,
                    rangedModifier: _editedCharacter.rangedModifier,
                  );
                },
              ),
              TextFormField(
                initialValue: _initValues['level'],
                decoration: InputDecoration(labelText: 'Level'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _levelFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_playerFocusNode);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter the character level.';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number.';
                  }
                  if (double.parse(value) <= 0) {
                    return 'Please enter a number greater than 0';
                  }
                  return null;
                },
                onSaved: (value) {
                  _editedCharacter = Character(
                    id: _editedCharacter.id,
                    name: _editedCharacter.name,
                    race: _editedCharacter.race,
                    favoredClass: _editedCharacter.favoredClass,
                    level: int.parse(value),
                    player: _editedCharacter.player,
                    imageUrl: _editedCharacter.imageUrl,
                    armorClass: _editedCharacter.armorClass,
                    hitPoints: _editedCharacter.hitPoints,
                    meleeModifier: _editedCharacter.meleeModifier,
                    rangedModifier: _editedCharacter.rangedModifier,
                  );
                },
              ),
              TextFormField(
                initialValue: _initValues['player'],
                decoration: InputDecoration(labelText: 'player'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_armorClassFocusNode);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter the player.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _editedCharacter = Character(
                    id: _editedCharacter.id,
                    name: _editedCharacter.name,
                    race: _editedCharacter.race,
                    favoredClass: _editedCharacter.favoredClass,
                    level: _editedCharacter.level,
                    player: value,
                    imageUrl: _editedCharacter.imageUrl,
                    armorClass: _editedCharacter.armorClass,
                    hitPoints: _editedCharacter.hitPoints,
                    meleeModifier: _editedCharacter.meleeModifier,
                    rangedModifier: _editedCharacter.rangedModifier,
                  );
                },
              ),
              TextFormField(
                initialValue: _initValues['armorClass'],
                decoration: InputDecoration(labelText: 'Armor Class'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _armorClassFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_hitPointsFocusNode);
                },
                validator: (value) {
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _editedCharacter = Character(
                    id: _editedCharacter.id,
                    name: _editedCharacter.name,
                    race: _editedCharacter.race,
                    favoredClass: _editedCharacter.favoredClass,
                    level: _editedCharacter.level,
                    player: _editedCharacter.player,
                    imageUrl: _editedCharacter.imageUrl,
                    armorClass: int.parse(value),
                    hitPoints: _editedCharacter.hitPoints,
                    meleeModifier: _editedCharacter.meleeModifier,
                    rangedModifier: _editedCharacter.rangedModifier,
                  );
                },
              ),
              TextFormField(
                initialValue: _initValues['hitPoints'],
                decoration: InputDecoration(labelText: 'Hitpoints'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _hitPointsFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_meleeModifierFocusNode);
                },
                validator: (value) {
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _editedCharacter = Character(
                    id: _editedCharacter.id,
                    name: _editedCharacter.name,
                    race: _editedCharacter.race,
                    favoredClass: _editedCharacter.favoredClass,
                    level: _editedCharacter.level,
                    player: _editedCharacter.player,
                    imageUrl: _editedCharacter.imageUrl,
                    armorClass: _editedCharacter.armorClass,
                    hitPoints: int.parse(value),
                    meleeModifier: _editedCharacter.meleeModifier,
                    rangedModifier: _editedCharacter.rangedModifier,
                  );
                },
              ),
              TextFormField(
                initialValue: _initValues['meleeModifier'],
                decoration: InputDecoration(labelText: 'Melee Modifier'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _meleeModifierFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_rangedModifierFocusNode);
                },
                validator: (value) {
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _editedCharacter = Character(
                    id: _editedCharacter.id,
                    name: _editedCharacter.name,
                    race: _editedCharacter.race,
                    favoredClass: _editedCharacter.favoredClass,
                    level: _editedCharacter.level,
                    player: _editedCharacter.player,
                    imageUrl: _editedCharacter.imageUrl,
                    armorClass: _editedCharacter.armorClass,
                    hitPoints: _editedCharacter.hitPoints,
                    meleeModifier: int.parse(value),
                    rangedModifier: _editedCharacter.rangedModifier,
                  );
                },
              ),
              TextFormField(
                initialValue: _initValues['rangedModifier'],
                decoration: InputDecoration(labelText: 'Ranged Modifier'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _rangedModifierFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_imageUrlFocusNode);
                },
                validator: (value) {
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _editedCharacter = Character(
                    id: _editedCharacter.id,
                    name: _editedCharacter.name,
                    race: _editedCharacter.race,
                    favoredClass: _editedCharacter.favoredClass,
                    level: _editedCharacter.level,
                    player: _editedCharacter.player,
                    imageUrl: _editedCharacter.imageUrl,
                    armorClass: _editedCharacter.armorClass,
                    hitPoints: _editedCharacter.hitPoints,
                    meleeModifier: _editedCharacter.meleeModifier,
                    rangedModifier: int.parse(value),
                  );
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(
                      top: 8,
                      right: 10,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.grey,
                      ),
                    ),
                    child: _imageUrlController.text.isEmpty
                        ? Center(
                            child: Text('Enter a URL'),
                          )
                        : FittedBox(
                            child: Image.network(
                              _imageUrlController.text,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Image URL',
                      ),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageUrlController,
                      focusNode: _imageUrlFocusNode,
                      onFieldSubmitted: (_) {
                        _saveForm();
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter an image URL.';
                        }
                        if (!value.startsWith('http') && !value.startsWith('https')) {
                          return 'Please enter a valid URL.';
                        }
                        if (!value.endsWith('.png') && !value.endsWith('.jpg') && !value.endsWith('.jpeg')) {
                          return 'Please enter a valid image URL.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedCharacter = Character(
                          id: _editedCharacter.id,
                          name: _editedCharacter.name,
                          race: _editedCharacter.race,
                          favoredClass: _editedCharacter.favoredClass,
                          level: _editedCharacter.level,
                          player: _editedCharacter.player,
                          imageUrl: value,
                          armorClass: _editedCharacter.armorClass,
                          hitPoints: _editedCharacter.hitPoints,
                          meleeModifier: _editedCharacter.meleeModifier,
                          rangedModifier: _editedCharacter.rangedModifier,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
