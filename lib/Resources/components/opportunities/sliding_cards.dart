import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:WE/Resources/components/pop_up.dart';
import 'dart:math' as math;

import 'package:WE/Resources/constants.dart';

class Cards extends StatefulWidget {
  @override
  _CardsState createState() => _CardsState();
}

class _CardsState extends State<Cards> {
  PageController pageController;
  double pageOffset = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController(viewportFraction: 0.8);
    pageController.addListener(() {
      setState(() => pageOffset = pageController.page);
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.55,
      child: PageView(
        controller: pageController,
        children: <Widget>[
          SlidingCard(
              name: 'Amazon %25 OFF',
              date: '31.05 / 30.06',
              assetName: 'assets/Images/Offers/amazon.jpg',
              offset: pageOffset,
              price: "200.00 WE coin"),
          SlidingCard(
              name: 'Get your Tesla with WE Coin',
              date: '1.05.2021 / --',
              assetName: 'assets/Images/Offers/tesla.jpg',
              offset: pageOffset - 1,
              price: "25.000 WE coin"),
          SlidingCard(
              name: 'Buy 1, get 1 for free',
              date: '31.05 / 30.06',
              assetName: 'assets/Images/Offers/ebay.jpg',
              offset: pageOffset - 2,
              price: "250.00 WE coin"),
          SlidingCard(
              name: 'At least 15% discount at eBay',
              date: '31.05 / 30.06',
              assetName: 'assets/Images/Offers/wallmart.jpg',
              offset: pageOffset - 3,
              price: "100.00 WE coin"),
        ],
      ),
    );
  }
}

class SlidingCard extends StatelessWidget {
  final String name;
  final String date;
  final String assetName;
  final double offset;
  final String price;

  const SlidingCard({
    Key key,
    @required this.name,
    @required this.date,
    @required this.assetName,
    @required this.offset,
    @required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double gauss = math.exp(-(math.pow((offset.abs() - 0.5), 2) / 0.08));
    return Transform.translate(
      offset: Offset(-32 * gauss * offset.sign, 0),
      child: Card(
        margin: EdgeInsets.only(left: 8, right: 8, bottom: 72, top: 36),
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              child: Image.asset(
                assetName,
                height: MediaQuery.of(context).size.height * 0.3,
                alignment: Alignment(-offset.abs(), 0),
                fit: BoxFit.none,
              ),
            ),
            SizedBox(height: 8),
            Expanded(
              child: CardContent(
                name: name,
                date: date,
                offset: gauss,
                price: price,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardContent extends StatelessWidget {
  final String name;
  final String date;
  final double offset;
  final String price;

  const CardContent({
    Key key,
    @required this.name,
    @required this.date,
    @required this.offset,
    @required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Transform.translate(
            offset: Offset(8 * offset, 0),
            child: Text(name, style: TextStyle(fontSize: 20)),
          ),
          SizedBox(height: 8),
          Transform.translate(
            offset: Offset(32 * offset, 0),
            child: Text(
              date,
              style: TextStyle(color: Colors.grey),
            ),
          ),
          Spacer(),
          Row(
            children: <Widget>[
              Transform.translate(
                offset: Offset(48 * offset, 0),
                child: RaisedButton(
                  color: kPrimaryColor,
                  child: Transform.translate(
                    offset: Offset(24 * offset, 0),
                    child: Text('Use'),
                  ),
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  onPressed: () {
                    popUp(context, true,
                        "We have received your request and we will inform you when your transaction takes place.");
                  },
                ),
              ),
              Spacer(),
              Transform.translate(
                offset: Offset(32 * offset, 0),
                child: Text(
                  price,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(width: 16),
            ],
          )
        ],
      ),
    );
  }
}
