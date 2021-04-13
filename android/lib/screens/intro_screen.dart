
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

import '../home_page.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
    children: <Widget>[
      SplashScreen(
        seconds: 3,
        backgroundColor: Color(0xFFEC1D24),
        navigateAfterSeconds: HomePage(),
        loaderColor: Colors.blue,
      ),
      Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Image.asset('images/logo_marvel.png', scale: 30),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white)
                ),
              ),
              Padding(padding: EdgeInsets.all(5)),
              Material(
                color: Colors.transparent,
                child: Text("Comic Geek Shopping", style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold
                )),
              )
            ],
          ),
        ),
      ), 
      
      
    ],
  );
  }
}