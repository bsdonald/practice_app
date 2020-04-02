import 'package:flutter/foundation.dart';

class Account with ChangeNotifier {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String imageUrl;

  Account ({
    @required this.id,
    @required this.firstName,
    @required this.lastName,
    @required this.email,
    @required this.imageUrl,
  });
}