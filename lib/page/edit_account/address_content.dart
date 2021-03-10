import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/page/edit_account/address_form.dart';

import '../account_page.dart';

class AddressContent extends StatefulWidget {
  @override
  _AddressContentState createState() => _AddressContentState();
}

class _AddressContentState extends State<AddressContent> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
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
            child: Center(
                child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddressForm(
                              type: FormType.ADD_ADDRESS,
                            )));
              },
              child: Text(
                'Add Address',
                style: TextStyle(color: Colors.greenAccent),
              ),
            )),
          )
        ],
      ),
      body: SafeAreaView(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AddressCard(
                onDelete: () {
                  print('debug[onDeleteTap]');
                },
                onSetDefaultAddress: () {
                  print('debug[onSetDefaultAddressTap]');
                },
                onEdit: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddressForm(
                                type: FormType.EDIT_ADDRESS,
                              )));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddressCard extends StatelessWidget {
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  final VoidCallback onSetDefaultAddress;

  const AddressCard(
      {Key key, this.onDelete, this.onEdit, this.onSetDefaultAddress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      // margin: const EdgeInsets.all(8),
      child: Card(
        elevation: 8,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  // padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                children: [
                  Text('Address Title',
                      style: TextStyle(
                          color: Colors.black,
                          // fontSize: 14,
                          fontWeight: FontWeight.bold)),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.greenAccent,
                        border: Border.all(color: Colors.greenAccent),
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    padding: const EdgeInsets.all(2),
                    margin: const EdgeInsets.only(left: 8),
                    child: Text('Default Address',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 12,
                        )),
                  ),
                  Expanded(child: SizedBox()),
                  InkWell(onTap: onDelete, child: Icon(Icons.delete_forever))
                ],
              )),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'Receiver Name',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text('083########'),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                    'It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum'),
              ),
              Container(
                margin: const EdgeInsets.only(top: 14),
                height: 30,
                width: MediaQuery.of(context).size.width,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: Colors.blueGrey)),
                  onPressed: onSetDefaultAddress,
                  color: Colors.white,
                  child: Text("Set as Default Address"),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 14),
                height: 30,
                width: MediaQuery.of(context).size.width,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: Colors.blueGrey)),
                  onPressed: onEdit,
                  color: Colors.white,
                  // padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Text("Edit Address"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
