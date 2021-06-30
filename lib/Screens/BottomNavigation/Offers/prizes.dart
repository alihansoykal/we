import 'package:WE/Resources/components/pop_up.dart';
import 'package:WE/Resources/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:collection/collection.dart';

class PrizePage extends StatefulWidget {
  @override
  _PrizePageState createState() => _PrizePageState();
}

class _PrizePageState extends State<PrizePage> {
  List<int> coinsList = [];
  List<bool> boolList = [];
  int _current = 0;
  var items = [
    1,
    2,
    3,
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCoinData().then((value) {
      coinsList.clear();
      coinsList.add(int.parse(value));
    });
  }

  final databaseReference = FirebaseDatabase.instance.reference();
  final currentUid = FirebaseAuth.instance.currentUser.uid;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> updateCoins(
    int i,
    int decrease,
    bool isRegistered1,
    bool isRegistered2,
    bool isRegistered3,
  ) {
    isRegistered1;
    return users
        .doc(currentUid)
        .update({
          'coins': i - decrease,
          "raffle1": isRegistered1,
          "raffle2": isRegistered2,
          "raffle3": isRegistered3
        })
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  Future<String> getCoinData() async {
    var document = await users.doc(currentUid);
    document.get().then((value) => print(value));
    var collection = FirebaseFirestore.instance.collection('users');
    var docSnapshot = await collection.doc(currentUid).get();
    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data();
      var coins = data['coins'];
      return coins.toString();
    }
  }

