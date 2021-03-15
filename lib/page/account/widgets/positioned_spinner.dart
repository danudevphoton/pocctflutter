import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../provider/account_provider.dart';

class PositionedSpinner extends StatefulWidget {
  final bool status;
  final GlobalKey<ScaffoldState> scaffoldKey;

  const PositionedSpinner(
      {Key key, @required this.status, @required this.scaffoldKey})
      : super(key: key);

  @override
  _PositionedSpinnerState createState() => _PositionedSpinnerState();
}

class _PositionedSpinnerState extends State<PositionedSpinner> {
  Timer _timer;

  // @override
  // void initState() {
  //   print('debug[PositionedSpinner] initState');
  //   _doSelfDestruct();
  //   super.initState();
  // }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _doSelfDestruct() {
    print('debug[PositionedSpinner] _doSelfDestruct>${widget.status}');
    _timer?.cancel();
    if (widget.status) {
      _timer = Timer(Duration(seconds: 7), () {
        widget.scaffoldKey.currentState
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(
              content:
                  Text('Something When Wrong', textAlign: TextAlign.center)));
        context.read<AccountProvider>().setLoading(false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _doSelfDestruct();
    return widget.status
        ? Positioned(
            left: 0,
            top: 0,
            right: 0,
            bottom: 0,
            child: Container(
                color: Colors?.black38,
                child: Center(child: CircularProgressIndicator())),
          )
        : SizedBox();
  }
}
