import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';

class HttpService {
  static HttpService instance = HttpService.internal();
  HttpService.internal();
  factory HttpService() => instance;

  final LocalStorage storage = LocalStorage('agrovision');
  Map<String, String> headers = {};
  final JsonDecoder _decoder = const JsonDecoder();

  static const String baseUrlChatBot = 'https://chatbot-agrovision-ux6r5xau3q-uc.a.run.app';
  static const String baseUrlDetection = 'https://predict-ux6r5xau3q-et.a.run.app/';

  Future<dynamic> post(String desturl,
      {Map headers = const {},
      Map body = const {},
      dynamic encoding}) async {
    Map<String, String> requestHeaders = {
      "Content-type": "application/json",
      "Accept": "application/json",
    };
    try {
      http.Response response = await http.post(Uri.parse(desturl),
          body: json.encode(body), headers: requestHeaders, encoding: encoding);
      log("res ==============> $desturl == ${response.body}");
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400) {
        throw Exception("Error ${response.statusCode} while fetching endpoint $desturl");
      }

      return _decoder.convert(response.body);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<dynamic> get(String desturl, {Map<String, String> headers = const {}}) async {
    Map<String, String> requestHeaders = {
      "Content-type": "application/json",
      "Accept": "*/*",
    };
    try {
      http.Response response = await http.get(Uri.parse(desturl), headers: requestHeaders);
      log("res ==============> $desturl == ${response.body}");
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400) {
        throw Exception("Error ${response.statusCode} while fetching endpoint $desturl");
      }

      return _decoder.convert(response.body);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
