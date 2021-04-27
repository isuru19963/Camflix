import 'package:flutter/material.dart';
import 'package:nexthour/custom_player/chewie.dart';
import 'package:video_player/video_player.dart';
import 'package:nexthour/common/global.dart';
import 'dart:io';

class DownloadedVideoPlayer extends StatefulWidget {
  DownloadedVideoPlayer({this.taskId, this.name, this.fileName, this.downloadStatus});
  final String taskId;
  final String name;
  final String fileName;
  final int downloadStatus;

  @override
  _DownloadedVideoPlayerState createState() => _DownloadedVideoPlayerState();
}

class _DownloadedVideoPlayerState extends State<DownloadedVideoPlayer> with WidgetsBindingObserver{
  TargetPlatform _platform;
  VideoPlayerController _videoPlayerController1;
  ChewieController _chewieController;
  var vFileName;

  @override
  void initState() {
    super.initState();
    setState(() {
      playerTitle = widget.name;
      vFileName = widget.fileName;
    });

    WidgetsBinding.instance.addObserver(this);
    _videoPlayerController1 = VideoPlayerController.file(File("$localPath/$vFileName"));
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      aspectRatio: 3/2,
      autoPlay: true,
      looping: true,
      materialProgressColors: ChewieProgressColors(
        playedColor: Colors.red,
        handleColor: Colors.red,
        backgroundColor: Colors.white.withOpacity(0.6),
        bufferedColor: Colors.white,
      ),
      placeholder: Container(
        color: Colors.black,
      ),
      // autoInitialize: true,
    );

    var r = _videoPlayerController1.value.aspectRatio;
    String os = Platform.operatingSystem;

    if(os == 'android'){
      setState(() {
        _platform = TargetPlatform.android;
      });
    }else{
      setState(() {
        _platform = TargetPlatform.iOS;
      });
    }

  }

  @override
  void dispose() {
    _videoPlayerController1.dispose();
    _chewieController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Expanded(
            child: Center(
              child: Chewie(
                controller: _chewieController,
                title: playerTitle,
                downloadStatus: widget.downloadStatus,
              ),
            ),
          ),
        ],
      ),
    );
  }
}