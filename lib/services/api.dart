import 'dart:convert';
import 'package:http/http.dart';
import 'package:search_invocador/models/summoner.dart';

final String url = 'http://192.168.0.37:8080/';

// ignore: missing_return
Future<Summoner> fetchSummoner(String name) async {
  final String finalUrl = url + name;

  final response = await get(finalUrl);
  if (response.statusCode == 200) {
    var data = json.decode(response.body);

    Summoner s = Summoner.fromJson(data);

    return s;
  } else {
    throw Exception('Failed to load summoner');
  }
}
