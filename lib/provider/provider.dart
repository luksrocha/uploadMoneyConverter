import 'dart:convert';
import 'package:flutter/material.dart';
import '../settings.dart';
import 'package:http/http.dart' as http;

Future<Map> getData() async{
  http.Response response = await http.get(apiUrl);
  return json.decode(response.body);
}