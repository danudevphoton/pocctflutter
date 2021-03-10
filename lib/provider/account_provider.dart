import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../model/customer_model.dart';

class AccountProvider with ChangeNotifier {
  String _host = 'https://api.us-central1.gcp.commercetools.com';
  String _pKey = 'photon-learning';

  CustomerModel _accountData;

  CustomerModel get accountData => _accountData;

  void loadAccountData(String id) async {
    print('debug[loadAccountData] masuk $id');
    // cID el araya: 42a1a8bb-39dc-4397-bca6-b0d887c68fcd
    var response = await http.get('$_host/$_pKey/customers/$id', headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer GCQh_TKj0wGBnV0w35VO5di3j0S-9usA',
    });
    print('debug[loadAccountData] response ${response.statusCode}');
    if (response.statusCode == 200) {
      var data = CustomerModel.fromJson(jsonDecode(response.body));
      _accountData = data;
      notifyListeners();
    } else {}
  }
}
