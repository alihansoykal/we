import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:WE/Resources/components/or_divider.dart';
import '../../../Resources/components/social_icon.dart';
import '../../../Resources/constants.dart';

class CoinScreenExample extends StatefulWidget {
  @override
  _CoinScreenExampleState createState() => _CoinScreenExampleState();
}

class _CoinScreenExampleState extends State<CoinScreenExample> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
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
                                        " 144",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 24),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text("   72 g",
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
