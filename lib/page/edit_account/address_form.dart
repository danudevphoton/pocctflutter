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
          child: Padding(
        padding: const EdgeInsets.only(left: 8, top: 0, right: 8, bottom: 8),
        child: Column(
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
        ),
      )),
    );
  }

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
}
