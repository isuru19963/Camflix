import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:nexthour/common/styles.dart';
import 'common/global.dart';
import 'my_app.dart';
import 'package:nexthour/services/repository/database_creator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterDownloader.initialize();
  await DatabaseCreator().initDatabase();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: kDarkBgLight,
    statusBarColor: kDarkBgLight,
  ));
  authToken = await storage.read(key: "token");
  runApp(MyApp(token: authToken,));
}

