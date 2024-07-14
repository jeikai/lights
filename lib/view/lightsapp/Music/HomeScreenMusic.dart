import 'package:flutter/material.dart';
import 'package:flutterapp/model/song_model.dart';
import 'package:flutterapp/services/api.dart';
import 'package:flutterapp/view/lightsapp/Music/component/playist_card.dart';
import 'package:flutterapp/view/lightsapp/Music/component/widgets.dart';

class HomeScreenMusic extends StatefulWidget {
  const HomeScreenMusic({Key? key}) : super(key: key);

  @override
  State<HomeScreenMusic> createState() => _HomeScreenMusicState();
}

class _HomeScreenMusicState extends State<HomeScreenMusic> {
  Future<List<Song>>? songsFuture;

  @override
  void initState() {
    super.initState();
    songsFuture = getData();
  }

  Future<List<Song>> getData() async {
    final api = Api();
    final response = await api.getData("Song");
    if (response != null) {
      List<Song> parse = response.map((songData) {
        return Song(
          title: songData['title'],
          description: songData['description'],
          url: songData['url'],
          coverUrl: songData['coverUrl'],
        );
      }).toList();
      return parse; 
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.deepPurple.shade800.withOpacity(0.8),
            Colors.deepPurple.shade200.withOpacity(0.8),
          ],
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder<List<Song>>(
                future: songsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    final songs = snapshot.data ?? [];
                    return Column(
                      children: [
                        _TrendingMusic(songs: songs),
                        _PlaylistMusic(songs: songs),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PlaylistMusic extends StatelessWidget {
  const _PlaylistMusic({
    Key? key,
    required this.songs,
  }) : super(key: key);

  final List<Song> songs;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const SectionHeader(title: 'Playlists'),
          ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 20),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: songs.length,
            itemBuilder: ((context, index) {
              return PlaylistCard(song: songs[index]);
            }),
          ),
        ],
      ),
    );
  }
}

class _TrendingMusic extends StatelessWidget {
  const _TrendingMusic({
    Key? key,
    required this.songs,
  }) : super(key: key);

  final List<Song> songs;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20.0,
        top: 20.0,
        bottom: 20.0,
      ),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: SectionHeader(title: 'Trending Music'),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.27,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: songs.length,
              itemBuilder: (context, index) {
                return SongCard(song: songs[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
