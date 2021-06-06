import 'package:flutter/material.dart';
import 'package:nexthour/providers/actor_movies_provider.dart';
import 'package:nexthour/providers/app_config.dart';
import 'package:nexthour/common/route_paths.dart';
import 'package:nexthour/ui/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:nexthour/common/styles.dart';
import 'package:nexthour/providers/faq_provider.dart';
import 'package:nexthour/providers/login_provider.dart';
import 'package:nexthour/providers/main_data_provider.dart';
import 'package:nexthour/providers/menu_data_provider.dart';
import 'package:nexthour/providers/menu_provider.dart';
import 'package:nexthour/providers/movie_tv_provider.dart';
import 'package:nexthour/providers/notifications_provider.dart';
import 'package:nexthour/providers/payment_key_provider.dart';
import 'package:nexthour/providers/slider_provider.dart';
import 'package:nexthour/providers/user_profile_provider.dart';
import 'package:nexthour/providers/wishlist_provider.dart';
import 'package:nexthour/providers/coupon_provider.dart';
import 'package:nexthour/ui/route_generator.dart';
import 'package:nexthour/ui/screens/splash_screen.dart';
import 'package:nexthour/providers/watch_history_provider.dart';
class PaymentSuccess extends StatefulWidget {


  @override
  State<StatefulWidget> createState() {
    return PaymentSuccessstate();
  }
}


class PaymentSuccessstate extends State<PaymentSuccess> {
  // PaymentSuccess({this.token});
  // final String token;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppConfig()),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => UserProfileProvider()),
        ChangeNotifierProvider(create: (_) => MenuProvider()),
        ChangeNotifierProvider(create: (_) => SliderProvider()),
        ChangeNotifierProvider(create: (_) => MainProvider()),
        ChangeNotifierProvider(create: (_) => MovieTVProvider()),
        ChangeNotifierProvider(create: (_) => MenuDataProvider()),
        ChangeNotifierProvider(create: (_) => WishListProvider()),
        ChangeNotifierProvider(create: (_) => NotificationsProvider()),
        ChangeNotifierProvider(create: (_) => FAQProvider()),
        ChangeNotifierProvider(create: (_) => PaymentKeyProvider()),
        ChangeNotifierProvider(create: (_) => WatchHistoryProvider()),
        ChangeNotifierProvider(create: (_) => ActorMoviesProvider()),
        ChangeNotifierProvider(create: (_) => CouponProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: RoutePaths.appTitle,
        theme: buildDarkTheme(),
        initialRoute: RoutePaths.home,
        onGenerateRoute: RouteGenerator.generateRoute,
        routes: {
          RoutePaths.home: (context) => HomeScreen(),
        },
      ),
    );
  }
}
