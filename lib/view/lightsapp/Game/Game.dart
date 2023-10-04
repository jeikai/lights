import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/services/api.dart';
import 'package:url_launcher/url_launcher.dart';

class Game {
  final String title;
  final String image;
  final String genre;
  final String path;

  Game(
      {required this.title,
        required this.image,
        required this.genre,
        required this.path});
}

class GamesPage extends StatefulWidget {
  const GamesPage({Key? key}) : super(key: key);

  @override
  _GamesPageState createState() => _GamesPageState();
}

class _GamesPageState extends State<GamesPage> {
  CarouselController _carouselController = CarouselController();
  int _current = 0;
  List<Game> _Games = [];
  String _currentImage = 'assets/images/game/dapchuot.png';

  @override
  void initState() {
    super.initState();
    _getDataFromApi();
  }

  Future<void> _getDataFromApi() async {
    final api = Api();
    final response = await api.getData("Game");
    print('Type of response: ${response.runtimeType}');
    if (response != null) {
      setState(() {
        _Games = _parseGames(response);
        print(_Games);
        if (_Games.isNotEmpty) {
          _currentImage = 'assets/images/game/' + _Games[0].image;
        }
      });
    }
  }

  List<Game> _parseGames(List<dynamic> jsonData) {
    final List<Game> Games = [];

    for (final GameData in jsonData) {
      final Game game = Game(
          title: GameData['title'],
          image: GameData['image'],
          genre: GameData['genre'],
          path: GameData['path']
      );
      Games.add(game);
    }
    return Games;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Image(
              image: AssetImage(_currentImage),
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.3,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.grey.shade50.withOpacity(1),
                      Colors.grey.shade50.withOpacity(1),
                      Colors.grey.shade50.withOpacity(1),
                      Colors.grey.shade50.withOpacity(1),
                      Colors.grey.shade50.withOpacity(0.0),
                      Colors.grey.shade50.withOpacity(0.0),
                      Colors.grey.shade50.withOpacity(0.0),
                      Colors.grey.shade50.withOpacity(0.0),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 10,
              left: 10,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: screenWidth * 0.07,
                ),
              ),
            ),
            Positioned(
              bottom: 50,
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width,
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 500.0,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.70,
                  enlargeCenterPage: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                      // Cập nhật hình ảnh hiện tại khi chuyển trang
                      _currentImage = 'assets/images/game/' + _Games[_current].image;
                    });
                  },
                ),
                carouselController: _carouselController,
                items: _Games.map((Game) {
                  return Builder(
                    builder: (BuildContext context) {
                      return GestureDetector(
                        onTap: () async {
                          final url = Uri.parse(
                              Game.path);
                          try {
                            await launch(url.toString());
                          } catch (e) {
                            print('Error: $e');
                          }
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                  height: 320,
                                  margin: EdgeInsets.only(top: 30),
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Image(
                                    image: AssetImage('assets/images/game/' + Game.image),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  Game.title,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 20),
                                Container(
                                  child: Text(
                                    Game.genre,
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.grey.shade600,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                SizedBox(height: 20),
                                AnimatedOpacity(
                                  duration: Duration(milliseconds: 500),
                                  opacity: _current == _Games.indexOf(Game)
                                      ? 1.0
                                      : 0.0,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 20.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
