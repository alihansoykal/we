import 'package:WE/Resources/SizeConfig.dart';
import 'package:WE/Resources/components/pop_up.dart';
import 'package:WE/Resources/constants.dart';
import 'package:WE/Services/ChatService/we_chat.dart';
import 'package:flutter/material.dart';

class HerProfile extends StatefulWidget {
  HerProfile({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HerProfileState createState() => _HerProfileState();
}

class _HerProfileState extends State<HerProfile> {
  bool _canShowButton = true;

  void hideWidget() {
    setState(() {
      _canShowButton = !_canShowButton;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Profile Page",
          style: TextStyle(fontFamily: "Panthera", fontSize: 24),
        ),
      ),
      backgroundColor: Color(0xffF8F8FA),
      body: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          Container(
            color: kSecondaryColor,
            child: Padding(
              padding: EdgeInsets.only(
                  left: 15.0,
                  right: 15.0,
                  top: 5 * SizeConfig.heightMultiplier),
              child: Column(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        height: 22 * SizeConfig.heightMultiplier,
                        width: 44 * SizeConfig.widthMultiplier,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                    "assets/Images/People/aysu.png"))),
                      ),
                      SizedBox(
                        height: 7 * SizeConfig.widthMultiplier,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Aysu Keçeci",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 6 * SizeConfig.textMultiplier,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 1 * SizeConfig.heightMultiplier,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5 * SizeConfig.heightMultiplier,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(
                            "Level 3",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 3 * SizeConfig.textMultiplier,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Wonder Woman",
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
                            "3.2K",
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
                            "166 g",
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
                    ],
                  ),
                  SizedBox(
                    height: 4 * SizeConfig.heightMultiplier,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 50,
                        width: 150,
                        decoration: BoxDecoration(
                          border: Border.all(color: kPrimaryColor),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.person_add_alt_1_rounded,
                                color: kPrimaryColor,
                              ),
                              SizedBox(width: 10),
                              Text(
                                "ADD FRIEND",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: kPrimaryColor,
                                    fontSize: 1.8 * SizeConfig.textMultiplier),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Container(
                        height: 50,
                        width: 120,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.whatshot,
                                color: Colors.white,
                              ),
                              SizedBox(width: 14),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return WeChat();
                                      },
                                    ),
                                  );
                                },
                                child: Text(
                                  "CHAT",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize:
                                          1.8 * SizeConfig.textMultiplier),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 4 * SizeConfig.heightMultiplier,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      !_canShowButton
                          ? const SizedBox.shrink()
                          : Container(
                              width: 80,
                              height: 80,
                              child: IconButton(
                                icon: Image.asset("assets/Icons/swords.png"),
                                onPressed: () {
                                  hideWidget();
                                  popUp(context, false,
                                      "You challenged Aysu. You can no longer see who won until you are in a duel. Have fun ...");

                                  //_number();
                                },
                              ),
                            ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
