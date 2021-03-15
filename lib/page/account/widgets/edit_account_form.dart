import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import '../../../provider/account_provider.dart';
import '../../../model/customer_model.dart';
import '../account_payload.dart';
import '../form_validation.dart';
import '../widgets/safe_area_view.dart';
import 'positioned_spinner.dart';

enum FormType {
  ADD_ADDRESS,
  EDIT_ADDRESS,
  EDIT_NAME,
  EDIT_DATEOFBIRTH,
  EDIT_EMAIL,
  EDIT_PHONE
}

class AccountForm extends StatefulWidget {
  const AccountForm({Key key, this.type, this.id}) : super(key: key);

  final FormType type;
  final String id;

  @override
  _AccountFormState createState() => _AccountFormState();
}

class _AccountFormState extends State<AccountForm> with FormValidation {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  /// Form Name Controller
  final _fNameCtrl = TextEditingController();
  final _mNameCtrl = TextEditingController();
  final _lNameCtrl = TextEditingController();

  /// Form Email Controller
  final _emailCtrl = TextEditingController();

  /// Form Phone Controller
  final _phoneCtrl = TextEditingController();
  final phoneMask = MaskTextInputFormatter(
      mask: '+1 (####) ###-###', filter: {"#": RegExp(r'[0-9]')});
  final unmaskPhoneRegex = RegExp(r'(\+1 \(|\) |-)');

  Addresses _address;

  Timer _timer;

  CustomerModel _data;

  @override
  void initState() {
    _data = context.read<AccountProvider>().accountData;
    _setupValues();
    super.initState();
  }

  @override
  void dispose() {
    _fNameCtrl?.dispose();
    _mNameCtrl?.dispose();
    _lNameCtrl?.dispose();
    _emailCtrl?.dispose();
    _phoneCtrl?.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _setupValues() {
    _fNameCtrl.text = _data?.firstName ?? '';
    _mNameCtrl.text = _data?.middleName ?? '';
    _lNameCtrl.text = _data?.lastName ?? '';
    _emailCtrl.text = _data?.email ?? '';
    if (widget.type == FormType.EDIT_PHONE) {
      _address = _data.addresses.firstWhere(
          (e) => e?.id == _data?.defaultShippingAddressId,
          orElse: () => null);
      var first = _address?.phone?.substring(0, 4) ?? '';
      var middle = _address?.phone?.substring(4, 7) ?? '';
      var last = _address?.phone?.substring(7) ?? '';
      _phoneCtrl?.text = '+1 ($first) $middle-$last';
    }
  }

  String _appBarTitle() {
    String txt = 'Edit Form';
    if (widget.type == FormType.EDIT_NAME)
      txt = 'Edit Name';
    else if (widget.type == FormType.EDIT_EMAIL)
      txt = 'Edit Email Address';
    else if (widget.type == FormType.EDIT_PHONE) txt = 'Edit Phone Number';
    return txt;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          _appBarTitle(),
          style: TextStyle(fontSize: 20),
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body: SafeAreaView(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.fromLTRB(8, 14, 8, 8),
                width: MediaQuery.of(context).size.width,
                child: Form(
                  key: _formKey,
                  child: _buildBody(context, widget.type),
                ),
              ),
            ),
            PositionedSpinner(
                status: context.watch<AccountProvider>().loadingStatus,
                scaffoldKey: _scaffoldKey),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, FormType type) {
    Widget w;
    if (type == FormType.EDIT_NAME) {
      w = _buildNameForm(context);
    } else if (type == FormType.EDIT_EMAIL) {
      w = _buildEmailForm(context);
    } else if (type == FormType.EDIT_PHONE) {
      w = _buildPhoneForm(context);
    }
    return w;
  }

  Widget _buildNameForm(BuildContext context) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 14),
            child: TextFormField(
              controller: _fNameCtrl,
              validator: emptyValidation,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(bottom: 0),
                  labelText: 'First Name',
                  alignLabelWithHint: true,
                  errorStyle: TextStyle(height: 0)),
            ),
          ),
          _mNameCtrl.text.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.only(top: 14),
                  child: TextFormField(
                    controller: _mNameCtrl,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(bottom: 0),
                        labelText: 'Middle Name',
                        alignLabelWithHint: true,
                        errorStyle: TextStyle(height: 0)),
                  ),
                )
              : SizedBox(),
          Padding(
            padding: const EdgeInsets.only(top: 14),
            child: TextFormField(
              controller: _lNameCtrl,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(bottom: 0),
                  labelText: 'Last Name',
                  alignLabelWithHint: true,
                  errorStyle: TextStyle(height: 0)),
            ),
          ),
          _buildSubmitButton(context),
        ],
      );

  Widget _buildEmailForm(BuildContext context) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 14),
            child: TextFormField(
              controller: _emailCtrl,
              validator: emailValidation,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(bottom: 0),
                  labelText: 'Email Address',
                  alignLabelWithHint: true,
                  errorStyle: TextStyle(height: 0)),
            ),
          ),
          _buildSubmitButton(context),
        ],
      );

  Widget _buildPhoneForm(BuildContext context) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 14),
            child: TextFormField(
              controller: _phoneCtrl,
              textInputAction: TextInputAction.done,
              validator: emptyValidation,
              inputFormatters: [phoneMask],
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(bottom: 0),
                  labelText: 'Phone Number',
                  alignLabelWithHint: true,
                  errorStyle: TextStyle(height: 0)),
            ),
          ),
          _buildSubmitButton(context),
        ],
      );

  Widget _buildSubmitButton(BuildContext context) => Container(
        margin: const EdgeInsets.only(top: 28),
        height: 40,
        width: MediaQuery.of(context).size.width,
        child: RaisedButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(color: Colors.green)),
          onPressed: () => _submitFormHandler(context),
          color: Colors.green,
          textColor: Colors.white,
          child: Text('Save'),
        ),
      );

  void _submitFormHandler(BuildContext context) {
    print("submitFormHandler");
    if (_formKey.currentState.validate()) {
      var payloads;
      if (widget.type == FormType.EDIT_NAME) {
        payloads = AccountPayload().changeName(
            _data?.version,
            _fNameCtrl?.text?.trim(),
            _mNameCtrl?.text?.trim(),
            _lNameCtrl?.text?.trim());
      } else if (widget.type == FormType.EDIT_EMAIL) {
        var newEmail = _emailCtrl?.text?.trim();
        payloads = AccountPayload().changeEmail(_data?.version, newEmail);
      } else if (widget.type == FormType.EDIT_PHONE) {
        Addresses addressData = _address;
        String unMaskPhone =
            _phoneCtrl?.text?.replaceAll(unmaskPhoneRegex, '') ?? '';
        addressData.phone = unMaskPhone?.trim();
        addressData.mobile = unMaskPhone?.trim();
        payloads = AccountPayload().changeAddress(_data?.version, addressData);
      }
      print(">>>>>>>>>>>>>>>>>>");
      print(jsonEncode(payloads));
      print(">>>>>>>>>>>>>>>>>>");
      _timer?.cancel();
      context.read<AccountProvider>().postRequest(payloads).then((value) {
        var msg = _appBarTitle();
        msg += value != null ? ' Successfuly' : ' Failed';
        _scaffoldKey.currentState
          ..hideCurrentSnackBar()
          ..showSnackBar(
              SnackBar(content: Text(msg, textAlign: TextAlign.center)));
        _timer = Timer(Duration(milliseconds: 1500), () {
          _scaffoldKey.currentState.hideCurrentSnackBar();
          Navigator.of(context).pop();
        });
      });
    }
  }
}
