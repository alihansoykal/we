import 'package:WE/Resources/SizeConfig.dart';
import 'package:WE/Resources/constants.dart';
import 'package:WE/Screens/BottomNavigation/Leaderboard/Tabs/global.dart';
import 'package:WE/Screens/ProfileDrawer/Profile/user_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FriendsTab extends StatelessWidget {
  var firebaseUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
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
                backgroundColor: kSecondaryColor,
                body: ListView.builder(
                  itemCount: data["friends"].length,
                  itemBuilder: (context, index) {
                    return Card(
                        child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return HerProfile();
                            },
                          ),
                        );
                      },
                      trailing: Container(
                        height: 7 * SizeConfig.heightMultiplier,
                        width: 12 * SizeConfig.widthMultiplier,
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                  leaderboardIcons[index],
                                ))),
                      ),
                      leading: Container(
                        height: 7 * SizeConfig.heightMultiplier,
                        width: 12 * SizeConfig.widthMultiplier,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(imagesPeople[index]))),
                      ),
                      title: Text(data["friends"][index]),
                    ));
                  },
                ));
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}

final imagesPeople = [
  "assets/Images/People/larryPage.png",
  "assets/Images/People/alihan.png",
  "assets/Images/People/aysu.png",
  "assets/Images/People/sundarPichai.png",
];
