import 'package:flutter/material.dart';
import 'package:flutter_stream/model/video_data.dart';
import 'package:flutter_stream/utils/mux_client.dart';
import 'package:video_player/video_player.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MUXClient _muxClient = MUXClient();
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        'https://stream.mux.com/rs015pF71Llnoyn02XiN9VdzIF2Zeuj5YkQp2ygYZYsFc.m3u8')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    _controller.play();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(),
          RaisedButton(
            child: Text('post video'),
            onPressed: () async {
              _muxClient.initializeDio();
              // await _muxClient.storeVideo();

              VideoData videoData = await _muxClient.storeVideo();

              print(
                  'VIDEO ID: ${videoData.data.id}\nStatus: ${videoData.data.status}\nPlaybackIDs: ${videoData.data.playbackIds[0].id}');
            },
          ),
          Center(
            child: _controller.value.initialized
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  )
                : Container(),
          ),

          // StreamBuilder(
          //   stream: _muxClient.channel.stream,
          //   builder: (context, snapshot) {
          //     if (snapshot.hasData) {
          //       print(snapshot.data);
          //       return Container();
          //     }
          //     return Container();
          //   },
          // )
        ],
      ),
    );
  }
}
