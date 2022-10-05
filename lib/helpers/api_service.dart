import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart';

class ApiService extends GetConnect{
  static Future<Map<String,dynamic>> getCep(String cep) async{
    final response = await get(Uri.parse("https://viacep.com.br/ws/$cep/json/"));
    final cepInfo = jsonDecode(response.body);
    return cepInfo;
  }
}