import 'package:flutter/material.dart';

import './account.dart';

class Accounts with ChangeNotifier {
List<Account> _items = [
  Account (
    id: 'a1',
    name: 'Jacob Mills',
    email: 'dreadfyre@gmail.com',
    imageUrl: 'https://i.imgur.com/bzCgEJn.jpg'
  ),
];
List<Account> get items {
    return [..._items];
  }
}