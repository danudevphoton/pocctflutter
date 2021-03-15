import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../model/customer_model.dart';
import '../account_utils.dart';
import '../resources.dart';

class AddressCard extends StatelessWidget {
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  final VoidCallback onSetDefaultAddress;
  final bool isDefaultAddress;
  final Addresses address;

  const AddressCard(
      {Key key,
      this.onDelete,
      this.onEdit,
      this.onSetDefaultAddress,
      @required this.address,
      this.isDefaultAddress = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Card(
        margin: const EdgeInsets.all(8),
        elevation: 8,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  // padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                children: [
                  Text(address?.title ?? '',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold)),
                  _buildDefaultAddressStatus(),
                  Expanded(child: SizedBox()),
                  InkWell(onTap: onDelete, child: Icon(Icons.delete_forever))
                ],
              )),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  '${address?.firstName ?? ""} ${address?.lastName ?? ""}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(AccountUtils.phoneFormater(address?.phone)),
              ),
              _buildAddressLine(),
              isDefaultAddress
                  ? SizedBox()
                  : Container(
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

  Widget _buildAddressLine() {
    var stateName = Resources()
        .usStateList
        .firstWhere((e) => e["abbreviation"] == address?.state)["name"];
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Wrap(
        direction: Axis.vertical,
        children: [
          Text('${address?.streetNumber} ${address?.streetName}'),
          Text('${address?.city}, $stateName'),
          Text('${address?.state} ${address?.postalCode}'),
          Text('United States'),
        ],
      ),
    );
  }

  Widget _buildDefaultAddressStatus() {
    return isDefaultAddress
        ? Container(
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
          )
        : SizedBox();
  }
}
