import 'package:flutter/material.dart';
import 'package:flutterapp/util/rive/RiveUtil.dart';
import 'package:flutterapp/view/lightsapp/Ava/Ava.dart';
import 'package:flutterapp/view/lightsapp/ChatMessage/homeMessage.dart';
import 'package:flutterapp/view/lightsapp/ForgetPasswordScreen1/GeneratedForgotpasswordscreen1Widget.dart';
import 'package:flutterapp/view/lightsapp/ForgetPasswordScreen2/GeneratedForgotpasswordscreen2Widget.dart';
import 'package:flutterapp/view/lightsapp/Form/Form.dart';
import 'package:flutterapp/view/lightsapp/Game/Game.dart';
import 'package:flutterapp/view/lightsapp/Music/HomeScreenMusic.dart';
import 'package:flutterapp/view/lightsapp/Scan/ScanQr.dart';
import 'package:flutterapp/view/lightsapp/calender/calender_screen.dart';
import 'package:flutterapp/view/lightsapp/cardMenu/CardMenu.dart';
import 'package:flutterapp/view/lightsapp/chatbot/chatbot.dart';
import 'package:flutterapp/view/lightsapp/custommenu/custom_menu.dart';
import 'package:flutterapp/view/lightsapp/egg_screen/egg_screen.dart';
import 'package:flutterapp/view/lightsapp/favoriteScreen/FavoriteScreen.dart';
import 'package:flutterapp/view/lightsapp/generatedhelloscreenwidget/GeneratedHelloscreenWidget.dart';
import 'package:flutterapp/view/lightsapp/loginscreen/LoginscreenWidget.dart';
import 'package:flutterapp/view/lightsapp/logupScreen1/LogupscreenWidget.dart';
import 'package:flutterapp/view/lightsapp/logupScreen2/Logupscreen2Widget.dart';
import 'package:flutterapp/view/lightsapp/mainScreen/MainScreen.dart';
import 'package:flutterapp/view/lightsapp/movie/Movie.dart';
import 'package:flutterapp/view/lightsapp/story/story_widget.dart';
import 'package:flutterapp/view/lightsapp/story/storyscreen1/GeneratedStoryscreen1Widget.dart';
import 'package:flutterapp/view/lightsapp/whaleMenu/whale_menu.dart';

import 'app_fundemantal.dart';
import 'setting.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MyApp(
      _LightsApp(),
      _Loading(
        key: Key("loading"),
      ));
}

void initState() {
  RiveUtil riveUtil = RiveUtil();
  riveUtil.setup();
}

class _Loading extends StatelessWidget {
  const _Loading({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Colors.white,
      child: Center(
        child: Container(
          width: 50,
          height: 50,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow),
          ),
        ),
      ),
    );
  }
}

class _LightsApp extends StatefulWidget {
  @override
  State<_LightsApp> createState() => _LightsAppState();
}

class _LightsAppState extends State<_LightsApp> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Setting.setWidthSize(size.width);
    Setting.setHeightSize(size.height);
    return SafeArea(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Light\'s',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // initialRoute: '/Card',
        initialRoute: '/GeneratedLoginscreenWidget',
        routes: {
          '/GeneratedStartscreenWidget': (context) => EggScreen(),
          '/GeneratedHelloscreenWidget': (context) =>
              GeneratedHelloscreenWidget(),
          '/GeneratedStoryscreen1Widget': (context) =>
              GeneratedStoryscreen1Widget(),
          '/GeneratedLoginscreenWidget': (context) =>
              GeneratedLoginscreenWidget(),
          '/GeneratedLogupscreen1Widget': (context) => LogupScreen(),
          '/GeneratedLogupscreen2Widget': (context) =>
              GeneratedLogupscreen2Widget(),
          '/GeneratedFavoritescreenWidget': (context) => FavoriteScreenWidget(),
          '/GeneratedForgotpasswordscreen1Widget': (context) =>
              GeneratedForgotpasswordscreen1Widget(),
          '/GeneratedForgotpasswordscreen2Widget': (context) =>
              GeneratedForgotpasswordscreen2Widget(),
          '/Story': (context) => StoryWidget(
                key: ValueKey("StoryWidget"),
              ),
          '/Chatbot': (context) => Chatbot(),
          '/Ava': (context) => Ava(),
          '/Movie': (context) => MoviesPage(),
          '/Music': (context) => HomeScreenMusic(),
          '/homeMessage': (context) => MainMessage(),
          '/Calender': (context) => CalenderScreen(),
          '/Form': (context) => TableView(),
          '/Game': (context) => GamesPage(),
          '/scanQr': (context) => ScanQr(),
          '/Card': (context) => CardMenu(),
        },
        onGenerateRoute: (RouteSettings setting) {
          switch (setting.name) {
            case '/WhaleMenu':
              return NoAnimationPageRoute(builder: (context) => WhaleMenu());
            case '/GeneratedMainScreenWidget':
              return NoAnimationPageRoute(
                  builder: (context) => MainScreenWidget());
            case '/GeneratedStoryscreen1Widget':
              return NoAnimationPageRoute(
                  builder: (context) => GeneratedStoryscreen1Widget());
            case '/CustomMenu':
              return NoAnimationPageRoute(builder: (context) => CustomMenu());
            default:
              return null;
          }
        },
      ),
    );
  }
}

class NoAnimationPageRoute<T> extends PageRoute<T> {
  final WidgetBuilder builder;

  NoAnimationPageRoute({required this.builder});

  @override
  Color get barrierColor => Colors.transparent;

  @override
  String? get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return builder(context);
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => Duration(milliseconds: 0);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return child;
  }
}
