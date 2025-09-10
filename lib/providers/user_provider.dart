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

  void updateUser(
      {String? name,
      String? email,
      String? birthday,
      String? city,
      String? visitedPlaces,
      String? whyUnicab,
      String? profilePicture}) {
    if (_user == null) return;
    _user = _user!.copyWith(
        name: name ?? _user!.name,
        email: email ?? _user!.email,
        birthday: birthday ?? _user!.birthday,
        city: city ?? _user!.city,
        visitedPlaces: visitedPlaces ?? _user!.visitedPlaces,
        whyUnicab: whyUnicab ?? _user!.whyUnicab,
        profilePicture: profilePicture ?? _user!.profilePicture);
    notifyListeners();
  }
}
