import 'package:flutter/material.dart';
import 'package:nexthour/common/apipath.dart';
import 'package:nexthour/common/route_paths.dart';
import 'package:nexthour/models/episode.dart';
import 'package:nexthour/providers/movie_tv_provider.dart';
import 'package:nexthour/ui/screens/video_detail_screen.dart';
import 'package:provider/provider.dart';

class TopVideoList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var topMovieTV = Provider.of<MovieTVProvider>(context, listen: false).topVideoList;
    return ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        padding: EdgeInsets.only(left: 15.0),
        scrollDirection: Axis.horizontal,
        itemCount: topMovieTV.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            child: Container(
              margin: EdgeInsets.only(right: 15.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.0),
              ),
              child: Material(
                borderRadius: new BorderRadius.circular(5.0),
                child: ClipRRect(
                  borderRadius: new BorderRadius.circular(5.0),
                  child: topMovieTV[index].thumbnail == null ? Image.asset("assets/placeholder_box.jpg",
                    height: 260,
                    width: 190.0,
                    fit: BoxFit.cover,
                  ) :  FadeInImage.assetNetwork(
                    image: topMovieTV[index].type == DatumType.T ? "${APIData.tvImageUriTv}${topMovieTV[index].thumbnail}" :
                    "${APIData.movieImageUri}${topMovieTV[index].thumbnail}",
                    placeholder: "assets/placeholder_box.jpg",
                    height: 260,
                    width: 190.0,
                    imageScale: 1.0,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            onTap: (){
              Navigator.pushNamed(context, RoutePaths.videoDetail, arguments: VideoDetailScreen(topMovieTV[index]));
            },
          );
        });
  }
}
