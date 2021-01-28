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
              VideoData videoData = await _muxClient.storeVideo();

              print('VIDEO ID: ${videoData.data.id}');
            },
          )
        ],
      ),
    );
  }
}
