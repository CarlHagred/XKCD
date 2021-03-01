import 'dart:convert';

import 'package:http/http.dart';
/*
class Api_manager {
  final String url = "http://xkcd.com/info.0.json";

  Future getComic() async {
    Response res = await get(url);

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      return body.
    }
  }
}*/

final String url = "http://xkcd.com/info.0.json";

Future getComic() async {
  Response res = await get(url);

  if (res.statusCode == 200) {
    List<dynamic> body = jsonDecode(res.body);
    print(res.body);
  }
}
