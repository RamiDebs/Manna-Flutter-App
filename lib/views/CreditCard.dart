import 'package:awesome_card/awesome_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Creditcard extends StatefulWidget {
  Creditcard({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _CreditcardState createState() => _CreditcardState();
}

class _CreditcardState extends State<Creditcard> {
  String cardNumber = "";
  String cardHolderName = "";
  String expiryDate = "";
  String cvv = "";
  bool showBack = false;

  FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = new FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _focusNode.hasFocus ? showBack = true : showBack = false;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 40,
        ),
        CreditCard(
          cardNumber: cardNumber,
          cardExpiry: expiryDate,
          cardHolderName: cardHolderName,
          cvv: cvv,
          bankName: "Mana Bank",
          showBackSide: showBack,
          frontBackground: CardBackgrounds.black,
          backBackground: CardBackgrounds.white,
          showShadow: true,
        ),
        SizedBox(
          height: 40,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: TextFormField(
                keyboardType: TextInputType.numberWithOptions(),
                decoration: InputDecoration(hintText: "Card Number"),
                maxLength: 19,
                onChanged: (value) {
                  setState(() {
                    cardNumber = value;
                  });
                },
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: TextFormField(
                keyboardType: TextInputType.numberWithOptions(),
                decoration: InputDecoration(hintText: "Card Expiry"),
                maxLength: 5,
                onChanged: (value) {
                  setState(() {
                    expiryDate = value;
                  });
                },
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(hintText: "Card Holder Name"),
                onChanged: (value) {
                  setState(() {
                    cardHolderName = value;
                  });
                },
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              child: TextFormField(
                keyboardType: TextInputType.numberWithOptions(),
                decoration: InputDecoration(hintText: "CVV"),
                maxLength: 3,
                onChanged: (value) {
                  setState(() {
                    cvv = value;
                  });
                },
                focusNode: _focusNode,
              ),
            ),
          ],
        )
      ],
    );
  }
}
