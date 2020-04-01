import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/characters.dart';
import '../widgets/app_drawer.dart';
import '../widgets/characters_list.dart';

class CharacterListScreen extends StatefulWidget {

  @override
  _CharacterListScreenState createState() => _CharacterListScreenState();
}

class _CharacterListScreenState extends State<CharacterListScreen> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Characters>(context).fetchAndSetCharacters().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.person_add),
            onPressed: () {
              Navigator.of(context).pushNamed('/add-character');
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: _isLoading
      ? Center (
        child: CircularProgressIndicator(),
      )
      : Center(
        child: CharacterList(),
      ),
    );
  }
}
