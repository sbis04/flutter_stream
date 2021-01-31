import 'package:flutter/material.dart';
import 'package:flutter_stream/model/asset_data.dart';
import 'package:flutter_stream/res/custom_colors.dart';
import 'package:flutter_stream/screens/preview_page.dart';
import 'package:flutter_stream/utils/mux_client.dart';
import 'package:intl/intl.dart';

import '../res/string.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MUXClient _muxClient = MUXClient();
  // VideoPlayerController _controller;

  TextEditingController _textControllerVideoURL;
  FocusNode _textFocusNodeVideoURL;

  bool isProcessing = false;

  @override
  void initState() {
    super.initState();
    _muxClient.initializeDio();
    _textControllerVideoURL = TextEditingController(text: demoVideoUrl);
    _textFocusNodeVideoURL = FocusNode();
    // _controller = VideoPlayerController.network(
    //     'https://stream.mux.com/rs015pF71Llnoyn02XiN9VdzIF2Zeuj5YkQp2ygYZYsFc.m3u8')
    //   ..initialize().then((_) {
    //     // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
    //     setState(() {});
    //   });
    // _controller.play();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _textFocusNodeVideoURL.unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          brightness: Brightness.dark,
          title: Text('MUX stream'),
          backgroundColor: CustomColors.muxPink,
          actions: [
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                setState(() {});
              },
            ),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              color: CustomColors.muxPink.withOpacity(0.06),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 16.0,
                  left: 16.0,
                  right: 16.0,
                  bottom: 24.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'UPLOAD',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 22.0,
                      ),
                    ),
                    TextField(
                      focusNode: _textFocusNodeVideoURL,
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      style: TextStyle(
                        color: CustomColors.muxGray,
                        fontSize: 16.0,
                        letterSpacing: 1.5,
                      ),
                      controller: _textControllerVideoURL,
                      cursorColor: CustomColors.muxPinkLight,
                      autofocus: false,
                      // onTap: () {
                      //   setState(() {});
                      // },
                      // onChanged: (value) {
                      //   setState(() {
                      //     _isEditingFirstName = true;
                      //   });
                      // },
                      onSubmitted: (value) {
                        _textFocusNodeVideoURL.unfocus();
                      },
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: CustomColors.muxPink,
                            width: 2,
                          ),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black26,
                            width: 2,
                          ),
                        ),
                        labelText: 'Video URL',
                        labelStyle: TextStyle(
                          color: Colors.black26,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                        hintText: 'Enter the URL of the video to upload',
                        hintStyle: TextStyle(
                          color: Colors.black12,
                          fontSize: 12.0,
                          letterSpacing: 2,
                        ),
                        // errorText: _isEditingApiKey
                        //     ? _validateString(_textControllerApiKey.text)
                        //     : null,
                        // errorStyle: TextStyle(
                        //   fontSize: 12,
                        //   color: Colors.redAccent,
                        // ),
                      ),
                    ),
                    isProcessing
                        ? Padding(
                            padding: const EdgeInsets.only(top: 24.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Processing . . .',
                                  style: TextStyle(
                                    color: CustomColors.muxPink,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                                CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    CustomColors.muxPink,
                                  ),
                                  strokeWidth: 2,
                                )
                              ],
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(top: 24.0),
                            child: Container(
                              width: double.maxFinite,
                              child: RaisedButton(
                                color: CustomColors.muxPink,
                                onPressed: () async {
                                  setState(() {
                                    isProcessing = true;
                                  });
                                  await _muxClient.storeVideo();
                                  setState(() {
                                    isProcessing = false;
                                  });
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    top: 12.0,
                                    bottom: 12.0,
                                  ),
                                  child: Text(
                                    'send',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                      letterSpacing: 2,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder<AssetData>(
                future: _muxClient.getAssetList(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    AssetData assetData = snapshot.data;
                    int length = assetData.data.length;

                    return ListView.separated(
                      physics: BouncingScrollPhysics(),
                      itemCount: length,
                      itemBuilder: (context, index) {
                        DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
                            int.parse(assetData.data[index].createdAt) * 1000);
                        DateFormat formatter = DateFormat.yMd().add_jm();
                        String dateTimeString = formatter.format(dateTime);

                        String currentStatus = assetData.data[index].status;
                        bool isReady = currentStatus == 'ready';

                        String playbackId = isReady
                            ? assetData.data[index].playbackIds[0].id
                            : null;

                        String thumbnailURL = isReady
                            ? '$muxImageBaseUrl/$playbackId/$imageTypeSize'
                            : null;

                        return Padding(
                          padding: const EdgeInsets.only(
                            left: 16.0,
                            right: 16.0,
                            top: 8.0,
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => PreviewPage(
                                    assetData: assetData.data[index],
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: CustomColors.muxGray.withOpacity(0.1),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5.0),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: double.maxFinite,
                                    decoration: BoxDecoration(
                                      color:
                                          CustomColors.muxGray.withOpacity(0.8),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(5.0),
                                        topRight: Radius.circular(5.0),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 8.0,
                                        top: 8.0,
                                        bottom: 8.0,
                                      ),
                                      child: RichText(
                                        maxLines: 1,
                                        softWrap: false,
                                        overflow: TextOverflow.fade,
                                        text: TextSpan(
                                          text: 'ID: ',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.0,
                                          ),
                                          children: [
                                            TextSpan(
                                              text: assetData.data[0].id,
                                              style: TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.white70,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Flexible(
                                      //   child: AspectRatio(
                                      //     aspectRatio: 16 / 9,
                                      //     child: Container(
                                      //       width: 200,
                                      //       // height: 110,
                                      //       color: Colors.black87,
                                      //     ),
                                      //   ),
                                      // ),
                                      isReady
                                          ? Image.network(
                                              thumbnailURL,
                                              cacheWidth: 200,
                                              cacheHeight: 110,
                                            )
                                          : Flexible(
                                              child: AspectRatio(
                                                aspectRatio: 16 / 9,
                                                child: Container(
                                                  width: 200,
                                                  // height: 110,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                            ),
                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            left: 8.0,
                                            top: 8.0,
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              RichText(
                                                maxLines: 1,
                                                softWrap: false,
                                                overflow: TextOverflow.fade,
                                                text: TextSpan(
                                                  text: 'Duration: ',
                                                  style: TextStyle(
                                                    color: CustomColors.muxGray,
                                                    fontSize: 14.0,
                                                  ),
                                                  children: [
                                                    TextSpan(
                                                      text: assetData
                                                                  .data[index]
                                                                  .duration ==
                                                              null
                                                          ? 'N/A'
                                                          : assetData
                                                              .data[index]
                                                              .duration
                                                              .toStringAsFixed(
                                                                  2),
                                                      style: TextStyle(
                                                        // fontSize: 12.0,
                                                        color: CustomColors
                                                            .muxGray
                                                            .withOpacity(0.6),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: 4.0),
                                              RichText(
                                                maxLines: 1,
                                                softWrap: false,
                                                overflow: TextOverflow.fade,
                                                text: TextSpan(
                                                  text: 'Status: ',
                                                  style: TextStyle(
                                                    color: CustomColors.muxGray,
                                                    fontSize: 14.0,
                                                  ),
                                                  children: [
                                                    TextSpan(
                                                      text: assetData
                                                          .data[index].status,
                                                      style: TextStyle(
                                                        // fontSize: 12.0,
                                                        color: CustomColors
                                                            .muxGray
                                                            .withOpacity(0.6),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: 4.0),
                                              RichText(
                                                maxLines: 2,
                                                overflow: TextOverflow.fade,
                                                text: TextSpan(
                                                  text: 'Created at: ',
                                                  style: TextStyle(
                                                    color: CustomColors.muxGray,
                                                    fontSize: 14.0,
                                                  ),
                                                  children: [
                                                    TextSpan(
                                                      text: '\n$dateTimeString',
                                                      style: TextStyle(
                                                        // fontSize: 12.0,
                                                        color: CustomColors
                                                            .muxGray
                                                            .withOpacity(0.6),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (_, __) => SizedBox(
                        height: 16.0,
                      ),
                    );
                  }
                  return Container(
                    child: Text(
                      'No videos present',
                      style: TextStyle(
                        color: Colors.black45,
                      ),
                    ),
                  );
                },
              ),
            ),
            // RaisedButton(
            //   child: Text('post video'),
            //   onPressed: () async {
            //     _muxClient.initializeDio();
            //     // await _muxClient.storeVideo();

            //     VideoData videoData = await _muxClient.storeVideo();

            //     print(
            //         'VIDEO ID: ${videoData.data.id}\nStatus: ${videoData.data.status}\nPlaybackIDs: ${videoData.data.playbackIds[0].id}');
            //   },
            // ),

            // Center(
            //   child: _controller.value.initialized
            //       ? AspectRatio(
            //           aspectRatio: _controller.value.aspectRatio,
            //           child: VideoPlayer(_controller),
            //         )
            //       : Container(),
            // ),
          ],
        ),
      ),
    );
  }
}
