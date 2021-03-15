import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import '../../../model/customer_model.dart';
import '../../../provider/account_provider.dart';

import '../account_payload.dart';
import '../form_validation.dart';
import '../resources.dart';
import '../widgets/edit_account_form.dart';
import '../widgets/positioned_spinner.dart';
import '../widgets/safe_area_view.dart';

class AddressForm extends StatefulWidget {
  const AddressForm({Key key, @required this.type, this.addressId})
      : super(key: key);

  final FormType type;
  final String addressId;

  @override
  _AddressFormState createState() => _AddressFormState();
}

class _AddressFormState extends State<AddressForm> with FormValidation {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final unmaskPhoneRegex = RegExp(r'(\+1 \(|\) |-)');
  final phoneMask = MaskTextInputFormatter(
      mask: '+1 (####) ###-###', filter: {"#": RegExp(r'[0-9]')});

  /// Form Phone Controller
  final _phoneCtrl = TextEditingController();

  /// Form Address controller
  final _addressTitleCtrl = TextEditingController();
  final _receiverNameCtrl = TextEditingController();
  final _streetNumberCtrl = TextEditingController();
  final _streetNameCtrl = TextEditingController();

  String _selectedState;
  List<DropdownMenuItem> _cityItems = [];
  String _selectedCity;
  final _postalCodeCtrl = TextEditingController();
  String _selectedCountry = 'US';
  final _additionalInfoCtrl = TextEditingController();

  CustomerModel _data;
  Addresses _defaultAddress;

  Timer _timer;

  @override
  void initState() {
    _setupAddressValue();
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _phoneCtrl?.dispose();
    _addressTitleCtrl?.dispose();
    _receiverNameCtrl?.dispose();
    _streetNumberCtrl?.dispose();
    _streetNameCtrl?.dispose();
    _postalCodeCtrl?.dispose();
    _additionalInfoCtrl?.dispose();
    super.dispose();
  }

