import 'package:flutter/material.dart';
import 'package:flutterapp/view/lightsapp/Ava/component/EmotionData.dart';
import 'package:flutterapp/view/lightsapp/Ava/component/lineChart.dart';
import 'package:flutterapp/view/lightsapp/Ava/component/template_view.dart';
import 'package:flutterapp/util/Preferences.dart';
import 'package:fl_chart/fl_chart.dart';

class Ava extends StatefulWidget {
  const Ava({Key? key});

  @override
  State<Ava> createState() => _AvaState();
}

class _AvaState extends State<Ava> {
  String username = "";

  @override
  void initState() {
    super.initState();
    username = Preferences.getUsername()!;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double gap = size.width * 0.075;
    double padding = size.width * 0.1;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Color.fromRGBO(148, 161, 215, 1.0),
              size: 32.0,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Material(
        child: ListView(
          padding: EdgeInsets.all(0),
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: padding,
                right: padding,
                top: gap,
                bottom: gap,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TemplateView(
                    color: Color.fromRGBO(188, 220, 237, 1),
                    height: 70,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Image.asset('assets/images/user_icon.png'),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Text(
                                    username,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: "Paytone One",
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(71, 79, 145, 1),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              height: 5.0,
                              width: 200,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  TemplateView(
                    color: Color.fromRGBO(168, 195, 230, 1),
                    height: 100,
                    children: [
                      Container(
                        height: 100, // Đặt chiều cao cho Container ở đây
                        child: SingleChildScrollView(
                          child: Text(
                            'Nội dung văn bản của bạn ở đây.',
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                  TemplateView(
                    color: Color.fromRGBO(168, 195, 230, 1),
                    height: 300,
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: lineChart(emotionDatas),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
