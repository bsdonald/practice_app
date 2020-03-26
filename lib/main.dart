import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/profile_screen.dart';
import './screens/home_screen.dart';
// import './screens/log_in_screen.dart';
import './screens/add_screen.dart';
import './screens/character_detail_screen.dart';
import './providers/characters.dart';
import './providers/accounts.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Characters(),
        ),
        ChangeNotifierProvider.value(
          value: Accounts(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: HomeScreen(),
        routes: {
          // ProfileScreen.routeName: (ctx) => ProfileScreen(),
          AddScreen.routeName: (ctx) => AddScreen(),
          CharacterDetailScreen.routeName: (ctx) => CharacterDetailScreen(),
          // LoginScreen.routeName: (ctx) => LoginScreen(),
        },
        // ),
      ),
    );
  }
}
