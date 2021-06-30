import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final firestoreInstance = FirebaseFirestore.instance;
final currentUid = FirebaseAuth.instance.currentUser.uid;

void signUp(
    {String name,
    String password,
    String email,
    String city,
    String superhero,
    int level,
    double exp,
    int coins,
    int dailyCoins,
    int dailyRecycled,
    List<String> impact,
    List<String> friends,
    String avatar,
    int recycled}) {
  firestoreInstance.collection("users").doc(currentUid).set({
    "name": name,
    "password": password,
    "email": email,
    "city": city,
    "exp": 0.1,
    "superhero": superhero,
    "level": 1,
    "coins": 0,
    "dailyCoins": 0,
    "dailyRecycled": 0,
    "recycled": 0,
    "avatar": null,
    "friends": ["Larry Page", "Alihan Soykal", "Aysu Keçeci", "Sundar Pichai"],
    "impact": ["Nothing", "2-hour bulb energy", "2 fish", "2kWh energy"]
  });
}

