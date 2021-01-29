import 'package:flutter_stream/secrets.dart';

const muxBaseUrl = 'https://api.mux.com';
const muxImageBaseUrl = 'https://image.mux.com';
const muxStreamBaseUrl = 'https://stream.mux.com';
const videoExtension = 'm3u8';
const imageTypeSize = 'thumbnail.jpg?time=5&width=200';
const contentType = 'application/json';
const authToken = '$accessTokenMUX:$secretTokenMUX';
const demoVideoUrl =
    'https://storage.googleapis.com/muxdemofiles/mux-video-intro.mp4';
// https://firebasestorage.googleapis.com/v0/b/sofia-8d800.appspot.com/o/videos%2Fdemo.mp4?alt=media&token=9f64d230-2553-47f2-9c26-e217f8671e30
const playbackPolicy = 'public';
