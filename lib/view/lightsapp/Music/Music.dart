import 'package:flutter/material.dart';

class Music extends StatefulWidget {
  const Music({Key? key}) : super(key: key);

  @override
  _MusicState createState() => _MusicState();
}

class _MusicState extends State<Music> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Music'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Xử lý sự kiện tìm kiếm ở đây
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Thêm phần hiển thị danh sách bài hát ở đây
          Expanded(
            child: ListView.builder(
              itemCount: 10, // Số lượng bài hát
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.music_note),
                  title: Text('Bài hát $index'),
                  subtitle: Text('Nghệ sĩ $index'),
                  trailing: IconButton(
                    icon: Icon(Icons.play_circle_outline),
                    onPressed: () {
                      // Xử lý sự kiện play bài hát ở đây
                    },
                  ),
                );
              },
            ),
          ),
          // Thêm các điều khiển trình phát âm nhạc ở đây
          // Ví dụ: nút play, pause, tua bài, v.v.
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Music(),
  ));
}
