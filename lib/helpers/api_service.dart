import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart';

class ApiService extends GetConnect {
  static Future<Map<String, dynamic>> getCep(String cep) async {
    final response =
        await get(Uri.parse("https://viacep.com.br/ws/$cep/json/"));
    final cepInfo = jsonDecode(response.body);
    return cepInfo;
  }

  static Future<List> getState() async {
    final response =
        await get(Uri.parse(""));
    log(response.body);
    final Map result = (jsonDecode(response.body));
    return [];
  }
}
