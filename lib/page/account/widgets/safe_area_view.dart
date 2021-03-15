import 'package:flutter/material.dart';

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
