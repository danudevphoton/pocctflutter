import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../provider/account_provider.dart';
import '../../../model/customer_model.dart';
import '../account_payload.dart';
import '../widgets/edit_account_form.dart';
import '../widgets/native_alert_dialog.dart';
import '../widgets/positioned_spinner.dart';
import '../widgets/safe_area_view.dart';
import 'address_card.dart';
import 'address_form.dart';

class AddressesList extends StatefulWidget {
  @override
  _AddressesListState createState() => _AddressesListState();
}

class _AddressesListState extends State<AddressesList> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    CustomerModel data = context.watch<AccountProvider>().accountData;
    // print('AddressList data>${data?.toJson()}');
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'Address List',
          style: TextStyle(fontSize: 18),
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddressForm(
                              type: FormType.ADD_ADDRESS,
                            )));
              },
              child: Container(
                color: Colors.transparent,
                child: Center(
                  child: Text(
                    'Add Address',
                    style: TextStyle(color: Colors.greenAccent),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      body: SafeAreaView(
        child: Stack(
          children: [
            _buildContentBody(context, data),
            PositionedSpinner(
              status: context.watch<AccountProvider>().loadingStatus,
              scaffoldKey: _scaffoldKey,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContentBody(BuildContext context, CustomerModel data) {
    return data.addresses.length > 0
        ? SingleChildScrollView(
            child: Column(
              children: data.addresses
                  .map((e) => AddressCard(
                        address: e,
                        isDefaultAddress:
                            e?.id == data?.defaultShippingAddressId,
                        onDelete: () {
                          print('debug[onDeleteTap]');
                          _deleteHandler(data, e);
                        },
                        onSetDefaultAddress: () {
                          print('debug[onSetDefaultAddressTap]');
                          _setDefaultAddressHandler(data, e);
                        },
                        onEdit: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddressForm(
                                    type: FormType.EDIT_ADDRESS,
                                    addressId: e?.id)),
                          );
                        },
                      ))
                  .toList(),
            ),
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text("You don't have any address!",
                    style: TextStyle(fontSize: 18)),
              ),
              Container(
                  margin: const EdgeInsets.all(14),
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(color: Colors.blue)),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddressForm(
                                    type: FormType.ADD_ADDRESS,
                                  )));
                    },
                    color: Colors.blue,
                    textColor: Colors.white,
                    // padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Text('Add Address'),
                  )),
            ],
          );
  }

  _deleteHandler(CustomerModel data, Addresses e) {
    return showDialog(
        context: context,
        builder: (aContext) => NativeAlertDialog(
              title: 'Alert Dialog',
              content: 'Are you sure you want to delete the address?',
              actions: [
                NativeAlertDialogAction(
                    label: 'No', onPressed: () => Navigator.of(context).pop()),
                NativeAlertDialogAction(
                    label: 'Yes',
                    onPressed: () {
                      Navigator.of(context).pop();
                      var payloads =
                          AccountPayload().removeAddress(data?.version, e?.id);
                      print('payloads>>$payloads');
                      context
                          .read<AccountProvider>()
                          .postRequest(payloads)
                          .then((value) {
                        var msg = value != null
                            ? 'Address Deleted Successfully'
                            : 'Address Failed to Delete';
                        _scaffoldKey.currentState
                          ..hideCurrentSnackBar()
                          ..showSnackBar(SnackBar(
                              content: Text(msg, textAlign: TextAlign.center)));
                      });
                    }),
              ],
            ));
  }

  void _setDefaultAddressHandler(CustomerModel data, Addresses e) {
    // var payloads = AccountPayload().setDefaultAddressPayload(e?.id);
    var payloads = AccountPayload().setDefaultAddress(data?.version, e?.id);
    // var postBody = AccountPayload().mainBody(data?.version, actions);
    print('payloads>>${jsonEncode(payloads)}');
    context.read<AccountProvider>().postRequest(payloads).then((value) {
      var msg = value != null
          ? 'Set as Default Address Successfully'
          : 'Set as Default Address Failed';
      _scaffoldKey.currentState
        ..hideCurrentSnackBar()
        ..showSnackBar(
            SnackBar(content: Text(msg, textAlign: TextAlign.center)));
    });
  }
}
