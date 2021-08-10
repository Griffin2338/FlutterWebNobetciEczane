import 'dart:async';
import 'package:http/http.dart' as http;

class EczaneApi {
  static Future getCharacters() {
    return http.get(Uri.parse("https://www.netdata.com/JSON/a40cee7b"));

  }
}
