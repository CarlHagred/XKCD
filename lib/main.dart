import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

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
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.black12,
                ),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ComicPage()));
                },
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'Current Comic',
                    style: TextStyle(
                      fontSize: 40,
                      fontFamily: 'ShadowsIntoLight',
                      color: Colors.black54,
                    ),
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
            future: getPics('https://xkcd.now.sh/?comic=latest'),
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
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => HomePage()));
                        },
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            'Return to main screen',
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'ShadowsIntoLight',
                              color: Colors.black87,
                            ),
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

Future<Map> getPics(String url) async {
  Uri uri = Uri.parse(url);
  http.Response response = await http.get(uri);
  return json.decode(response.body);
}
