import 'package:flutter/foundation.dart';

class Account with ChangeNotifier {
  final String id;
  final String name;
  final String email;
  final String imageUrl;

  Account ({
    @required this.id,
    @required this.name,
    @required this.email,
    @required this.imageUrl,
  });
}