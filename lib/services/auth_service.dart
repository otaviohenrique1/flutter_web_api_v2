import 'package:flutter_web_api_v2/services/http_interceptors.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/http.dart';

class AuthService {
  //TODO: Modularizar o endpoint
  static const String uri = "http://192.168.0.10:3000/";

  http.Client client =
      InterceptedClient.build(interceptors: [LoggingInterceptor()]);

  login() {}

  register() {}
}
