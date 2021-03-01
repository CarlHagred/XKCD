import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xkcd/api_manager.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: Page1(),
    );
  }
}

class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(color: Colors.white),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'XKCD',
              style: TextStyle(
                color: Colors.black,
                fontSize: 120,
                fontFamily: 'ShadowsIntoLight',
                fontWeight: FontWeight.bold,
              ),
            ),
            RaisedButton(
              onPressed: () {
                Api_manager().getComic();
                /*
                Navigator.of(context)
                    .push(
                    MaterialPageRoute(
                        builder: (context) => Page2()
                    )
                );
                */
              },
              textColor: Colors.black,
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Exposure Models',
                  style:
                      TextStyle(fontSize: 40, fontFamily: 'ShadowsIntoLight'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(color: Colors.white),
      child: SafeArea(
        child: PageView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(84),
              child: Image(
                image: AssetImage(
                  'images/first.png',
                ),
                fit: BoxFit.fitWidth,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(32),
              child: Image(
                image: AssetImage(
                  'images/second.png',
                ),
                fit: BoxFit.fitWidth,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(30),
              child: Image(
                image: AssetImage(
                  'images/third.png',
                ),
                fit: BoxFit.fitWidth,
              ),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Page1()));
              },
              textColor: Colors.black,
              padding: EdgeInsets.all(0.0),
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Return to main screen',
                  style:
                      TextStyle(fontSize: 20, fontFamily: 'ShadowsIntoLight'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
