import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter_postalcodes/model/PostOffice.dart';

Future<List<PostOffice>> loadPostOffices() async {
  final response = await http.get('https://api.postalpincode.in/postoffice/New Delhi');
  if (response.statusCode == 200) {
    final responseBody = json.decode(response.body);
//    print(responseBody);
    Iterable list = responseBody[0]['PostOffice'];
    return list.map((po) => PostOffice.fromJson(po)).toList();
  } else {
    throw Exception('Failed to load post offices');
  }
}