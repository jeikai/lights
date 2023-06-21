import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //Khai báo biến
  String buttonName = "Click here";
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //Xoá Banner ở góc trên bên phải
      debugShowCheckedModeBanner: false,

      //Scaffold là widget chung cho tất cả
      home: Scaffold(
        // Phần top
        appBar: AppBar(
          //Tiêu đề cho phần header
          title: const Text('Light`s'),
        ),

        //Phần nội dung
        body: Center(
          // Về cơ bản thì là toán tử 3 ngôi render có đk
          child: currentIndex == 0
              ? Container(
                  // Column có độ rộng lớn nhất có thể
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.blueGrey,
                  child: Column(
                    // Vị trí phần tử theo cột
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            // Màu cho text chữ
                            onPrimary: Colors.white,
                            //Màu cho nút button
                            primary: Colors.orange,
                          ),
                          onPressed: () {
                            //Bên trong ngoặc nhọn này là hàm xử lý sự kiện khi được click

                            setState(() {
                              //Update lại widget
                              buttonName = "Welcome to Funbug";
                            });
                          },
                          child: Text(buttonName)),
                    ],
                  ),
                )
              : Image.asset('images/em.jpg'),
        ),

        //Phần bottom
        bottomNavigationBar: BottomNavigationBar(
          // Yêu cầu phải có 2 items trở lên
          items: const [
            BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home)),
            BottomNavigationBarItem(
                label: 'Setting', icon: Icon(Icons.settings)),
          ],
          // Chỉ mục index item đang được chọn
          currentIndex: currentIndex,
          //Thay đổi index khi chọn
          onTap: (int index) {
            setState(() {
              currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
