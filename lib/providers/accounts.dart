import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
// import '../models/http_exception.dart';

import './account.dart';

class Accounts with ChangeNotifier {
  List<Account> _items = [];
  final String authToken;
  final String userId;

  Accounts(this.authToken, this.userId, this._items);

  List<Account> get items {
    return [..._items];
  }

  Future<void> fetchAndSetAccounts() async {
    var url = 'https://flutter-test-project-99e11.firebaseio.com/accounts/$userId.json?auth=$authToken';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      final List<Account> loadedAccounts = [];
      extractedData.forEach((accountId, accountData) {
        loadedAccounts.add(
          Account(
            id: accountId,
            firstName: accountData['firstName'],
            lastName: accountData['lastName'],
            email: accountData['email'],
            imageUrl: accountData['imageUrl'],
          ),
        );
      });
      _items = loadedAccounts;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addAccount(Account account) async {
    final url = 'https://flutter-test-project-99e11.firebaseio.com/accounts/$userId.json?auth=$authToken';
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'firstName': account.firstName,
          'lastName': account.lastName,
          'email': account.email,
          'imageUrl': account.imageUrl,
          'creatorId': userId,
        }),
      );

      final newAccount = Account(
        id: json.decode(response.body)['firstName' 'lastName'],
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
