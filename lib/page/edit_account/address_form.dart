import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/page/account_page.dart';

enum FormType { ADD_ADDRESS, EDIT_ADDRESS, EDIT_NAME, EDIT_EMAIL, EDIT_PHONE }

class AddressForm extends StatefulWidget {
  final FormType type;

  const AddressForm({Key key, this.type}) : super(key: key);
  @override
  _AddressFormState createState() => _AddressFormState();
}

class _AddressFormState extends State<AddressForm> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String _appBarTitle() {
    String txt = '';
    if (widget.type == FormType.ADD_ADDRESS)
      txt = 'Add Address';
    else if (widget.type == FormType.EDIT_ADDRESS)
      txt = 'Edit Address';
    else if (widget.type == FormType.EDIT_NAME)
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
          child: Padding(
        padding: const EdgeInsets.only(left: 8, top: 0, right: 8, bottom: 8),
        child: _buildBody(context, widget.type),
      )),
    );
  }

  Widget _buildBody(BuildContext context, FormType type) {
    Widget w;
    if (type == FormType.ADD_ADDRESS || type == FormType.EDIT_ADDRESS) {
      w = _buildAddressForm(context);
    } else if (type == FormType.EDIT_NAME) {
      w = _buildNameForm(context);
    } else if (type == FormType.EDIT_EMAIL) {
      w = _buildEmailForm(context);
    } else if (type == FormType.EDIT_PHONE) {
      w = _buildPhoneForm(context);
    }
    return w;
  }

  Widget _buildAddressForm(BuildContext context) => Column(
        children: [
          TextFormField(
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(bottom: 0),
                labelText: 'Save Address as',
                alignLabelWithHint: true),
          ),
          TextFormField(
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(bottom: 0),
                labelText: 'Receiver Name',
                alignLabelWithHint: true),
          ),
          TextFormField(
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(bottom: 0),
                labelText: 'Receiver Phone Number',
                alignLabelWithHint: true),
          ),
          TextFormField(
            minLines: 1,
            maxLines: 5,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(bottom: 0),
                labelText: 'Address',
                alignLabelWithHint: true),
          ),
          TextFormField(
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(bottom: 0),
                labelText: 'Province',
                alignLabelWithHint: true),
          ),
          TextFormField(
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(bottom: 0),
                labelText: 'City or District',
                alignLabelWithHint: true),
          ),
          TextFormField(
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(bottom: 0),
                labelText: 'Sub-district',
                alignLabelWithHint: true),
          ),
          TextFormField(
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(bottom: 0),
                labelText: 'Postal Code',
                alignLabelWithHint: true),
          ),
          Container(
            margin: const EdgeInsets.only(top: 14),
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

  void _submitFormHandler(BuildContext context) {
    var content =
        'Address ${widget.type == FormType.ADD_ADDRESS ? "Saved" : "Updated"}';
    _scaffoldKey.currentState
      ..hideCurrentSnackBar()
      ..showSnackBar(
          SnackBar(content: Text(content, textAlign: TextAlign.center)));
    Future.delayed(Duration(seconds: 3), () {
      _scaffoldKey.currentState.hideCurrentSnackBar();
      Navigator.of(context).pop();
    });
  }

  Widget _buildNameForm(BuildContext context) => Column(
        children: [
          TextFormField(
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(bottom: 0),
                labelText: 'First Name',
                alignLabelWithHint: true),
          ),
          TextFormField(
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(bottom: 0),
                labelText: 'Last Name',
                alignLabelWithHint: true),
          ),
          Container(
            margin: const EdgeInsets.only(top: 14),
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

  Widget _buildEmailForm(BuildContext context) => Column(
        children: [
          TextFormField(
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(bottom: 0),
                labelText: 'Email Address',
                alignLabelWithHint: true),
          ),
          Container(
            margin: const EdgeInsets.only(top: 14),
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

  Widget _buildPhoneForm(BuildContext context) => Column(
        children: [
          TextFormField(
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(bottom: 0),
                labelText: 'Phone Number',
                alignLabelWithHint: true),
          ),
          Container(
            margin: const EdgeInsets.only(top: 14),
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
