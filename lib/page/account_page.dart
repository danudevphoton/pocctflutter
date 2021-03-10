import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'edit_account/address_form.dart';
import 'edit_account/edit_account_page.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeAreaView(
        child: Column(
          children: [
            PersonalSection(),
            ListTile(
              title: 'Daftar Alamat',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EditAccountPage(
                            type: EditingType.ADDRESS,
                          )),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class PersonalSection extends StatelessWidget {
  final fName = 'el';
  final lName = 'araya';

  String _acronym() {
    var result = fName.substring(0, 1) + lName.substring(0, 1);
    return result.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(14),
            child: CircleAvatar(
              radius: 24,
              backgroundColor: Colors.brown.shade800,
              child: Text(_acronym()),
            ),
          ),
          ListTileEdit(
            label: 'Name',
            content: titleCase('$fName $lName'),
            onEditTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddressForm(
                            type: FormType.EDIT_NAME,
                          )));
            },
          ),
          ListTileEdit(
              label: 'Date of Birth', content: titleCase('28 October 1995')),
          ListTileEdit(label: 'Gender', content: titleCase('male')),
          ListTileEdit(
            label: 'Email',
            content: 'araya@mailinator.com',
            onEditTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddressForm(
                            type: FormType.EDIT_EMAIL,
                          )));
            },
          ),
          ListTileEdit(
            label: 'Phone',
            content: phoneFormater('083713791379'),
            onEditTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddressForm(
                            type: FormType.EDIT_PHONE,
                          )));
            },
          ),
        ],
      ),
    );
  }
}

class ListTileEdit extends StatelessWidget {
  final String label;
  final String content;
  final GestureTapCallback onEditTap;

  const ListTileEdit(
      {Key key, @required this.label, this.content = '', this.onEditTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      width: MediaQuery.of(context).size.width,
      color: Colors.transparent,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [
                Wrap(
                  direction: Axis.vertical,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(label, style: TextStyle(fontSize: 14)),
                    ),
                    Text(content, style: TextStyle(fontSize: 16)),
                  ],
                ),
                onEditTap == null
                    ? SizedBox()
                    : Container(
                        // color: Colors.amber,
                        margin: const EdgeInsets.only(right: 8),
                        child: GestureDetector(
                          onTap: onEditTap,
                          child: Text('Edit',
                              style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.bold)),
                        ),
                      )
              ],
            ),
          ),
          // Divider(
          //   height: 1,
          //   thickness: 1,
          //   color: Colors.black,
          // )
        ],
      ),
    );
  }
}

class ListTile extends StatelessWidget {
  final String title;
  final GestureTapCallback onTap;

  const ListTile({Key key, @required this.title, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(4),
        width: MediaQuery.of(context).size.width,
        color: Colors.transparent,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title, style: TextStyle(fontSize: 16)),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 24,
                  ),
                ],
              ),
            ),
            Divider(
              height: 1,
              thickness: 1,
              color: Colors.black,
            )
          ],
        ),
      ),
    );
  }
}

class SafeAreaView extends StatelessWidget {
  final Widget child;

  const SafeAreaView({Key key, @required this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          print('debug[currentFocus] ${currentFocus.hasPrimaryFocus}');
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.transparent,
          child: child,
        ),
      ),
    );
  }
}

///
/// function
///
String titleCase(String src) {
  var result = '';
  var splited = src.split(' ');
  for (var e in splited) {
    result += '${e[0].toUpperCase()}${e.substring(1)} ';
  }

  return result.trim();
}

String phoneFormater(String src) {
  var result = '';
  for (var i = 0; i < src.length; i++) {
    result += src[i];
    if (i == 3 || i == 7) {
      result += '-';
    }
  }
  return result.trim();
}
