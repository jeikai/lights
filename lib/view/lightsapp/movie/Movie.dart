import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'MovieDetail.dart';

// Lớp dữ liệu để đại diện cho thông tin phim
class Movie {
  final String title;
  final String image;
  final String genre;
  final String duration;
  final String rating;
  final String description;

  Movie(
      {required this.title,
      required this.image,
      required this.genre,
      required this.duration,
      required this.rating,
      required this.description});
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
        image: 'soul.jpg',
        genre: 'Animation Family\n Comedy Fantasy Drama',
        duration: '1h41m',
        rating: '8',
        description:
            'Created by director Pete Docter and written by Kemp Powers, Soul brought positive vibes to the year 2020, a year marked by numerous events that left humanity grappling. With that fresh energy, the film carries no satire or criticism towards anyone. Soul is truly like a gentle jazz tune that resonates with the viewers\' souls and kindles the flame of love for life within each person.'),
    Movie(
        title: 'Little Forest (2014)',
        image: 'LittleForest.png',
        genre: 'Drama',
        duration: '1h43m',
        rating: '7.6',
        description:
            'The film\'s storyline is based on a manga about life in Japan. The movie is set in the Tōhoku region of Japan. The main character in the film is Ichiko (Ai Hashimoto), a young girl living in the city. \nAfter a series of heartbreaking events in her life in the big city, she decides to return to her old home in the countryside and lead a simple rural life. Going through the four seasons of spring, summer, autumn, and winter in the peaceful countryside, Ichiko finds inner peace and tranquility in her soul.'),
    Movie(
        title: 'Move to heaven',
        image: 'MoveTheHeaven.png',
        genre: 'Drama',
        duration: '10 Eps',
        rating: '7.9',
        description:
            'The film tells the story of Han Geu Roo (Tang Joon Sang), a 20-year-old with a distinctive neurodevelopmental disorder. Since he was a child, Geu Roo has followed his father\'s profession of cleaning up the belongings of the deceased. They meticulously and respectfully tidy up the scene, arrange the belongings left behind by the departed. Occasionally, they also complete the unfinished tasks of the deceased, so they can peacefully move on to the afterlife.\nThen, Geu Roo\'s father suddenly passes away, leaving him deeply wounded. Geu Roo has to live with Sang Gu, his recently released-from-prison uncle whom he has never met before. Initially, Sang Gu agrees to become Geu Roo\'s guardian solely with the desire to inherit the property his older brother left behind. However, as he and Geu Roo work together to clean up the possessions of the deceased, Sang Gu embarks on a profoundly moving journey of discovering the untold stories behind the lives of those who have passed away.'),
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
    final screenWidth = MediaQuery.of(context).size.width;
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
