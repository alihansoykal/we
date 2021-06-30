import 'package:WE/Screens/ProfileDrawer/Profile/edit_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:WE/Resources/constants.dart';
import 'package:WE/Resources/SizeConfig.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var firebaseUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return FutureBuilder<DocumentSnapshot>(
        future: users.doc(firebaseUser.uid).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data = snapshot.data.data();
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text(
                  "Profile Page",
                  style: TextStyle(fontFamily: "Panthera", fontSize: 30),
                ),
              ),
              backgroundColor: kSecondaryColor,
              body: Column(
                children: <Widget>[
                  Container(
                    color: kSecondaryColor,
                    height: 30 * SizeConfig.heightMultiplier,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 15.0,
                          right: 15.0,
                          top: 4 * SizeConfig.heightMultiplier),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              data["avatar"] != null
                                  ? Container(
                                      height: 11 * SizeConfig.heightMultiplier,
                                      width: 22 * SizeConfig.widthMultiplier,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  data["avatar"]))),
                                    )
                                  : Icon(
                                      Icons.account_circle_rounded,
                                      size: 120,
                                      color: Colors.grey,
                                    ),
                              SizedBox(
                                width: 6 * SizeConfig.widthMultiplier,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    data["name"],
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 3 * SizeConfig.textMultiplier,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 1 * SizeConfig.heightMultiplier,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Image.asset(
                                        "assets/Icons/supermanicon.png",
                                        scale: 0.2,
                                        color: Colors.white,
                                        height: 3 * SizeConfig.heightMultiplier,
                                        width: 3 * SizeConfig.widthMultiplier,
                                      ),
                                      SizedBox(
                                        width: 2 * SizeConfig.widthMultiplier,
                                      ),
                                      Text(
                                        data["superhero"],
                                        style: TextStyle(
                                          color: Colors.white60,
                                          fontSize:
                                              1.5 * SizeConfig.textMultiplier,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 3 * SizeConfig.heightMultiplier,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Text(
                                    data["coins"].toString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 3 * SizeConfig.textMultiplier,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Total coin",
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 1.5 * SizeConfig.textMultiplier,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Text(
                                    data["recycled"].toString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 3 * SizeConfig.textMultiplier,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "All-time recycled",
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 1.5 * SizeConfig.textMultiplier,
                                    ),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushAndRemoveUntil<dynamic>(
                                    context,
                                    MaterialPageRoute<dynamic>(
                                      builder: (BuildContext context) =>
                                          EditProfile(),
                                    ),
                                    (route) => false,
                                  );
                                  //getImage(true);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white60),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "EDIT PROFILE",
                                      style: TextStyle(
                                          color: Colors.white60,
                                          fontSize:
                                              1.8 * SizeConfig.textMultiplier),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment(0.5, 0.5),
                    child: Container(
                        color: kSecondaryColor,
                        padding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                        height: 300,
                        child: Column(
                          children: [
                            Row(
                              children: <Widget>[
                                Container(
                                    margin: EdgeInsets.only(right: 11),
                                    child: SizedBox(
                                        height: 200,
                                        width: 200,
                                        child: LiquidCircularProgressIndicator(
                                          value: data["exp"],
                                          valueColor: AlwaysStoppedAnimation(
                                              Colors.lightBlue[200]),
                                          backgroundColor: Colors.white,
                                          borderColor: kPrimaryColor,
                                          borderWidth: 5.0,
                                          direction: Axis.vertical,
                                          center: Text(
                                              "Level ${data['level'].toString()} "), //text inside it
                                        ))),
                                Column(
                                  children: [
                                    Text(
                                      "Recycled",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      "today:",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      data["dailyRecycled"].toString(),
                                      style: TextStyle(color: kPrimaryColor),
                                    ),
                                    SizedBox(
                                      height: 17,
                                    ),
                                    Text(
                                      "Coin earned",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      "today:",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      data["dailyCoins"].toString(),
                                      style: TextStyle(color: kPrimaryColor),
                                    ),
                                    SizedBox(height: size.height * 0.03),
                                    Text(
                                      "Your impact:",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Wrap(children: [
                                      Text(
                                        data["impact"][0],
                                        style: TextStyle(
                                            color: kPrimaryColor,
                                            fontSize: 13.2),
                                      ),
                                    ]),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        )),
                  ),
                ],
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
