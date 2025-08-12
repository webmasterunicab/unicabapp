import 'package:flutter/material.dart';
import 'package:uniconecta/models/shared/user.dart';

class UserProvider extends ChangeNotifier {
  User? _user;
  User? get user => _user;

  bool? get loggedIn => _user != null;

  void setUser(User? user) {
    // Setting up the user and saving the logged in state
    _user = user;

    // Notify every widget that watches this provider
    notifyListeners();
  }
}