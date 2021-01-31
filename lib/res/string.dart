import 'package:flutter_stream/secrets.dart';

// API for sending videos
const muxBaseUrl = 'https://api.mux.com';

// API for generating thumbnails of a video
const muxImageBaseUrl = 'https://image.mux.com';

// API for streaming a video
const muxStreamBaseUrl = 'https://stream.mux.com';

// Received video file format
const videoExtension = 'm3u8';

// Thumbnail file type and size
const imageTypeSize = 'thumbnail.jpg?time=5&width=200';

// Content Type used in API calls
const contentType = 'application/json';

// Access token in corrent format
const authToken = '$accessTokenMUX:$secretTokenMUX';

// Test video url provided by MUX
const demoVideoUrl =
    'https://storage.googleapis.com/muxdemofiles/mux-video-intro.mp4';

// Specifying plynback policy to public
const playbackPolicy = 'public';
