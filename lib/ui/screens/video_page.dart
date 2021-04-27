import 'package:flutter/material.dart';
import 'package:nexthour/providers/app_config.dart';
import 'package:nexthour/providers/login_provider.dart';
import 'package:nexthour/providers/main_data_provider.dart';
import 'package:nexthour/providers/menu_data_provider.dart';
import 'package:nexthour/providers/movie_tv_provider.dart';
import 'package:nexthour/ui/shared/actors_horizontal_list.dart';
import 'package:nexthour/ui/shared/heading1.dart';
import 'package:nexthour/ui/shared/image_slider.dart';
import 'package:nexthour/ui/screens/horizental_genre_list.dart';
import 'package:nexthour/ui/screens/horizontal_movies_list.dart';
import 'package:nexthour/ui/screens/horizontal_tvseries_list.dart';
import 'package:nexthour/ui/screens/top_video_list.dart';
import 'package:nexthour/ui/shared/live_video_list.dart';
import 'package:nexthour/ui/widgets/blog_view.dart';
import 'package:provider/provider.dart';

class VideosPage extends StatefulWidget {
  VideosPage({Key key, this.menuId}) : super(key: key);
  final menuId;

  @override
  _VideosPageState createState() => _VideosPageState();
}

class _VideosPageState extends State<VideosPage> {
  GlobalKey _keyRed = GlobalKey();
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  var meData;
  ScrollController controller;
  bool _visible = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = ScrollController(initialScrollOffset: 50.0);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
    try{
      MenuDataProvider menuDataProvider =
      Provider.of<MenuDataProvider>(context, listen: false);
      await menuDataProvider.getMenusData(context, widget.menuId);
    }catch (err){
    return null;
    }
    if(mounted){
      setState(() {
        _visible = true;
      });
    }
    });
  }

  Future<Null> refreshList() async {
    refreshKey.currentState?.show();
    await Future.delayed(Duration(seconds: 2));
//    getMenuData();
  }

  @override
  Widget build(BuildContext context) {
    var login = Provider.of<LoginProvider>(context);
    var menuDataList = Provider.of<MenuDataProvider>(context).menuDataList;
    var moviesList = Provider.of<MenuDataProvider>(context).menuCatMoviesList;
    var tvSeriesList = Provider.of<MenuDataProvider>(context).menuCatTvSeriesList;
    var liveDataList = Provider.of<MenuDataProvider>(context).liveDataList;
    var topVideosList = Provider.of<MovieTVProvider>(context, listen: false).topVideoList;
    var blogList = Provider.of<AppConfig>(context, listen: false).appModel.blogs;
    var actorsList = Provider.of<MainProvider>(context, listen: false).actorList;
    return Container(
      child: _visible == false
          ? Center(
              child: CircularProgressIndicator(),
            )
          : menuDataList.length == 0 ? Center(child: Text("No data available", style: TextStyle(fontSize: 16.0),),): Container(
              child: SingleChildScrollView(
                child: Column(
                  key: _keyRed,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ImageSlider(),
                    SizedBox(
                      height: 15.0,
                    ),
                    HorizontalGenreList(),
                    SizedBox(
                      height: 15.0,
                    ),
                    actorsList.length == 0 ? SizedBox.shrink() : Heading1("Artist", "Actor"),
                    actorsList.length == 0 ? SizedBox.shrink() : SizedBox(
                      height: 15.0,
                    ),
                    actorsList.length == 0 ? SizedBox.shrink() : ActorsHorizontalList(),
                    SizedBox(
                      height: 15.0,
                    ),
                    topVideosList.length == 0? SizedBox.shrink() : Heading1("Top Movies & TV Series", "Top"),
                    topVideosList.length == 0? SizedBox.shrink() :  SizedBox(
                      height: 15.0,
                    ),
                    topVideosList.length == 0? SizedBox.shrink() :  Container(
                      height: 260,
                      child: TopVideoList(),
                    ),
                    liveDataList.length == 0 ? SizedBox.shrink() : SizedBox(
                      height: 15.0,
                    ),
                    liveDataList.length == 0 ? SizedBox.shrink() : Heading2("LIVE", "Live"),
                    liveDataList.length == 0 ? SizedBox.shrink() : LiveVideoList(),
                    SizedBox(
                      height: 15.0,
                    ),
                    tvSeriesList.length == 0
                        ? SizedBox.shrink()
                        : Heading1("TV Series", "TV"),
                    TvSeriesList(),
                    SizedBox(
                      height: 15.0,
                    ),
                    moviesList.length == 0
                        ? SizedBox.shrink()
                        : Heading1("Movies", "Mov"),
                    MoviesList(),
                    SizedBox(
                      height: 15.0,
                    ),
                    blogList.length == 0 ? SizedBox.shrink(): Heading1("Our Blog Posts", "Blog"),
                    blogList.length == 0 ? SizedBox.shrink(): SizedBox(
                      height: 15.0,
                    ),
                    BlogView(),
                  ],
                ),
              ),
            ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
