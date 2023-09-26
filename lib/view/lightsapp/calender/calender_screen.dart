import 'package:flutter/material.dart';
import 'package:flutterapp/util/image/ImageManager.dart';
import 'package:flutterapp/view/lightsapp/calender/calender_overlay.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderScreen extends StatelessWidget {
  const CalenderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: RadialGradient(colors: [
              Color.fromARGB(255, 157, 167, 220),
              Color.fromARGB(255, 189, 208, 232),
              Color.fromARGB(255, 166, 207, 233)
            ], radius: 1, tileMode: TileMode.mirror)),
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(top: size.height / 20),
                child: SizedBox(
                  height: size.height / 0.5,
                  width: size.width * 0.9,
                  child: TableCalendar(
                    focusedDay: DateTime.now(),
                    firstDay: DateTime.now(),
                    lastDay: DateTime.now().add(Duration(days: 356 * 20)),
                    headerStyle: HeaderStyle(
                        formatButtonVisible: false,
                        headerMargin:
                            EdgeInsets.only(bottom: size.height / 20)),
                    calendarBuilders: CalendarBuilders(
                        disabledBuilder: disableBuilder,
                        defaultBuilder: defaultBuilder,
                        todayBuilder: todayBuilder,
                        headerTitleBuilder: headTitleBuilder),
                    onDaySelected: (DateTime selected, DateTime focus) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return MenuOverlay(time: selected);
                          });
                      return;
                    },
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: BackButton(
              color: Colors.white,
            ),
          ),
          Positioned(
            bottom: -50,
            child: Container(
              height: size.height / 3.5,
              width: size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: MemoryImage(
                        ImageManager().getBytes(ImageManager.coral)!,
                      ),
                      fit: BoxFit.fitWidth)),
            ),
          )
        ],
      ),
    );
  }

  Widget headTitleBuilder(BuildContext context, DateTime day) {
    String month = DateFormat.MMMM().format(day);
    String year = DateFormat.y().format(day);
    Size size = MediaQuery.sizeOf(context);
    double t = (size.height + size.width) / 2;
    return Container(
      width: size.width,
      height: size.height / 7,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Transform.rotate(
              angle: -0.2,
              child: SizedBox(
                child: Text(
                  month,
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Mistrully",
                      fontStyle: FontStyle.italic,
                      fontSize: t / 10),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: t / 30,
            right: 0,
            child: SizedBox(
              child: Text(
                year,
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Paytone One",
                    fontSize: t / 30),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget todayBuilder(BuildContext context, DateTime day, DateTime? focusDay) {
    Size size = MediaQuery.sizeOf(context);
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Center(
          child: Container(
            height: size.width / 9,
            width: size.width / 9,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromARGB(100, 152, 162, 221)),
            child: Center(
              child: Text(
                day.day.toString(),
                style: TextStyle(
                    fontFamily: "Paytone One",
                    color: Colors.white.withAlpha(200)),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget defaultBuilder(
      BuildContext context, DateTime day, DateTime? focusDay) {
    Size size = MediaQuery.sizeOf(context);
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Center(
          child: Container(
            height: size.width / 9,
            width: size.width / 9,
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: Colors.white10.withAlpha(50)),
            child: Center(
              child: Text(
                day.day.toString(),
                style: TextStyle(
                    fontFamily: "Paytone One",
                    color: Colors.white10.withAlpha(200)),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget disableBuilder(
      BuildContext context, DateTime day, DateTime? focusDay) {
    Size size = MediaQuery.sizeOf(context);
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Center(
          child: Container(
            height: size.width / 8,
            width: size.width / 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [Colors.grey.withAlpha(80), Colors.transparent],
              ),
            ),
            child: Center(
              child: Text(
                day.day.toString(),
                style: TextStyle(
                    fontFamily: "Paytone One",
                    color: Colors.black12.withAlpha(100)),
              ),
            ),
          ),
        )
      ],
    );
  }
}
