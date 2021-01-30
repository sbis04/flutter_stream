import 'package:flutter/material.dart';
import 'package:flutter_stream/model/asset_data/datum.dart';
import 'package:flutter_stream/res/custom_colors.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';

import '../res/string.dart';

class PreviewPage extends StatefulWidget {
  final Datum assetData;

  const PreviewPage({@required this.assetData});

  @override
  _PreviewPageState createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  VideoPlayerController _controller;
  Datum assetData;
  String dateTimeString;

  @override
  void initState() {
    super.initState();

    assetData = widget.assetData;
    String playbackId = assetData.playbackIds[0].id;

    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
        int.parse(assetData.createdAt) * 1000);
    DateFormat formatter = DateFormat.yMd().add_jm();
    dateTimeString = formatter.format(dateTime);

    _controller = VideoPlayerController.network(
        '$muxStreamBaseUrl/$playbackId.$videoExtension')
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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Asset ID',
                    style: TextStyle(
                      color: CustomColors.muxGray,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    assetData.id,
                    style: TextStyle(
                      color: CustomColors.muxGray.withOpacity(0.6),
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Container(
                    color: CustomColors.muxGray.withOpacity(0.1),
                    width: double.maxFinite,
                    height: 1,
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Created',
                    style: TextStyle(
                      color: CustomColors.muxGray,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    dateTimeString,
                    style: TextStyle(
                      color: CustomColors.muxGray.withOpacity(0.6),
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Container(
                    color: CustomColors.muxGray.withOpacity(0.1),
                    width: double.maxFinite,
                    height: 1,
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Status',
                    style: TextStyle(
                      color: CustomColors.muxGray,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    assetData.status,
                    style: TextStyle(
                      color: CustomColors.muxGray.withOpacity(0.6),
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Container(
                    color: CustomColors.muxGray.withOpacity(0.1),
                    width: double.maxFinite,
                    height: 1,
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Duration',
                    style: TextStyle(
                      color: CustomColors.muxGray,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    '${assetData.duration.toStringAsFixed(2)} seconds',
                    style: TextStyle(
                      color: CustomColors.muxGray.withOpacity(0.6),
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Container(
                    color: CustomColors.muxGray.withOpacity(0.1),
                    width: double.maxFinite,
                    height: 1,
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Max Resolution',
                    style: TextStyle(
                      color: CustomColors.muxGray,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    assetData.maxStoredResolution,
                    style: TextStyle(
                      color: CustomColors.muxGray.withOpacity(0.6),
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Container(
                    color: CustomColors.muxGray.withOpacity(0.1),
                    width: double.maxFinite,
                    height: 1,
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Max Frame Rate',
                    style: TextStyle(
                      color: CustomColors.muxGray,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    assetData.maxStoredFrameRate.toString(),
                    style: TextStyle(
                      color: CustomColors.muxGray.withOpacity(0.6),
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Container(
                    color: CustomColors.muxGray.withOpacity(0.1),
                    width: double.maxFinite,
                    height: 1,
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Aspect Ratio',
                    style: TextStyle(
                      color: CustomColors.muxGray,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    assetData.aspectRatio,
                    style: TextStyle(
                      color: CustomColors.muxGray.withOpacity(0.6),
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 16.0),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
