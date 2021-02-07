import 'package:flutter/material.dart';
import 'package:flutter_stream/model/common/data.dart';

import 'package:flutter_stream/res/custom_colors.dart';
import 'package:flutter_stream/widgets/info_tile.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';

import '../res/string.dart';

class PreviewPage extends StatefulWidget {
  final Data assetData;

  const PreviewPage({@required this.assetData});

  @override
  _PreviewPageState createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  VideoPlayerController _controller;
  Data assetData;
  String dateTimeString;

  @override
  void initState() {
    super.initState();

    assetData = widget.assetData;
    String playbackId = assetData.playbackIds[0].id;

    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(int.parse(assetData.createdAt) * 1000);
    DateFormat formatter = DateFormat.yMd().add_jm();
    dateTimeString = formatter.format(dateTime);

    _controller = VideoPlayerController.network('$muxStreamBaseUrl/$playbackId.$videoExtension')
      ..initialize().then((_) {
        setState(() {});
      });

    _controller.play();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.dark,
        title: Text('Video preview'),
        backgroundColor: CustomColors.muxPink,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Container(
                    color: Colors.black,
                    width: double.maxFinite,
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          CustomColors.muxPink,
                        ),
                        strokeWidth: 2,
                      ),
                    ),
                  ),
                ),
                _controller.value.initialized
                    ? AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: VideoPlayer(_controller),
                      )
                    : AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Container(
                          color: Colors.black,
                          width: double.maxFinite,
                          child: Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                CustomColors.muxPink,
                              ),
                              strokeWidth: 2,
                            ),
                          ),
                        ),
                      ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InfoTile(
                    name: 'Asset ID',
                    data: assetData.id,
                  ),
                  InfoTile(
                    name: 'Created',
                    data: dateTimeString,
                  ),
                  InfoTile(
                    name: 'Status',
                    data: assetData.status,
                  ),
                  InfoTile(
                    name: 'Duration',
                    data: '${assetData.duration.toStringAsFixed(2)} seconds',
                  ),
                  InfoTile(
                    name: 'Max Resolution',
                    data: assetData.maxStoredResolution,
                  ),
                  InfoTile(
                    name: 'Max Frame Rate',
                    data: assetData.maxStoredFrameRate.toString(),
                  ),
                  InfoTile(
                    name: 'Aspect Ratio',
                    data: assetData.aspectRatio,
                  ),
                  SizedBox(height: 8.0),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
