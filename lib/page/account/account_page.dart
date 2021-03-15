import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/customer_model.dart';
import '../../provider/account_provider.dart';
import 'account_payload.dart';
import 'account_utils.dart';
import 'address/addresses_list.dart';
import 'widgets/edit_account_form.dart';
import 'widgets/list_tile_edit.dart';
import 'widgets/positioned_spinner.dart';
import 'widgets/safe_area_view.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _emailVerifyCtrl = TextEditingController();

  CustomerModel accountData;

  @override
  void initState() {
    print('accountPage>>initstate');
    context
        .read<AccountProvider>()
        .loadAccountData('f6f37533-a074-4afc-a022-95f888aee4f1');
    WidgetsBinding.instance.addPostFrameCallback((_) {});
    super.initState();
  }

  @override
  void dispose() {
    _emailVerifyCtrl?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    accountData = context.watch<AccountProvider>().accountData;

    if (context.watch<AccountProvider>().errorLoadAccountData) {
      _scaffoldKey.currentState
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(
            content:
                Text('Cannot Load Account Data', textAlign: TextAlign.center)));
    }

    return Scaffold(
      key: _scaffoldKey,
      body: SafeAreaView(
        child: Stack(
          children: [
            accountData != null
                ? SingleChildScrollView(
                    child: _buildContentBody(context, accountData))
                : SizedBox(),
            PositionedSpinner(
                status: context.watch<AccountProvider>().loadingStatus,
                scaffoldKey: _scaffoldKey),
          ],
        ),
      ),
    );
  }

  String _acronym(String fName, String lName) {
    var f = fName != null ? fName.substring(0, 1) : '?';
    var l = lName != null ? lName.substring(0, 1) : '?';
    var result = '$f$l';
    return result.toUpperCase();
  }

  Widget _buildContentBody(BuildContext context, CustomerModel data) {
    String customerId = data?.id;
    String fName = data?.firstName ?? '';
    String lName = data?.lastName ?? '';
    String fullName = '$fName $lName';
    String dateBirth = data?.dateOfBirth ?? '';
    String email = data?.email ?? '';

    List<Addresses> addresses = data?.addresses;
    var address = addresses.firstWhere(
        (e) => e?.id == data?.defaultBillingAddressId,
        orElse: () => null);
    String phone = address?.phone;

    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(14),
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.blueGrey,
                  child: Text(_acronym(fName, lName),
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      )),
                ),
              ),
              ListTileEdit(
                label: 'Name',
                content: AccountUtils.titleCase(fullName),
                onEditTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AccountForm(
                                type: FormType.EDIT_NAME,
                                id: customerId,
                              )));
                },
              ),
              ListTileEdit(
                  label: 'Date of Birth',
                  content: AccountUtils.dateBirthFormatter(dateBirth)),
              ListTileEdit(
                label: 'Email',
                content: email,
                isEmailVerified: accountData?.isEmailVerified,
                onVerifyTap: () {
                  _verifyingEmailHandler();
                },
                onEditTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            AccountForm(type: FormType.EDIT_EMAIL)),
                  );
                },
              ),
              phone != null
                  ? ListTileEdit(
                      label: 'Phone',
                      content: AccountUtils.phoneFormater(phone),
                      onEditTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  AccountForm(type: FormType.EDIT_PHONE)),
                        );
                      },
                    )
                  : SizedBox(),
            ],
          ),
        ),
        Divider(
          thickness: 1,
        ),
        ListTile(
          dense: true,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
          title: Text('Daftar Alamat', style: TextStyle(fontSize: 16)),
          trailing: Icon(Icons.arrow_forward_ios, size: 24),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddressesList()),
            );
          },
        ),
      ],
    );
  }

  void _verifyingEmailHandler() {
    print('onVerifyTap');
    Widget wTitle = Text('Verify Email');
    Widget wContent = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: Text('Please re-type your email'),
        ),
        Form(
          key: _formKey,
          child: TextFormField(
            controller: _emailVerifyCtrl,
            textInputAction: TextInputAction.done,
            validator: (value) {
              var regExp = RegExp(r'^[\w\-\.]+@([\w-]+\.)+[\w-]{2,4}$');
              if (value == null || value.isEmpty) return 'Cannot be empty!';
              if (!regExp.hasMatch(value)) return 'Email not valid!';
              if (value?.trim() != accountData?.email?.trim())
                return 'Email not same';
              return null;
            },
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(bottom: 0),
                labelText: 'Your Email',
                alignLabelWithHint: true),
          ),
        )
      ],
    );
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (cContext) => Platform.isIOS
            ? CupertinoAlertDialog(
                title: wTitle,
                content: wContent,
                actions: [
                  CupertinoDialogAction(
                    child: Text('Cancel'),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  CupertinoDialogAction(
                    child: Text('Submit'),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        Navigator.of(context).pop();
                        context.read<AccountProvider>().setLoading(true);
                      }
                    },
                  )
                ],
              )
            : AlertDialog(
                title: wTitle,
                content: wContent,
                actions: [
                  FlatButton(
                    child: Text("Cancel"),
                    onPressed: () {
                      setState(() {
                        _emailVerifyCtrl.text = '';
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                  FlatButton(
                    child: Text("Submit"),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        Navigator.of(context).pop();
                        _emailVerifyCtrl?.text = '';
                        var payload = AccountPayload().createVerifyEmailToken(
                            accountData?.id, accountData?.version);
                        print('payload>>$payload');
                        context
                            .read<AccountProvider>()
                            .vefiryEmailRequest(payload)
                            .then((value) {
                          print('>>>then1>>$value');
                          var msg = 'Email verification ';
                          msg += value != null ? 'Successfully' : 'Failed';
                          _scaffoldKey.currentState
                            ..hideCurrentSnackBar()
                            ..showSnackBar(SnackBar(
                                content:
                                    Text(msg, textAlign: TextAlign.center)));
                          setState(() {
                            _emailVerifyCtrl.text = '';
                          });
                        });
                      }
                    },
                  )
                ],
              ));
  }
}
