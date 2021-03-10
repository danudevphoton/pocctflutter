import 'package:flutter/cupertino.dart';

class LoginProvider extends ChangeNotifier {
  /// Internal, private state of the cart.
  String userName;
  String password;
  String accessToken = "";


  void login(String userName, String password) {
    userName = userName;
    password = password;
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();

    print('userName + password'+userName + password);
  }
}