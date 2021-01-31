import 'package:flutter/material.dart';
import 'package:flutter_stream/model/common/data.dart';
import 'package:flutter_stream/res/custom_colors.dart';
import 'package:flutter_stream/screens/preview_page.dart';

class VideoTile extends StatelessWidget {
  final Data assetData;
  final String thumbnailUrl;
  final String dateTimeString;
  final bool isReady;

  VideoTile({
    @required this.assetData,
    @required this.thumbnailUrl,
    @required this.dateTimeString,
    @required this.isReady,
  });

  @override
  Widget build(BuildContext context) {
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
                assetData: assetData,
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
                  color: CustomColors.muxGray.withOpacity(0.8),
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
                          text: assetData.id,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  isReady
                      ? Image.network(
                          thumbnailUrl,
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
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                  text: assetData.duration == null
                                      ? 'N/A'
                                      : assetData.duration.toStringAsFixed(2),
                                  style: TextStyle(
                                    // fontSize: 12.0,
                                    color:
                                        CustomColors.muxGray.withOpacity(0.6),
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
                                  text: assetData.status,
                                  style: TextStyle(
                                    // fontSize: 12.0,
                                    color:
                                        CustomColors.muxGray.withOpacity(0.6),
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
                                    color:
                                        CustomColors.muxGray.withOpacity(0.6),
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
  }
}
