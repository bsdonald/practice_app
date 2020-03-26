import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/http_exception.dart';


import './account.dart';

class Accounts with ChangeNotifier {
List<Account> _items = [
  // Account (
    // id: 'a1',
    // name: 'Jacob Mills',
    // email: 'dreadfyre@gmail.com',
    // imageUrl: 'https://i.imgur.com/bzCgEJn.jpg'
  // ),
];
List<Account> get items {
    return [..._items];
  }
  Future<void> addAccount(Account account) async {
    final url = 'https://flutter-test-project-99e11.firebaseio.com/accounts.json';
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'firstName': account.firstName,
          'lastName': account.lastName,
          'email': account.email,
          'imageUrl': account.imageUrl,
        }),
      );

      final newAccount = Account(
        id: json.decode(response.body)['name'],
        firstName: account.firstName,
        lastName: account.lastName,
        email: account.email,
        imageUrl: account.imageUrl,
      );
      _items.add(newAccount);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }
}