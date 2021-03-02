import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

String url;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
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
                    'Current Comic',
                    style:
                        TextStyle(fontSize: 40, fontFamily: 'ShadowsIntoLight'),
                  ),
                ),
              ),
            ],
          ),
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
            future: getPics('http://xkcd.com/info.0.json'),
            builder: (context, snapShot) {
              Map data = snapShot.data;
              if (snapShot.hasError) {
                print(snapShot.error);
                return Text('Error');
              } else if (snapShot.hasData) {
                return Center(
                  child: PageView(
                    children: <Widget>[
                       Container(
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: InkWell(
                            onTap: () {},
                            child: Image.network('${data['img']}'),
                          ),
                        ),
                      ),
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => HomePage()));
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
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }
}

Future<Map> getPics(String URL) async {
  http.Response response = await http.get(URL);
  return json.decode(response.body);
}

