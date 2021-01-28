import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_stream/res/string.dart';
import 'package:flutter_stream/secrets.dart';

class MUXClient {
  // initializeDio() {
  //   BaseOptions options = BaseOptions(
  //     baseUrl: muxBaseUrl, // https://api.mux.com
  //     connectTimeout: 5000,
  //     receiveTimeout: 3000,
  //     headers: {
  //       "Content-Type": contentType, // application/json
  //       "Authorization": 'Basic $authToken', // in the format {MUX_TOKEN_ID}:{MUX_TOKEN_SECRET}
  //     },
  //   );

  //   _dio = Dio(options);
  // }

  storeVideo() async {
    Dio dio = Dio();

    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$authToken'));
    print(basicAuth);

    BaseOptions options = BaseOptions(
      baseUrl: muxBaseUrl, // https://api.mux.com
      connectTimeout: 5000,
      receiveTimeout: 3000,
      headers: {
        "Content-Type": contentType, // application/json
        "authorization":
            basicAuth, // in the format "Basic encoded({MUX_TOKEN_ID}:{MUX_TOKEN_SECRET})"
      },
    );
    dio = Dio(options);

    try {
      Response response = await dio.post(
        "/video/v1/assets",
        data: {
          "input": demoVideoUrl,
          "playback_policy": 'public',
        },
      );

      print(response.statusCode);
      print(response.data);

      // if (response.statusCode == 200) {
      //   print(response.data);
      // }
    } catch (e) {
      print('Error starting build: $e');
    }
  }
}
