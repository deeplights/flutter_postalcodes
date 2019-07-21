import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter_postalcodes/model/PostOffice.dart';

Future<List<PostOffice>> loadPostOffices(String postOffice) async {
  String requestURL = 'https://api.postalpincode.in/postoffice/$postOffice';
  print(requestURL);
  final response = await http.get(requestURL);
  if (response.statusCode == 200) {
    final responseBody = json.decode(response.body);
    print(responseBody);
    Iterable list = responseBody[0]['PostOffice'];
    return list.map((po) => PostOffice.fromJson(po)).toList();
  } else {
    throw Exception('Failed to load post offices');
  }
}

Future<List<PostOffice>> loadPinCodes(String pinCode) async {
  String requestURL = 'https://api.postalpincode.in/pincode/$pinCode';
  print(requestURL);
  final response = await http.get(requestURL);
  if (response.statusCode == 200) {
    final responseBody = json.decode(response.body);
    print(responseBody);
    Iterable list = responseBody[0]['PostOffice'];
    return list.map((po) => PostOffice.fromJson(po)).toList();
  } else {
    throw Exception('Failed to load post offices');
  }
}