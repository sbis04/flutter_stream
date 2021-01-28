import 'package:flutter/material.dart';
import 'package:flutter_stream/utils/mux_client.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MUXClient _muxClient = MUXClient();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RaisedButton(
          child: Text('post video'),
          onPressed: () async {
            // _muxClient.initializeDio();
            await _muxClient.storeVideo();
          },
        )
      ],
    );
  }
}
