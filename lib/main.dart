import 'package:flutter/material.dart';
import 'package:practice_app/widgets/characters_list.dart';
import 'package:provider/provider.dart';

import './screens/profile_screen.dart';
import './screens/character_list_screen.dart';
import './screens/log_in_screen.dart';
import './screens/add_screen.dart';
import './screens/character_detail_screen.dart';
import './providers/characters.dart';
import './providers/accounts.dart';
import './providers/auth.dart';
import './screens/splash_screen.dart';
import './screens/create_account_screen.dart';

void main() => runApp(MyApp());

@override
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Characters>(
          builder: (ctx, auth, previousCharacters) => Characters(
            auth.token,
            previousCharacters == null ? [] : previousCharacters.items,
          ),
        ),
        ChangeNotifierProxyProvider<Auth, Accounts>(
          builder: (ctx, auth, previousAccounts) => Accounts(
            auth.token,
            auth.userId,
            previousAccounts == null ? [] : previousAccounts.items,
          ),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.red,
          ),
          home: auth.isAuth
              ? auth.newAccount ? CreateAccountScreen() : CharacterListScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) => authResultSnapshot.connectionState == ConnectionState.waiting ? SplashScreen() : LoginScreen(),
                ),
          routes: {
            CharacterListScreen.routeName: (ctx) => CharacterListScreen(),
            ProfileScreen.routeName: (ctx) => ProfileScreen(),
            AddScreen.routeName: (ctx) => AddScreen(),
            CharacterDetailScreen.routeName: (ctx) => CharacterDetailScreen(),
            LoginScreen.routeName: (ctx) => LoginScreen(),
            CreateAccountScreen.routeName: (ctx) => CreateAccountScreen(),
          },
          // ),
        ),
      ),
    );
  }
}