  void _setupAddressValue() {
    _data = context.read<AccountProvider>().accountData;
    String fullName = _data?.firstName;
    fullName += _data?.lastName != null ? ' ${_data?.lastName}' : '';
    _receiverNameCtrl?.text = fullName ?? '';

    String defaultAddressId = _data?.defaultShippingAddressId;

    if (defaultAddressId != null ||
        defaultAddressId != '' ||
        _data?.addresses?.first?.id != null ||
        _data?.addresses?.first?.id != '') {
      String refId = widget.type == FormType.EDIT_ADDRESS
          ? widget?.addressId
          : defaultAddressId;
      _defaultAddress = _data.addresses.firstWhere((e) {
        return e.id == refId;
      }, orElse: () => null);
      if (_defaultAddress != null) {
        if (_defaultAddress?.phone != null || _defaultAddress?.phone != '') {
          var first = _defaultAddress?.phone?.substring(0, 4) ?? '';
          var middle = _defaultAddress?.phone?.substring(4, 7) ?? '';
          var last = _defaultAddress?.phone?.substring(7) ?? '';
          var result = '+1 ($first) $middle-$last';
          _phoneCtrl?.text = result ?? '';
        }
        if (widget.type == FormType.EDIT_ADDRESS) {
          _addressTitleCtrl?.text = _defaultAddress?.title ?? '';
          _streetNumberCtrl?.text = _defaultAddress?.streetNumber ?? '';
          _streetNameCtrl?.text = _defaultAddress?.streetName ?? '';
          _selectedState = _defaultAddress?.state ?? '';
          _selectedCity = _defaultAddress?.city;
          // _selectedCity = "Brockton";
          Resources().usCityList[_selectedState].forEach((e) {
            _cityItems.add(DropdownMenuItem(
              child: Text(e),
              value: e,
            ));
          });
          _postalCodeCtrl?.text = _defaultAddress?.postalCode ?? '';
          _additionalInfoCtrl?.text =
              _defaultAddress?.additionalAddressInfo ?? '';
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          widget.type == FormType.ADD_ADDRESS ? 'Add Address' : 'Edit Address',
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
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                width: MediaQuery.of(context).size.width,
                child: Form(
                  key: _formKey,
                  child: _buildBody(context, widget.type),
                ),
              ),
            ),
            PositionedSpinner(
              status: context.watch<AccountProvider>().loadingStatus,
              scaffoldKey: _scaffoldKey,
            ),
          ],
        ),
      ),
    );
  }

  _buildBody(BuildContext context, FormType type) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 14),
          child: TextFormField(
            controller: _addressTitleCtrl,
            textInputAction: TextInputAction.next,
            validator: emptyValidation,
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(bottom: 0),
                labelText: 'Address Title',
                alignLabelWithHint: true,
                errorStyle: TextStyle(height: 0)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 14),
          child: TextFormField(
            controller: _receiverNameCtrl,
            textInputAction: TextInputAction.next,
            validator: emptyValidation,
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(bottom: 0),
                labelText: 'Receiver Name',
                alignLabelWithHint: true,
                errorStyle: TextStyle(height: 0)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 14),
          child: TextFormField(
            controller: _phoneCtrl,
            textInputAction: TextInputAction.next,
            inputFormatters: [phoneMask],
            keyboardType: TextInputType.number,
            validator: emptyValidation,
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(bottom: 0),
                labelText: 'Receiver Phone Number',
                alignLabelWithHint: true,
                errorStyle: TextStyle(height: 0)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 14),
          child: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: TextFormField(
                    controller: _streetNumberCtrl,
                    textInputAction: TextInputAction.next,
                    inputFormatters: [LengthLimitingTextInputFormatter(12)],
                    validator: emptyValidation,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(bottom: 0),
                        labelText: 'Street Number',
                        alignLabelWithHint: true,
                        errorStyle: TextStyle(height: 0)),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 6),
                  child: TextFormField(
                    controller: _streetNameCtrl,
                    textInputAction: TextInputAction.next,
                    validator: emptyValidation,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(bottom: 0),
                        labelText: 'Street Name',
                        alignLabelWithHint: true,
                        errorStyle: TextStyle(height: 0)),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(top: 14),
            child: DropdownButtonFormField(
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
                currentFocus.focusedChild;
              },
              validator: emptyValidation,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(bottom: 0),
                  labelText: 'State',
                  alignLabelWithHint: true,
                  errorStyle: TextStyle(height: 0)),
              value: _selectedState,
              items: Resources()
                  .usStateList
                  .map((e) => DropdownMenuItem(
                        child: Text(e['name']),
                        value: e['abbreviation'],
                      ))
                  .toList(),
              onChanged: (val) {
                print('onChanged $val');
                List<DropdownMenuItem> newList = [];
                Resources().usCityList[val].forEach((e) {
                  newList.add(DropdownMenuItem(
                    child: Text(e),
                    value: e,
                  ));
                });
                print('newList > ${newList?.toList()}');
                setState(() {
                  _selectedCity = null;
                  _selectedState = val;
                  _cityItems = newList;
                });
              },
            )),
        Padding(
            padding: const EdgeInsets.only(top: 14),
            child: DropdownButtonFormField(
              validator: (v) => emptyValidation(v),
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(bottom: 0),
                  labelText: 'City',
                  alignLabelWithHint: true,
                  errorStyle: TextStyle(height: 0)),
              value: _selectedCity,
              items: _cityItems,
              onChanged: (val) {
                print('onChanged $val');
                setState(() {
                  _selectedCity = val;
                });
              },
            )),
        Padding(
          padding: const EdgeInsets.only(top: 14),
          child: TextFormField(
            validator: emptyValidation,
            controller: _postalCodeCtrl,
            textInputAction: TextInputAction.done,
            inputFormatters: [
              LengthLimitingTextInputFormatter(5),
            ],
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(bottom: 0),
                labelText: 'Postal Code',
                alignLabelWithHint: true,
                errorStyle: TextStyle(height: 0)),
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(top: 14),
            child: DropdownButtonFormField(
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
                currentFocus.focusedChild;
              },
              validator: emptyValidation,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(bottom: 0),
                  labelText: 'State',
                  alignLabelWithHint: true,
                  errorStyle: TextStyle(height: 0)),
              value: _selectedCountry,
              items: [
                DropdownMenuItem(
                  child: Text('United States'),
                  value: 'US',
                )
              ],
              onChanged: (val) {
                print('onChanged $val');
                setState(() {
                  _selectedCountry = val;
                });
              },
            )),
        Padding(
          padding: const EdgeInsets.only(top: 14),
          child: TextFormField(
            // validator: emptyValidation,
            controller: _additionalInfoCtrl,
            minLines: 1,
            maxLines: 5,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(bottom: 0),
                labelText: 'Additional Address',
                alignLabelWithHint: true,
                errorStyle: TextStyle(height: 0)),
          ),
        ),
        Container(
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
            // padding: const EdgeInsets.only(left: 8, right: 8),
            child: Text('Save'),
          ),
        ),
      ],
    );
  }

  void _submitFormHandler(BuildContext context) async {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) currentFocus.unfocus();

    if (_formKey.currentState.validate()) {
      String fullName = _receiverNameCtrl.text;
      String fName, lName;
      if (fullName.isNotEmpty) {
        var n = fullName.split(' ');
        fName = n?.first?.trim();
        // lName = n?.last ?? null;
        fullName = fName.trim();
        if (n.length > 1) {
          lName = n?.last?.trim();
          fullName += ' $lName';
        }
      }
      String unMaskPhone =
          _phoneCtrl?.text?.replaceAll(unmaskPhoneRegex, '')?.trim() ?? '';
      String salutation =
          _defaultAddress?.salutation ?? _data?.salutation ?? fName;
      Addresses address = Addresses(
          id: '',
          title: _addressTitleCtrl?.text?.trim(),
          salutation: salutation?.trim() ?? '',
          firstName: fName?.trim() ?? '',
          lastName: lName?.trim() ?? '',
          streetNumber: _streetNumberCtrl?.text?.trim(),
          streetName: _streetNameCtrl?.text?.trim(),
          state: _selectedState?.trim(),
          city: _selectedCity?.trim(),
          region: _selectedCity?.trim(),
          postalCode: _postalCodeCtrl?.text?.trim(),
          country: _selectedCountry?.trim(),
          phone: unMaskPhone,
          mobile: unMaskPhone,
          email: _data?.email?.trim(),
          additionalAddressInfo: _additionalInfoCtrl?.text?.trim() ?? '');

      var payloads;
      if (widget.type == FormType.EDIT_ADDRESS) {
        address.id = _defaultAddress?.id?.trim();
        payloads = AccountPayload().changeAddress(_data?.version, address);
      } else {
        payloads = AccountPayload().addAddress(_data?.version, address);
      }
      print('payloads>>$payloads');
      context.read<AccountProvider>().postRequest(payloads).then((value) {
        if (value != null) {
          var formType =
              widget.type == FormType.ADD_ADDRESS ? "Saved" : "Updated";
          var snackbarTx = 'Address $formType';
          _scaffoldKey.currentState
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
                content: Text(snackbarTx, textAlign: TextAlign.center)));
          _timer = Timer(Duration(milliseconds: 1500), () {
            _scaffoldKey.currentState.hideCurrentSnackBar();
            Navigator.of(context).pop();
          });
        }
      });
    } else {
      _scaffoldKey.currentState
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(
            content: Text('Required Field Cannot be empty',
                textAlign: TextAlign.center)));
    }
  }
}
