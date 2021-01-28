import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_stream/model/video_data.dart';
import 'package:flutter_stream/res/string.dart';
import 'package:flutter_stream/secrets.dart';

class MUXClient {
  Dio _dio = Dio();

  initializeDio() {
    // authToken format: {MUX_TOKEN_ID}:{MUX_TOKEN_SECRET}
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$authToken'));

    BaseOptions options = BaseOptions(
      baseUrl: muxBaseUrl, // https://api.mux.com
      connectTimeout: 5000,
      receiveTimeout: 3000,
      headers: {
        "Content-Type": contentType, // application/json
        "authorization": basicAuth,
      },
    );
    _dio = Dio(options);
  }

  storeVideo() async {
    try {
      Response response = await _dio.post(
        "/video/v1/assets",
        data: {
          "input": demoVideoUrl,
          "playback_policy": playbackPolicy,
        },
      );

      if (response.statusCode == 201) {
        VideoData videoData = VideoData.fromJson(response.data);

        return videoData;
      }
    } catch (e) {
      print('Error starting build: $e');
    }

    return null;
  }
}
