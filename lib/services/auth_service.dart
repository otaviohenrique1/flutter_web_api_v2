import 'dart:io';
import 'package:flutter_web_api_v2/services/http_interceptors.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/http.dart';

class AuthService {
  //TODO: Modularizar o endpoint
  static const String url = "http://192.168.0.10:3000/";

  http.Client client =
      InterceptedClient.build(interceptors: [LoggingInterceptor()]);

  login({
    required String email,
    required String password,
  }) async {
    http.Response response = await client.post(
      Uri.parse("${url}login"),
      body: {
        "email": email,
        "password": password,
      },
    );

    if (response.statusCode != 200) {
      throw HttpException(response.body);
    }
  }

  register() {}
}
