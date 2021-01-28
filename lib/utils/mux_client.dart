import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_stream/model/video_data.dart';
import 'package:flutter_stream/res/string.dart';
// import 'package:web_socket_channel/io.dart';
// import 'package:web_socket_channel/status.dart' as status;

import '../res/string.dart';
import '../res/string.dart';

class MUXClient {
  Dio _dio = Dio();

  // String _cookie;
  // var channel = IOWebSocketChannel.connect(Uri.parse(
  //     'ws://@$muxBaseUrl/video/v1/assets/Nh3DrtRN4j01T1cwmMdArqgUkYqJxdg402Au4qwL00idi00'));

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
    Response response;

    try {
      response = await _dio.post(
        "/video/v1/assets",
        data: {
          "input": demoVideoUrl,
          "playback_policy": playbackPolicy,
        },
      );
    } catch (e) {
      print('Error starting build: $e');
    }

    if (response.statusCode == 201) {
      VideoData videoData = VideoData.fromJson(response.data);

      String status = videoData.data.status;

      print(status);

      while (status == 'preparing') {
        print('check');
        await Future.delayed(Duration(seconds: 1));
        videoData = await checkPostStatus(videoId: videoData.data.id);
        status = videoData.data.status;
      }

      // print('Video READY, id: ${videoData.data.id}');

      return videoData;
    }

    return null;
  }

  Future<VideoData> checkPostStatus({String videoId}) async {
    try {
      Response response = await _dio.get(
        "/video/v1/assets/$videoId",
      );

      // print(response.data);

      if (response.statusCode == 200) {
        VideoData videoData = VideoData.fromJson(response.data);

        return videoData;
      }
    } catch (e) {
      print('Error starting build: $e');
    }

    return null;
  }

  // Future<Stream<dynamic>> _positionsStream(
  //     {String serverUrl,
  //     String email,
  //     String password,
  //     String protocol = "http"}) async {
  //   if (_cookie == null) {
  //     await _getConnection(email: _email, password: _password);
  //   }
  //   final channel = IOWebSocketChannel.connect("ws://$serverUrl/api/socket",
  //       headers: <String, dynamic>{"Cookie": _cookie});
  //   return channel.stream;
  // }
}
