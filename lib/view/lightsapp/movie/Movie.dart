import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'MovieDetail.dart';

// Lớp dữ liệu để đại diện cho thông tin phim
class Movie {
  final String title;
  final String image;
  final String description;
  final String duration;
  final String rating;

  Movie({
    required this.title,
    required this.image,
    required this.description,
    required this.duration,
    required this.rating,
  });
}

class MoviesPage extends StatefulWidget {
  const MoviesPage({Key? key}) : super(key: key);

  @override
  _MoviesPageState createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  CarouselController _carouselController = CarouselController();
  int _current = 0;

  // Danh sách các phim
  List<Movie> _movies = [
    Movie(
      title: 'Soul',
      image: 'assets/images/movie/soul.jpg',
      description: 'Animation Family\n Comedy Fantasy Drama',
      duration: '1h41m',
      rating: '8',
    ),
    Movie(
      title: 'Little Forest (2014)',
      image: 'assets/images/movie/LittleForest.png',
      description: 'Drama',
      duration: '1h43m',
      rating: '7.6',
    ),
    Movie(
      title: 'Move to heaven',
      image: 'assets/images/movie/MoveTheHeaven.png',
      description: 'Drama',
      duration: '10 Eps',
      rating: '7.9',
    ),
  ];

  @override
  void initState() {
    super.initState();
  }

  // Phương thức để chuyển sang trang chi tiết phim
  void _navigateToMovieDetail(Movie movie) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MovieDetail(movie: movie),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Image(
              image: AssetImage(_movies[_current].image),
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
                                    image: AssetImage(movie.image),
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
                                    movie.description,
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
                                          width:
                                          MediaQuery.of(context).size.width *
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
