import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xkcd/api_manager.dart';

String url;

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
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => ComicPage()));
              },
              textColor: Colors.black,
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'This weeks',
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

class ComicPage extends StatefulWidget {
  @override
  _ComicPageState createState() => _ComicPageState();
}

class _ComicPageState extends State<ComicPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: new FutureBuilder(
            future: getPics(),
            builder: (context, snapShot) {
              Map data = snapShot.data;
              if (snapShot.hasError) {
                print(snapShot.error);
                return Text('Error');
              } else if (snapShot.hasData) {
                return new Center(
                  child: PageView(
                    children: <Widget>[
                      new Container(
                        child: new InkWell(
                          onTap: () {},
                          child: Image.network('${data['img']}'),
                        ),
                      ),
                      RaisedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => Page1()));
                        },
                        textColor: Colors.black,
                        padding: EdgeInsets.all(0.0),
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            'Return to main screen',
                            style: TextStyle(
                                fontSize: 20, fontFamily: 'ShadowsIntoLight'),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return new Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }
}

Future<Map> getPics() async {
  String URL = 'http://xkcd.com/info.0.json';
  http.Response response = await http.get(URL);
  return json.decode(response.body);
}
/*
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
              child: Image.network(url),
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

 */
