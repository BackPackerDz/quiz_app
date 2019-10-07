import 'package:flutter/material.dart';

import 'FlagsScreen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: Container(
        padding: EdgeInsets.only(bottom: 130),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Text(
                'QuizzApp',
                style: TextStyle(
                    fontFamily: 'Signatra', fontSize: 100, color: Colors.white),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            CustomButton(
                textButton: 'Capitales',
                onPressed: () {
                  print('Tu as cliqué sur le bouton capitales');
                }),
            SizedBox(
              height: 20.0,
            ),
            CustomButton(
              textButton: 'Drapeaux',
              onPressed: () {
                print('Tu as cliqué sur le bouton drapeaux');
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FlagsScreen()),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String textButton;
  final Function onPressed;

  CustomButton({this.textButton, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 40, right: 40),
      child: RaisedButton(
        onPressed: onPressed,
        padding: EdgeInsets.all(20.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: Text(
          textButton,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
