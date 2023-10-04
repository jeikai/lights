import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/services/api.dart';

import 'MovieDetail.dart';

class Movie {
  final String title;
  final String image;
  final String genre;
  final String duration;
  final String rating;
  final String description;
  final String path;

  Movie(
      {required this.title,
        required this.image,
        required this.genre,
        required this.duration,
        required this.rating,
        required this.description,
      required this.path});
}

class MoviesPage extends StatefulWidget {
  const MoviesPage({Key? key}) : super(key: key);

  @override
  _MoviesPageState createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  CarouselController _carouselController = CarouselController();
  int _current = 0;
  List<Movie> _movies = [];
  String _currentImage = 'assets/images/movie/soul.jpg';

  @override
  void initState() {
    super.initState();
    _getDataFromApi();
  }

  Future<void> _getDataFromApi() async {
    final api = Api();
    final response = await api.getData("Film");
    if (response != null) {
      setState(() {
        _movies = _parseMovies(response);
        print(_movies);
        if (_movies.isNotEmpty) {
          _currentImage = 'assets/images/movie/' + _movies[0].image;
        }
      });
    }
  }

  List<Movie> _parseMovies(List<dynamic> jsonData) {
    final List<Movie> movies = [];

    for (final movieData in jsonData) {
      final Movie movie = Movie(
        title: movieData['title'],
        image: movieData['image'],
        genre: movieData['genre'],
        duration: movieData['duration'],
        rating: movieData['rating'],
        description: movieData['description'],
        path: movieData['path']
      );
      movies.add(movie);
    }
    return movies;
  }

  void _navigateToMovieDetail(Movie movie) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MovieDetail(movie: movie),
      ),
    );
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
              image: AssetImage(_currentImage), // Sử dụng biến tạm thời
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
                      _currentImage = 'assets/images/movie/' + _movies[_current].image;
                    });
                  },
                ),
                carouselController: _carouselController,
                items: _movies.map((movie) {
                  return Builder(
                    builder: (BuildContext context) {
                      return GestureDetector(
                        onTap: () {
                          _navigateToMovieDetail(movie);
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
                                    image: AssetImage('assets/images/movie/' + movie.image),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  movie.title,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 20),
                                Container(
                                  child: Text(
                                    movie.genre,
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
                                  opacity: _current == _movies.indexOf(movie)
                                      ? 1.0
                                      : 0.0,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 20.0,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.star,
                                                color: Colors.yellow,
                                                size: 20,
                                              ),
                                              SizedBox(width: 5),
                                              Text(
                                                movie.rating,
                                                style: TextStyle(
                                                  fontSize: 14.0,
                                                  color: Colors.grey.shade600,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.access_time,
                                                color: Colors.grey.shade600,
                                                size: 20,
                                              ),
                                              SizedBox(width: 5),
                                              Text(
                                                movie.duration,
                                                style: TextStyle(
                                                  fontSize: 14.0,
                                                  color: Colors.grey.shade600,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                              .size
                                              .width *
                                              0.2,
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.play_circle_filled,
                                                color: Colors.grey.shade600,
                                                size: 20,
                                              ),
                                              SizedBox(width: 5),
                                              Text(
                                                'Watch',
                                                style: TextStyle(
                                                  fontSize: 14.0,
                                                  color: Colors.grey.shade600,
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
