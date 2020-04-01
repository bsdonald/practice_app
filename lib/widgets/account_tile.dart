import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/account.dart';

class AccountTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final account = Provider.of<Account>(context, listen: false);
    return ListTile(
      title: Text(account.firstName),
            leading: Icon(Icons.account_circle),
            onTap: () {
              // Navigator.of(context).pushReplacementNamed('/profile_screen');
            },
    );
  }
}
