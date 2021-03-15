import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class NativeAlertDialogAction {
  final String label;
  final VoidCallback onPressed;

  NativeAlertDialogAction({@required this.label, @required this.onPressed});
}

class NativeAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final List<NativeAlertDialogAction> actions;

  const NativeAlertDialog(
      {Key key, @required this.title, @required this.content, this.actions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoAlertDialog(
            title: Text(title),
            content: Text(content),
            actions: actions != null
                ? actions
                    .map((e) => CupertinoDialogAction(
                        child: Text(e.label), onPressed: e.onPressed))
                    .toList()
                : [
                    CupertinoDialogAction(
                      child: Text('Tutup'),
                      onPressed: () => Navigator.of(context).pop(),
                    )
                  ],
          )
        : AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: actions != null
                ? actions
                    .map((e) => FlatButton(
                        child: Text(e.label), onPressed: e.onPressed))
                    .toList()
                : [
                    FlatButton(
                      child: Text("Tutup"),
                      onPressed: () => Navigator.of(context).pop(),
                    )
                  ],
          );
  }
}
