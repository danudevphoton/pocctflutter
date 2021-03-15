import 'package:flutter/material.dart';

class ListTileEdit extends StatelessWidget {
  final String label;
  final String content;
  final VoidCallback onVerifyTap;
  final VoidCallback onEditTap;
  final bool isEmailVerified;

  const ListTileEdit(
      {Key key,
      @required this.label,
      this.content = '',
      this.onVerifyTap,
      this.onEditTap,
      this.isEmailVerified = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
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
                    Container(
                      padding: label == 'Email'
                          ? const EdgeInsets.only(bottom: 4)
                          : const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          Text(label, style: TextStyle(fontSize: 14)),
                          _buildEmailVerifyStatus(context),
                        ],
                      ),
                    ),
                    Text(content, style: TextStyle(fontSize: 16)),
                  ],
                ),
                onEditTap == null
                    ? SizedBox()
                    : Row(
                        children: [
                          label == 'Email' && !isEmailVerified
                              ? Container(
                                  margin: const EdgeInsets.only(right: 14),
                                  child: GestureDetector(
                                      onTap: onVerifyTap,
                                      child: Text('Verify Email',
                                          style: TextStyle(
                                              color: Colors.blueAccent,
                                              fontWeight: FontWeight.bold))),
                                )
                              : SizedBox(),
                          Container(
                            margin: const EdgeInsets.only(right: 8),
                            child: GestureDetector(
                                onTap: onEditTap,
                                child: Text('Edit',
                                    style: TextStyle(
                                        color: Colors.blueAccent,
                                        fontWeight: FontWeight.bold))),
                          )
                        ],
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildEmailVerifyStatus(BuildContext context) {
    var bgColor = isEmailVerified ? Colors.green : Colors.red;
    var status = isEmailVerified ? 'Verified' : 'Unverified';
    return label == 'Email'
        ? Container(
            decoration: BoxDecoration(
                color: bgColor,
                border: Border.all(color: bgColor),
                borderRadius: BorderRadius.all(Radius.circular(4))),
            padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
            margin: const EdgeInsets.only(left: 8),
            child: Text(status,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                )),
          )
        : SizedBox();
  }
}
