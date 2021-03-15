import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../model/customer_model.dart';
import '../page/account/account_payload.dart';
import '../page/account/email_token.dart';

class AccountProvider with ChangeNotifier {
  String _host = 'https://api.us-central1.gcp.commercetools.com';
  String _pKey = 'photon-learning';

  CustomerModel _accountData;

  bool _loadingStatus = false;
  bool _errorLoadAccoutData = false;

  bool get loadingStatus => _loadingStatus;
  bool get errorLoadAccountData => _errorLoadAccoutData;

  void setLoading(bool val) {
    print('Provider>>>setLoading($val)');
    _loadingStatus = val;
    notifyListeners();
  }

  CustomerModel get accountData => _accountData;

  Future loadAccountData(String cId) async {
    _errorLoadAccoutData = false;
    _loadingStatus = true;
    // cID el araya: 42a1a8bb-39dc-4397-bca6-b0d887c68fcd
    var response = await http.get('$_host/$_pKey/customers/$cId', headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer 1XcvL8qEJbCQwYwF8M9yo6U0e05ksmqM',
    });
    print('debug[loadAccountData] response ${response.statusCode}');
    if (response.statusCode == 200) {
      var data = CustomerModel.fromJson(jsonDecode(response.body));
      // print('debug[loadAccountData] data ${data?.toJson()}');
      _accountData = data;
      // _loadingStatus = false;
      // notifyListeners();
      _errorLoadAccoutData = false;
      setLoading(false);
      // return _accountData;
    } else {
      _errorLoadAccoutData = true;
      _accountData = null;
      setLoading(false);
      // return null;
    }
  }

  Future<CustomerModel> postRequest(Map payloads) async {
    setLoading(true);
    var cId = _accountData?.id;
    var response = await http.post('$_host/$_pKey/customers/$cId',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer 1XcvL8qEJbCQwYwF8M9yo6U0e05ksmqM',
        },
        body: jsonEncode(payloads));
    print('[postRequest] > ${response.statusCode}');
    print('[postRequest] > ${response.body}');
    if (response.statusCode == 200) {
      var data = CustomerModel.fromJson(jsonDecode(response.body));
      _accountData = data;
      setLoading(false);
      return _accountData;
    } else {
      setLoading(false);
      return null;
    }
  }

  Future<CustomerModel> vefiryEmailRequest(Map payloads) async {
    setLoading(true);
    var csVersion = _accountData?.version;
    var response = await http.post('$_host/$_pKey/customers/email-token',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer 1XcvL8qEJbCQwYwF8M9yo6U0e05ksmqM',
        },
        body: jsonEncode(payloads));
    print('[cTokenRequest] > ${response.statusCode}');
    if (response.statusCode == 200) {
      EmailToken token = EmailToken.fromJson(jsonDecode(response.body));
      var payload2 = AccountPayload().verifiesEmail(csVersion, token?.value);
      var response2 = await http.post('$_host/$_pKey/customers/email/confirm',
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer 1XcvL8qEJbCQwYwF8M9yo6U0e05ksmqM',
          },
          body: jsonEncode(payload2));
      print('[vefiryEmailRequest] > ${response2.statusCode}');
      if (response2.statusCode == 200) {
        var data = CustomerModel.fromJson(jsonDecode(response2.body));
        _accountData = data;
        setLoading(false);
        return _accountData;
      } else {
        setLoading(false);
        return null;
      }
    } else {
      setLoading(false);
      return null;
    }
  }
}
