import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';

class AppDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('My App'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            title: Text('Home'),
            leading: Icon(Icons.home),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushReplacementNamed('/home_screen');
            },
          ),
          Divider(),
          ListTile(
            title: Text('Profile'),
            leading: Icon(Icons.account_circle),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/profile_screen');
            },
          ),
          Divider(),
          ListTile(
            title: Text('Logout'),
            leading: Icon(Icons.exit_to_app),
            onTap: () {Navigator.of(context).pop();
              Provider.of<Auth>(context, listen: false).logout();
            },
          ),
        ],
      ),
    );
  }
}
