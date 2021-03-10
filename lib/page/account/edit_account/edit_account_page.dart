import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'address_content.dart';

enum EditingType { NAME, ADDRESS }

class EditAccountPage extends StatelessWidget {
  final EditingType type;

  const EditAccountPage({Key key, @required this.type}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Widget page;
    if (type == EditingType.ADDRESS) {
      page = AddressContent();
    }
    return page;
  }
}
