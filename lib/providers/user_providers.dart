import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../models/user_model.dart';
import '../resources/auth_methods.dart';

// class UserProvider with ChangeNotifier {
//   User? _user;
//   final AuthMethods _authMethods = AuthMethods();

//   User get getUser => _user!;

//   Future<void> refreshUser() async {
//     User user = await _authMethods.getUserDetails();
//     _user = user;
//     notifyListeners();
//   }
// }

class UserProvider with ChangeNotifier {
  User? _user;

  final AuthMethods _authMethods;

  bool _isLoading = false;

  UserProvider(this._authMethods);

  User get getUser => _user!;

  bool get isLoading => _isLoading;

  Future<void> refreshUser() async {
    try {
      _isLoading = true;

      User? user = await _authMethods.getUserDetails();
      
      // ignore: unnecessary_null_comparison
      if (user != null) {
        _user = user;
        notifyListeners();
      } else {
        // Handle the case when getUserDetails returns null.
        // You can choose to do nothing or set a default user.
        Fluttertoast.showToast(msg: 'Please  wait...');
      } 
    } catch (e) {
      // Handle the error here, e.g., log it or show a user-friendly message.
      Fluttertoast.showToast(
        msg: 'User not found',
        backgroundColor: Colors.red,
      );
    }finally {
      _isLoading = false;
    }
  }

  // If you want to set the user explicitly, you can use this method.
  void setUser(User user) {
    _user = user;
    notifyListeners();
  }
}



