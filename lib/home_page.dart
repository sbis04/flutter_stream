import 'package:flutter/material.dart';
import 'package:flutter_stream/model/video_data.dart';
import 'package:flutter_stream/utils/mux_client.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MUXClient _muxClient = MUXClient();

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
