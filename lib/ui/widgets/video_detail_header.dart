import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:nexthour/common/apipath.dart';
import 'package:nexthour/common/global.dart';
import 'package:nexthour/common/route_paths.dart';
import 'package:nexthour/models/datum.dart';
import 'package:nexthour/models/episode.dart';
import 'package:nexthour/player/iframe_player.dart';
import 'package:nexthour/player/m_player.dart';
import 'package:nexthour/player/player.dart';
import 'package:nexthour/player/playerMovieTrailer.dart';
import 'package:nexthour/player/trailer_cus_player.dart';
import 'package:nexthour/providers/user_profile_provider.dart';
import 'package:nexthour/ui/widgets/video_header_diagonal.dart';
import 'package:nexthour/ui/widgets/video_item_box.dart';
import 'package:nexthour/ui/widgets/video_rating.dart';
import 'package:provider/provider.dart';

class VideoDetailHeader extends StatefulWidget {
  VideoDetailHeader(this.videoDetail);

  final Datum videoDetail;

  @override
  VideoDetailHeaderState createState() => VideoDetailHeaderState();
}

class VideoDetailHeaderState extends State<VideoDetailHeader>
    with WidgetsBindingObserver {
  var dMsg = '';
  var hdUrl;
  var sdUrl;
  var mReadyUrl,
      mIFrameUrl,
      mUrl360,
      mUrl480,
      mUrl720,
      mUrl1080,
      youtubeUrl,
      vimeoUrl;

  getAllScreens(mVideoUrl, type) async {
    if (type == "CUSTOM") {
      addHistory(widget.videoDetail.type, widget.videoDetail.id);
      var router = new MaterialPageRoute(
          builder: (BuildContext context) => new MyCustomPlayer(
                url: mVideoUrl,
                title: widget.videoDetail.title,
                downloadStatus: 1,
              ));
      Navigator.of(context).push(router);
    } else if (type == "EMD") {
      addHistory(widget.videoDetail.type, widget.videoDetail.id);
      var router = new MaterialPageRoute(
          builder: (BuildContext context) => IFramePlayerPage(url: mVideoUrl));
      Navigator.of(context).push(router);
    } else if (type == "JS") {
      addHistory(widget.videoDetail.type, widget.videoDetail.id);
      var router = new MaterialPageRoute(
        builder: (BuildContext context) => PlayerMovie(
            id: widget.videoDetail.id, type: widget.videoDetail.type),
      );
      Navigator.of(context).push(router);
    }
  }

  Future<String> addHistory(vType, id) async {
    var type = vType == DatumType.M ? "M" : "T";
    final response = await http.get("${APIData.addWatchHistory}/$type/$id",
        headers: {HttpHeaders.authorizationHeader: "Bearer $authToken"});
    if (response.statusCode == 200) {
    } else {
      throw "can't added to history";
    }
    return null;
  }

  void _showMsg() {
    var userDetails = Provider.of<UserProfileProvider>(context, listen: false)
        .userProfileModel;
    if (userDetails.paypal.length == 0 ||
        userDetails.user.subscriptions == null ||
        userDetails.user.subscriptions.length == 0) {
      dMsg = "Watch unlimited movies, TV shows and videos in HD or SD quality."
          " You don't have subscribe.";
    } else {
      dMsg = "Watch unlimited movies, TV shows and videos in HD or SD quality."
          " You don't have any active subscription plan.";
    }
    // set up the button
    Widget cancelButton = FlatButton(
      child: Text(
        "Cancel",
        style: TextStyle(color: activeDotColor, fontSize: 16.0),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    Widget subscribeButton = FlatButton(
      child: Text(
        "Subscribe",
        style: TextStyle(color: activeDotColor, fontSize: 16.0),
      ),
      onPressed: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, RoutePaths.subscriptionPlans);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      contentPadding:
          EdgeInsets.only(top: 10.0, left: 16.0, right: 16.0, bottom: 0.0),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Subscribe Plans",
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
      content: Row(
        children: <Widget>[
          Flexible(
            flex: 1,
            fit: FlexFit.loose,
            child: Text(
              "$dMsg",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
      actions: [
        subscribeButton,
        cancelButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void _onTapPlay() {
    if (widget.videoDetail.type == DatumType.T) {
      if (widget.videoDetail.seasons.length != 0 &&
          widget.videoDetail.seasons[0].episodes.length != 0) {
        var url1 = widget.videoDetail.seasons[0].episodes[0].videoLink.readyUrl;
        var url2 =
            widget.videoDetail.seasons[0].episodes[0].videoLink.iframeurl;
        if (url1 != null) {
          var router = new MaterialPageRoute(
              builder: (BuildContext context) => new MyCustomPlayer(
                    url: url1,
                    title: widget.videoDetail.seasons[0].episodes[0].title,
                    downloadStatus: 1,
                  ));
          Navigator.of(context).push(router);
        } else {
          var router = new MaterialPageRoute(
              builder: (BuildContext context) => IFramePlayerPage(url: url2));
          Navigator.of(context).push(router);
        }
      } else {
        return;
      }
    } else {
      var videoLink = widget.videoDetail.videoLink;
      mIFrameUrl = videoLink.iframeurl;
      print("Iframe: $mIFrameUrl");
      mReadyUrl = videoLink.readyUrl;
      print("Ready Url: $mReadyUrl");
      mUrl360 = videoLink.url360;
      print("Url 360: $mUrl360");
      mUrl480 = videoLink.url480;
      print("Url 480: $mUrl480");
      mUrl720 = videoLink.url720;
      print("Url 720: $mUrl720");
      mUrl1080 = videoLink.url1080;
      print("Url 1080: $mUrl1080");
      if (mIFrameUrl == null &&
          mReadyUrl == null &&
          mUrl360 == null &&
          mUrl480 == null &&
          mUrl720 == null &&
          mUrl1080 == null) {
        Fluttertoast.showToast(msg: "Video not available");
      } else {
        if (mUrl360 != null ||
            mUrl480 != null ||
            mUrl720 != null ||
            mUrl1080 != null) {
          _showQualityDialog(mUrl360, mUrl480, mUrl720, mUrl1080);
        } else {
          if (mIFrameUrl != null) {
            var matchIFrameUrl = mIFrameUrl.substring(0, 24);
            if (matchIFrameUrl == 'https://drive.google.com') {
              var ind = mIFrameUrl.lastIndexOf('d/');
              var t = "$mIFrameUrl".trim().substring(ind + 2);
              var rep = t.replaceAll('/preview', '');
              var newurl =
                  "https://www.googleapis.com/drive/v3/files/$rep?alt=media&key=${APIData.googleDriveApi}";
              getAllScreens(newurl, "CUSTOM");
            } else {
              var router = new MaterialPageRoute(
                  builder: (BuildContext context) =>
                      IFramePlayerPage(url: mIFrameUrl));
              Navigator.of(context).push(router);
            }
          } else if (mReadyUrl != null) {
            var matchUrl = mReadyUrl.substring(0, 23);
            var checkMp4 = mReadyUrl.substring(mReadyUrl.length - 4);
            var checkMpd = mReadyUrl.substring(mReadyUrl.length - 4);
            var checkWebm = mReadyUrl.substring(mReadyUrl.length - 5);
            var checkMkv = mReadyUrl.substring(mReadyUrl.length - 4);
            var checkM3u8 = mReadyUrl.substring(mReadyUrl.length - 5);

            if (matchUrl.substring(0, 18) == "https://vimeo.com/") {
              var router = new MaterialPageRoute(
                builder: (BuildContext context) => PlayerMovie(
                    id: widget.videoDetail.id, type: widget.videoDetail.type),
              );
              Navigator.of(context).push(router);
            } else if (matchUrl == 'https://www.youtube.com/embed') {
              var url = '$mReadyUrl';
              var router = new MaterialPageRoute(
                  builder: (BuildContext context) =>
                      IFramePlayerPage(url: url));
              Navigator.of(context).push(router);
            } else if (matchUrl.substring(0, 23) == 'https://www.youtube.com') {
              getAllScreens(mReadyUrl, "JS");
            } else if (checkMp4 == ".mp4" ||
                checkMpd == ".mpd" ||
                checkWebm == ".webm" ||
                checkMkv == ".mkv" ||
                checkM3u8 == ".m3u8") {
              getAllScreens(mReadyUrl, "CUSTOM");
            } else {
              getAllScreens(mReadyUrl, "JS");
            }
          }
        }
      }
    }
  }

  void _showQualityDialog(mUrl360, mUrl480, mUrl720, mUrl1080) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            backgroundColor: Color.fromRGBO(250, 250, 250, 1.0),
            title: Text(
              "Video Quality",
              style: TextStyle(
                  color: Color.fromRGBO(72, 163, 198, 1.0),
                  fontWeight: FontWeight.w600,
                  fontSize: 20.0),
              textAlign: TextAlign.center,
            ),
            content: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    "Available video Format in which you want to play video.",
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.7), fontSize: 12.0),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  mUrl360 == null
                      ? SizedBox.shrink()
                      : Padding(
                          padding: EdgeInsets.only(left: 50.0, right: 50.0),
                          child: RaisedButton(
                            hoverColor: Colors.red,
                            splashColor: Color.fromRGBO(49, 131, 41, 1.0),
                            highlightColor: Color.fromRGBO(72, 163, 198, 1.0),
                            color: activeDotColor,
                            child: Container(
                              alignment: Alignment.center,
                              width: 100.0,
                              height: 30.0,
                              child: Text("360"),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                              getAllScreens(mUrl360, "CUSTOM");
                            },
                          ),
                        ),
                  SizedBox(
                    height: 5.0,
                  ),
                  mUrl480 == null
                      ? SizedBox.shrink()
                      : Padding(
                          padding: EdgeInsets.only(left: 50.0, right: 50.0),
                          child: RaisedButton(
                            color: activeDotColor,
                            hoverColor: Colors.red,
                            splashColor: Color.fromRGBO(49, 131, 41, 1.0),
                            highlightColor: Color.fromRGBO(72, 163, 198, 1.0),
                            child: Container(
                              alignment: Alignment.center,
                              width: 100.0,
                              height: 30.0,
                              child: Text("480"),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                              getAllScreens(mUrl480, "CUSTOM");
                            },
                          ),
                        ),
                  SizedBox(
                    height: 5.0,
                  ),
                  mUrl720 == null
                      ? SizedBox.shrink()
                      : Padding(
                          padding: EdgeInsets.only(left: 50.0, right: 50.0),
                          child: RaisedButton(
                            color: activeDotColor,
                            hoverColor: Colors.red,
                            splashColor: Color.fromRGBO(49, 131, 41, 1.0),
                            highlightColor: Color.fromRGBO(72, 163, 198, 1.0),
                            child: Container(
                              alignment: Alignment.center,
                              width: 100.0,
                              height: 30.0,
                              child: Text("720"),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                              getAllScreens(mUrl720, "CUSTOM");
                            },
                          ),
                        ),
                  SizedBox(
                    height: 5.0,
                  ),
                  mUrl1080 == null
                      ? SizedBox.shrink()
                      : Padding(
                          padding: EdgeInsets.only(left: 50.0, right: 50.0),
                          child: RaisedButton(
                            color: activeDotColor,
                            hoverColor: Colors.red,
                            splashColor: Color.fromRGBO(49, 131, 41, 1.0),
                            highlightColor: Color.fromRGBO(72, 163, 198, 1.0),
                            child: Container(
                              alignment: Alignment.center,
                              width: 100.0,
                              height: 30.0,
                              child: Text("1080"),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                              getAllScreens(mUrl1080, "CUSTOM");
                            },
                          ),
                        ),
                  SizedBox(
                    height: 5.0,
                  ),
                ],
              ),
            ));
      },
    );
  }

  void _onTapTrailer() {
    var trailerUrl = widget.videoDetail.trailerUrl;
    if (trailerUrl == null) {
      Fluttertoast.showToast(msg: "Trailer not available");
    } else {
      var checkMp4 = trailerUrl.substring(trailerUrl.length - 4);
      var checkMpd = trailerUrl.substring(trailerUrl.length - 4);
      var checkWebm = trailerUrl.substring(trailerUrl.length - 5);
      var checkMkv = trailerUrl.substring(trailerUrl.length - 4);
      var checkM3u8 = trailerUrl.substring(trailerUrl.length - 5);
      if (trailerUrl.substring(0, 23) == 'https://www.youtube.com') {
        var router = new MaterialPageRoute(
            builder: (BuildContext context) => new PlayerMovieTrailer(
                id: widget.videoDetail.id, type: widget.videoDetail.type));
        Navigator.of(context).push(router);
      } else if (checkMp4 == ".mp4" ||
          checkMpd == ".mpd" ||
          checkWebm == ".webm" ||
          checkMkv == ".mkv" ||
          checkM3u8 == ".m3u8") {
        var router = new MaterialPageRoute(
            builder: (BuildContext context) => new TrailerCustomPlayer(
                  url: trailerUrl,
                  title: widget.videoDetail.title,
                  downloadStatus: 1,
                ));
        Navigator.of(context).push(router);
      } else {
        var router = new MaterialPageRoute(
            builder: (BuildContext context) => new PlayerMovieTrailer(
                id: widget.videoDetail.id, type: widget.videoDetail.type));
        Navigator.of(context).push(router);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Stack(
      children: <Widget>[
        new Padding(
          padding: const EdgeInsets.only(bottom: 130.0),
          child: _buildDiagonalImageBackground(context),
        ),
        headerDecorationContainer(),
        new Positioned(
          top: 26.0,
          left: 4.0,
          child: new BackButton(color: Colors.white),
        ),
        new Positioned(
          top: 180.0,
          bottom: 0.0,
          left: 16.0,
          right: 16.0,
          child: headerRow(theme),
        ),
      ],
    );
  }

  Widget headerRow(theme) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        new Hero(
            tag: "${widget.videoDetail.title} ${widget.videoDetail.id}",
            child: VideoItemBox(
              context,
              widget.videoDetail,
              height: 220.0,
            )),
        new Expanded(
          child: new Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                new Text(
                  widget.videoDetail.title,
                  style: Theme.of(context).textTheme.subtitle1,
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                ),
                Flex(
                  direction: Axis.horizontal,
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: widget.videoDetail.rating == null
                          ? SizedBox.shrink()
                          : RatingInformation(widget.videoDetail),
                    )
                  ],
                ),
                header(theme),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget headerDecorationContainer() {
    return Container(
      height: 262.0,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
              colors: [
            Color.fromRGBO(34, 34, 34, 1.0).withOpacity(0.1),
            Color.fromRGBO(34, 34, 34, 1.0),
          ],
              stops: [
            0.3,
            0.8
          ])),
    );
  }

  Widget header(theme) {
    final userDetails = Provider.of<UserProfileProvider>(context, listen: false)
        .userProfileModel;
    return Padding(
        padding: const EdgeInsets.only(top: 12.0),
        child: new Column(
          children: <Widget>[
            OutlineButton(
              onPressed: userDetails.active == "1" || userDetails.active == 1
                  ? _onTapPlay
                  : _showMsg,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 0,
                    child: Icon(Icons.play_arrow,
                        color: Color.fromRGBO(72, 163, 198, 1.0)),
                  ),
                  new Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 0.0, 5.0, 0.0),
                  ),
                  Expanded(
                    flex: 1,
                    child: new Text(
                      "Play",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 15.0,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.9,
                          color: Colors.white
                          // color: Colors.white
                          ),
                    ),
                  ),
                ],
              ),
              padding: const EdgeInsets.fromLTRB(6.0, 0.0, 12.0, 0.0),
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0)),
              borderSide: new BorderSide(
                  color: Color.fromRGBO(72, 163, 198, 1.0), width: 2.0),
              color: Color.fromRGBO(72, 163, 198, 1.0),
              highlightColor: theme.accentColor,
              highlightedBorderColor: theme.accentColor,
              splashColor: Colors.black12,
              highlightElevation: 0.0,
            ),
            OutlineButton(
              onPressed: _onTapTrailer,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 0,
                    child: new Icon(Icons.play_arrow, color: Colors.white70),
                  ),
                  new Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 0.0, 5.0, 0.0),
                  ),
                  Expanded(
                    flex: 1,
                    child: new Text(
                      "Trailer",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontSize: 15.0,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.9,
                        color: Colors.white,
                        // color: Colors.white
                      ),
                    ),
                  ),
                ],
              ),
              padding: const EdgeInsets.fromLTRB(6.0, 0.0, 12.0, 0.0),
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0)),
              borderSide: BorderSide(color: Colors.white70, width: 2.0),
              highlightColor: theme.accentColor,
              highlightedBorderColor: theme.accentColor,
              splashColor: Colors.black12,
              highlightElevation: 0.0,
            )
          ],
        ));
  }

  Widget _buildDiagonalImageBackground(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return widget.videoDetail.poster == null
        ? Image.asset(
            "assets/placeholder_cover.jpg",
            height: 225.0,
            width: screenWidth,
            fit: BoxFit.cover,
          )
        : DiagonallyCutColoredImage(
            FadeInImage.assetNetwork(
              image: widget.videoDetail.type == DatumType.M
                  ? "${APIData.movieImageUriPosterMovie}${widget.videoDetail.poster}"
                  : "${APIData.tvImageUriPosterTv}${widget.videoDetail.poster}",
              placeholder: "assets/placeholder_cover.jpg",
              width: screenWidth,
              height: 225.0,
              fit: BoxFit.cover,
            ),
            color: const Color(0x00FFFFFF),
          );
  }
}
