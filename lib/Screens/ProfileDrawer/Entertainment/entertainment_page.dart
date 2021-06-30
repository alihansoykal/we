import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:WE/Resources/components/pop_up.dart';

class EntertainmentPage extends StatelessWidget {
  final List<String> imgList = [
    "assets/Images/Entertainment/didyouknowthese1.png",
    "assets/Images/Entertainment/didyouknowthese2.png",
    "assets/Images/Entertainment/didyouknowthese3.png",
    "assets/Images/Entertainment/didyouknowthese4.png",
    "assets/Images/Entertainment/didyouknowthese5.png",
    "assets/Images/Entertainment/didyouknowthese6.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Entertainment',
          style: TextStyle(fontFamily: "Panthera"),
        ),
        actions: [
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
                icon: Icon(Icons.share_rounded),
                onPressed: () {
                  popUp(context, false, "slm");
                }),
          ),
        ],
      ),
      body: Builder(
        builder: (context) {
          final double height = MediaQuery.of(context).size.height;
          return CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              height: height,
              viewportFraction: 1.0,
              enlargeCenterPage: false,
              // autoPlay: false,
            ),
            items: imgList
                .map((item) => Container(
                      child: Center(
                          child: Image.asset(
                            item,
                        fit: BoxFit.fill,
                        height: height,
                      )),
                    ))
                .toList(),
          );
        },
      ),
    );
  }
}
