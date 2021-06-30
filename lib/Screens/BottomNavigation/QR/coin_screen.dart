import 'package:WE/Screens/BottomNavigation/bottom_navigation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:WE/Resources/components/or_divider.dart';
import '../../../Resources/components/social_icon.dart';
import '../../../Resources/constants.dart';

class CoinScreenExample extends StatefulWidget {
  final String qrResult;
  final String currentText;

  CoinScreenExample({this.qrResult, this.currentText});

  @override
  _CoinScreenExampleState createState() => _CoinScreenExampleState();
}

class _CoinScreenExampleState extends State<CoinScreenExample> {
  List<int> coinsList = [];
  List<int> recycledList = [];
  List<int> expList = [];

  int measuredWeight;
  int measuredCoin;
  final databaseReference = FirebaseDatabase.instance.reference();
  final currentUid = FirebaseAuth.instance.currentUser.uid;
  CollectionReference users = FirebaseFirestore.instance.collection("users");

  int doubleWeight(int number) {
    if (number != 0) {
      return number = number + number;
    }
    return number;
  }

  @override
  void initState() {
    super.initState();
    databaseReference
        .child(widget.qrResult == null ? widget.currentText : widget.qrResult)
        .once()
        .then((DataSnapshot data) {
      print(data.value["WEIGHT"]);
      print(data.key);
      setState(() {
        measuredWeight = data.value["WEIGHT"];
        measuredCoin = measuredWeight + measuredWeight;
      });
      getUserData("coins").then((value) {
        coinsList.clear();
        coinsList.add(int.parse(value));
      });
      getUserData("exp").then((value) {
        expList.clear();
        expList.add(int.parse(value));
      });
      getUserData("recycled").then((value) {
        recycledList.clear();
        recycledList.add(int.parse(value));
      });
    });
  }

  Future<String> getUserData(str) async {
    var document = await users.doc(currentUid);
    document.get().then((value) => print(value));
    var collection = FirebaseFirestore.instance.collection('users');
    var docSnapshot = await collection.doc(currentUid).get();
    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data();
      var coins = data[str];
      return coins.toString();
    }
  }

  Future<void> getReward() {
    return users
        .doc(currentUid)
        .update({
          'recycled': measuredWeight + recycledList.first,
          "coins": measuredWeight * 2 + coinsList.first,
          // "exp": expList.first+ measuredWeight/100,
        })
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            getReward();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return BottomNavigation();
                },
              ),
            );
          },
        ),
        centerTitle: true,
        title: Text(
          'GET YOUR REWARD',
          style: TextStyle(fontFamily: "Panthera"),
        ),
        actions: [],
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 24),
                child: PhysicalModel(
                  elevation: 10.0,
                  shape: BoxShape.rectangle,
                  shadowColor: Colors.green,
                  color: Colors.grey[850],
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                        height: 300.0,
                        width: 375.0,
                        color: Colors.grey[850],
                        child: Align(
                          alignment: Alignment(0, -0.5),
                          child: Column(
                            children: [
                              SizedBox(
                                height: size.height * 0.025,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      PhysicalModel(
                                        elevation: 20.0,
                                        shape: BoxShape.circle,
                                        shadowColor: Colors.green,
                                        color: kSecondaryColor,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(90)),
                                          child: Container(
                                            width: 170,
                                            height: 170,
                                            color: Colors.white,
                                            child: Image.asset(
                                              "assets/Icons/approved.png",
                                              scale: 0.7,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: size.height * 0.005,
                                      ),
                                      Container(
                                        child: Text(
                                          "Successful.",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: size.height * 0.05,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  PhysicalModel(
                                    elevation: 20.0,
                                    shape: BoxShape.circle,
                                    shadowColor: Colors.yellow,
                                    color: kSecondaryColor,
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(90)),
                                      child: Container(
                                        width: 90,
                                        height: 90,
                                        color: Colors.white,
                                        child: Image.asset(
                                          "assets/Icons/coin.png",
                                          scale: 1.2,
                                        ),
                                      ),
                                    ),
                                  ),
                                  PhysicalModel(
                                    elevation: 20.0,
                                    shape: BoxShape.circle,
                                    shadowColor: Colors.yellow,
                                    color: kSecondaryColor,
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(90)),
                                      child: Container(
                                        width: 90,
                                        height: 90,
                                        color: Colors.white,
                                        child: Image.asset(
                                          "assets/Icons/recycle-sign.png",
                                          scale: 1.8,
                                        ),
                                      ),
                                    ),
                                  ),
                                  PhysicalModel(
                                    elevation: 20.0,
                                    shape: BoxShape.circle,
                                    shadowColor: Colors.yellow,
                                    color: kSecondaryColor,
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(90)),
                                      child: Container(
                                        width: 90,
                                        height: 90,
                                        color: Colors.white,
                                        child: Image.asset(
                                          "assets/Icons/renewable-energy.png",
                                          scale: 1.8,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        "Coin you get",
                                        style: TextStyle(color: Colors.white),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text("Recycled",
                                          style: TextStyle(color: Colors.white))
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text("Your Impact",
                                          style: TextStyle(color: Colors.white))
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                height: size.height * 0.008,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        measuredCoin.toString(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 24),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                          "  " +
                                              measuredWeight.toString() +
                                              " g",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 24))
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text("3 wH",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 24))
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                height: size.height * 0.09,
                              ),
                              OrDivider(text: "Share it!"),
                              SizedBox(
                                height: size.height * 0.015,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SocialIcon(
                                    iconSrc: "assets/Icons/facebook64.png",
                                    press: () {},
                                  ),
                                  SocialIcon(
                                    iconSrc: "assets/Icons/instagram2.png",
                                    press: () {},
                                  ),
                                  SocialIcon(
                                    iconSrc: "assets/Icons/twitter.png",
                                    press: () {},
                                  ),
                                ],
                              )
                            ],
                          ),
                        )),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
