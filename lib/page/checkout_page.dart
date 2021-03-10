import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CheckoutPage extends StatefulWidget {
  CheckoutPage({Key key}) : super(key: key);

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  //List<user> users;
  int selectedUser;

  @override
  void initState() {
    super.initState();
    //users = User.getUsers();
    selectedUser = 0;
  }

  setSelectedUser(int user) {
    setState(() {
      selectedUser = user;
    });
  }

  List<Widget> createRadioListUsers() {
    List<Widget> widgets = [];
    //for (User user in users) {
    widgets.add(
      RadioListTile(
        value: 1,
        groupValue: selectedUser,
        title: Text("COD"),
        subtitle: Text("BA"),
        onChanged: (currentUser) {
          print("Current");
          setSelectedUser(currentUser);
        },
        selected: selectedUser == 1,
        activeColor: Colors.green,
      ),
    );
    widgets.add(
      RadioListTile(
        value: 2,
        groupValue: selectedUser,
        title: Text("Pick Up"),
        subtitle: Text("Sendiri"),
        onChanged: (currentUser) {
          print("Current");
          setSelectedUser(currentUser);
        },
        selected: selectedUser == 2,
        activeColor: Colors.green,
      ),
    );
    //}
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Checkout"),
          elevation: 0,
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10.0),
                color: Colors.grey.shade200,
                child: Container(
                  margin: const EdgeInsets.only(top: 5.0),
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Review and Submit Your Order",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            width: 120,
                            height: 120,
                            child: CachedNetworkImage(
                              imageUrl: "http://via.placeholder.com/120x120",
                              placeholder: (context, url) =>
                                  new CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  new Icon(Icons.error),
                            ),
                          ),
                          Container(
                              padding: const EdgeInsets.all(8),
                              width: MediaQuery.of(context).size.width * 0.55,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Text("Nama Product"),
                                  ),
                                  Container(
                                    child: Text("Keterangan"),
                                  ),
                                ],
                              )),
                          Container(
                            child: Text("1"),
                          )
                        ],
                      ),
                      Divider(
                        color: Colors.grey.shade300,
                      ),
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Shipping Method",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w600),
                        ),
                      ),
                      buildShippingMethod(),
                    ],
                  ),
                ),
              ),
            ),
            Column(children: [
              Expanded(
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Container(
                      color: Colors.white,
                      height: MediaQuery.of(context).size.height * 0.15,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.fromLTRB(13, 10, 13, 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  "1000",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                  padding: const EdgeInsets.all(8),
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    onPressed: () {},
                                    color: Colors.red,
                                    textColor: Colors.white,
                                    child: Text("Back To Cart".toUpperCase(),
                                        style: TextStyle(fontSize: 14)),
                                  )),
                              Container(
                                  padding: const EdgeInsets.all(8),
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    onPressed: () {},
                                    color: Colors.blueAccent,
                                    textColor: Colors.white,
                                    child: Text("Checkout".toUpperCase(),
                                        style: TextStyle(fontSize: 14)),
                                  ))
                            ],
                          ),
                        ],
                      )),
                ),
              ),
            ])
          ],
        ));
  }

  Widget buildShippingMethod() {
    return Column(
      children: createRadioListUsers(),
    );
  }
}
