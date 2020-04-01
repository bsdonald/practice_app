import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/accounts.dart';
import './account_tile.dart';

class AccountList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final accountsData = Provider.of<Accounts>(context);
    final accounts = accountsData.items;
    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: accounts.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: accounts[i],
        child: AccountTile(),
      ),
    );
  }
}