  Future<bool> getRaffleData(int i) async {
    var document = await users.doc(currentUid);
    document.get().then((value) => print(value));
    var collection = FirebaseFirestore.instance.collection('users');
    var docSnapshot = await collection.doc(currentUid).get();
    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data();
      var raffle = data["raffle" + i.toString()];
      return raffle;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Prizes',
          style: TextStyle(fontFamily: "Panthera", fontSize: 30),
        ),
      ),
      body: Column(
        children: [
          CarouselSlider(
              options: CarouselOptions(
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                },
                height: size.height * 0.4,
                enableInfiniteScroll: false,
                initialPage: 0,
                viewportFraction: 1,
              ),
              items: [
                Column(
                  children: [
                    Container(
                      color: Colors.orange,
                      child: Center(
                          child: Container(
                        decoration: BoxDecoration(
                            color: Colors.orangeAccent, shape: BoxShape.circle),
                        height: size.height * 0.3,
                        width: size.width * 0.5,
                        child: Image.asset(
                          "assets/Icons/gift-box.png",
                          color: Colors.white70,
                          scale: 3.5,
                        ),
                      )),
                    ),
                    Expanded(
                        child: Container(
                            width: size.width * 1,
                            color: Colors.orangeAccent,
                            child: ListTile(
                                title: Text("Welcomer Raffle"),
                                subtitle: Text(
                                    "Join this giveaway to win one of our welcomer gifts."),
                                trailing: Text(
                                  "50 WE Coin",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ))))
                  ],
                ),
                Column(
                  children: [
                    Container(
                      color: Colors.red,
                      child: Center(
                          child: Container(
                        decoration: BoxDecoration(
                            color: Colors.redAccent, shape: BoxShape.circle),
                        height: size.height * 0.3,
                        width: size.width * 0.5,
                        child: Image.asset(
                          "assets/Icons/gift-box-3.png",
                          scale: 3.5,
                        ),
                      )),
                    ),
                    Expanded(
                        child: Container(
                            width: size.width * 1,
                            color: Colors.redAccent,
                            child: ListTile(
                                title: Text("Journeyman Raffle"),
                                subtitle: Text(
                                    "Come on, join this giveaway and get a chance to win surprise gifts."),
                                trailing: Text(
                                  "500 WE Coin",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ))))
                  ],
                ),
                Column(
                  children: [
                    Container(
                      color: Colors.deepPurple,
                      child: Center(
                          child: Container(
                        decoration: BoxDecoration(
                            color: Colors.deepPurpleAccent,
                            shape: BoxShape.circle),
                        height: size.height * 0.3,
                        width: size.width * 0.5,
                        child: Image.asset(
                          "assets/Icons/gift-box-2.png",
                          scale: 3.5,
                        ),
                      )),
                    ),
                    Expanded(
                        child: Container(
                            width: size.width * 1,
                            color: Colors.deepPurpleAccent,
                            child: ListTile(
                                title: Text("Guru Raffle"),
                                subtitle: Text(
                                    "Prove that you are a real Guru by joining this giveaway."),
                                trailing: Text(
                                  "5000 WE Coin",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ))))
                  ],
                ),
              ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: items.map((url) {
              int index = items.indexOf(url);
              return Container(
                width: _current == index ? 20 : 12.0,
                height: _current == index ? 20 : 12.0,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _current == index ? kPrimaryColor : Colors.orange),
              );
            }).toList(),
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          FutureBuilder<DocumentSnapshot>(
              future: users.doc(currentUid).get(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text("Something went wrong");
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  Map<String, dynamic> data = snapshot.data.data();
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (data["coins"] > 50 && data["raffle1"] == false) {
                          updateCoins(data["coins"], 50, true, data["raffle2"],
                              data["raffle3"]);
                          popUp(
                              context,
                              "Your registration for the lottery has been successfully received. Remaining WE Coin: " +
                                  (data["coins"] - 50).toString(),
                              false);
                        } else {
                          popUp(
                              context,
                              "You don't have enough coins for this draw or you have already participated.",
                              true);
                        }
                      });
                    },
                    child: Column(
                      children: [
                        Container(
                          height: size.height * 0.04,
                          width: size.width * 0.6,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [
                                  Colors.lightGreenAccent,
                                  Colors.green,
                                ],
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Center(
                            child: RichText(
                                text: TextSpan(
                              text: "Total WE Coins: ",
                              children: [
                                TextSpan(
                                    text: data["coins"].toString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20)),
                              ],
                            )),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.05,
                        ),
                        Container(
                          height: size.height * 0.06,
                          width: size.width * 0.9,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [
                                  Colors.orangeAccent,
                                  Colors.orange,
                                ],
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Center(
                            child: RichText(
                                text: TextSpan(
                              text: "Go for",
                              children: [
                                TextSpan(
                                    text: " 50",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30)),
                                TextSpan(
                                  text: " WE",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                    text: " Coin!",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ],
                            )),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return Column(
                  children: [
                    Container(
                      height: size.height * 0.04,
                      width: size.width * 0.6,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Colors.lightGreenAccent,
                              Colors.green,
                            ],
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Center(
                        child: RichText(
                            text: TextSpan(
                          text: "Total WE Coins: ",
                          children: [
                            TextSpan(
                                text: coinsList.firstOrNull.toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20)),
                          ],
                        )),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    Container(
                      height: size.height * 0.06,
                      width: size.width * 0.9,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Colors.orangeAccent,
                              Colors.orange,
                            ],
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Center(
                        child: RichText(
                            text: TextSpan(
                          text: "Go for",
                          children: [
                            TextSpan(
                                text: " 50",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30)),
                            TextSpan(
                              text: " WE",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                                text: " Coin!",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                )),
                          ],
                        )),
                      ),
                    ),
                  ],
                );
              }),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: FutureBuilder<DocumentSnapshot>(
                future: users.doc(currentUid).get(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text("Something went wrong");
                  }
                  if (snapshot.connectionState == ConnectionState.done) {
                    Map<String, dynamic> data = snapshot.data.data();
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          if (data["coins"] > 500 && data["raffle2"] == false) {
                            updateCoins(data["coins"], 500, data["raffle1"],
                                true, data["raffle3"]);
                            popUp(
                                context,
                                "Your registration for the lottery has been successfully received. Remaining WE Coin: " +
                                    (data["coins"] - 500).toString(),
                                false);
                          } else {
                            popUp(
                                context,
                                "You don't have enough coins for this draw or you have already participated.",
                                true);
                          }
                        });
                      },
                      child: Container(
                        height: size.height * 0.06,
                        width: size.width * 0.9,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                Colors.redAccent,
                                Colors.red,
                              ],
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Center(
                          child: RichText(
                              text: TextSpan(
                            text: "Go for",
                            children: [
                              TextSpan(
                                  text: " 500",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30)),
                              TextSpan(
                                text: " WE",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                  text: " Coin!",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ],
                          )),
                        ),
                      ),
                    );
                  }
                  return Container(
                    height: size.height * 0.06,
                    width: size.width * 0.9,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Colors.redAccent,
                            Colors.red,
                          ],
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Center(
                      child: RichText(
                          text: TextSpan(
                        text: "Go for",
                        children: [
                          TextSpan(
                              text: " 500",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30)),
                          TextSpan(
                            text: " WE",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                              text: " Coin!",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              )),
                        ],
                      )),
                    ),
                  );
                }),
          ),
          FutureBuilder<DocumentSnapshot>(
              future: users.doc(currentUid).get(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text("Something went wrong");
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  Map<String, dynamic> data = snapshot.data.data();
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (data["coins"] > 5000 && data["raffle3"] == false) {
                          updateCoins(data["coins"], 5000, data["raffle1"],
                              data["raffle2"], true);
                          popUp(
                              context,
                              "Your registration for the lottery has been successfully received. Remaining WE Coin: " +
                                  (data["coins"] - 5000).toString(),
                              false);
                        } else {
                          popUp(
                              context,
                              "You don't have enough coins for this draw or you have already participated.",
                              true);
                        }
                      });
                    },
                    child: Container(
                      height: size.height * 0.06,
                      width: size.width * 0.9,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Colors.deepPurpleAccent,
                              Colors.deepPurple,
                            ],
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Center(
                        child: RichText(
                            text: TextSpan(
                          text: "Go for",
                          children: [
                            TextSpan(
                                text: " 5000",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30)),
                            TextSpan(
                              text: " WE",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                                text: " Coin!",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                )),
                          ],
                        )),
                      ),
                    ),
                  );
                }
                return Container(
                  height: size.height * 0.06,
                  width: size.width * 0.9,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Colors.deepPurpleAccent,
                          Colors.deepPurple,
                        ],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Center(
                    child: RichText(
                        text: TextSpan(
                      text: "Go for",
                      children: [
                        TextSpan(
                            text: " 5000",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 30)),
                        TextSpan(
                          text: " WE",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                            text: " Coin!",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            )),
                      ],
                    )),
                  ),
                );
              }),
        ],
      ),
    );
  }
}
