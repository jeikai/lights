import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterapp/services/api.dart';
import 'package:flutterapp/util/Preferences.dart';
import 'package:flutterapp/util/rive/RiveUtil.dart';
import 'package:intl/intl.dart';
import 'package:rive/rive.dart';

class StoryDiaryWidget extends StatefulWidget {
  final bool isToday;
  final DateTime time;

  const StoryDiaryWidget({Key? key, required this.time, this.isToday = false})
      : super(key: key);

  @override
  _StoryDiaryWidgetState createState() => _StoryDiaryWidgetState();
}

class _StoryDiaryWidgetState extends State<StoryDiaryWidget> {
  late Widget editView; //1
  late Widget viewView; //2
  late Widget imageAddingView; //3

  late final TextEditingController _titleController;
  late final TextEditingController _storyController;

  @override
  void initState() {
    _titleController = TextEditingController();
    _storyController = TextEditingController();
  }

  int state = 2;

  bool isSetup = false;

  void _setupWidget(BuildContext context) {
    //if(isSetup) return;
    _buildEditView(context);
    _buildViewView(context);
    _buildImageAddingView(context);
    isSetup = true;
  }

  void _buildEditView(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    double t = (size.width + size.height) / 2;
    editView = Column(
      key: ValueKey("SDW1"),
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            height: size.height / 10,
            child: Center(
              child: Text(
                "Write",
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Mistrully",
                    fontStyle: FontStyle.italic,
                    fontSize: t / 10,
                    decoration: TextDecoration.underline,
                    decorationThickness: 1,
                    decorationColor: Colors.black,
                    decorationStyle: TextDecorationStyle.solid),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        _TitleInput(
          controller: _titleController,
        ),
        _StoryInput(
          controller: _storyController,
        ),
        SizedBox(height: size.height / 13)
      ],
    );
  }

  Future<Map<String, dynamic>> fetchUserDiary(DateTime time) async {
    Map<String, dynamic> data = {
      "userId": Preferences.getId(),
      "date": Preferences.formatDate(widget.time),
    };
    Map<String, dynamic> ret =
        await Api().postData("get-or-create-user-date-activity", data) ?? {};
    if (!kReleaseMode) {
      print("Fetch Data for View:\n$ret");
    }
    return ret;
  }

  void _buildViewView(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    double t = (size.width + size.height) / 2;
    viewView = Column(
      key: ValueKey("SDW2"),
      children: [
        FutureBuilder(
            future: fetchUserDiary(widget.time),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                case ConnectionState.done:
                  {
                    Map<String, dynamic> data = snapshot.data;
                    return Expanded(
                      child: Stack(
                        children: [
                          SingleChildScrollView(
                            child: _ViewWidget(
                              title: data["userDate"]["title"] ?? "",
                              story: data["userDate"]["story"] ?? "",
                              imageData: null,
                            ),
                          )
                        ],
                      ),
                    );
                  }
                default:
                  return SizedBox();
              }
            }),
        SizedBox(height: size.height / 13)
      ],
    );
  }

  void _buildImageAddingView(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    double t = (size.width + size.height) / 2;
    imageAddingView = Column(
      key: ValueKey("SDW3"),
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            height: size.height / 10,
            child: Center(
              child: Text(
                "Write",
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Mistrully",
                    fontStyle: FontStyle.italic,
                    fontSize: t / 10,
                    decoration: TextDecoration.underline,
                    decorationThickness: 1,
                    decorationColor: Colors.black,
                    decorationStyle: TextDecorationStyle.solid),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        SizedBox(height: size.height / 13)
      ],
    );
  }

  void setSDWState(int state) {
    setState(() {
      this.state = state;
    });
  }

  Widget getChild() {
    if (!kReleaseMode) {
      print("State of SDW: $state");
    }
    switch (state) {
      case 1:
        return editView;
      case 2:
        return viewView;
      case 3:
        return imageAddingView;
      default:
        throw Exception("Unknown Story Diary State!!: $state");
    }
  }

  @override
  Widget build(BuildContext context) {
    _setupWidget(context);
    Size size = MediaQuery.sizeOf(context);
    double t = (size.width + size.height) / 2;
    return Dialog(
      insetPadding: EdgeInsets.zero,
      child: SingleChildScrollView(
        child: SizedBox(
          height: size.height * 0.965,
          width: size.width,
          child: Stack(
            alignment: Alignment.center,
            children: [
              RiveAnimation.direct(
                RiveUtil.BGONE,
                fit: BoxFit.fill,
              ),
              AnimatedSwitcher(
                duration: Duration(milliseconds: 700),
                child: getChild(),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding:
                      EdgeInsets.only(bottom: 20, right: 5, left: 5, top: 5),
                  child: SizedBox(
                    height: size.height / 13,
                    child: _BottomRow(
                      setState: setSDWState,
                      isEditing: (state == 1 || state == 3),
                      time: widget.time,
                      onSave: () => state == 1
                          ? putDataWriting(widget.time)
                          : state == 3
                              ? print("save")
                              : throw Exception("Save was call illegally"),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: BackButton(
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> putDataWriting(DateTime time) async {
    Map<String, dynamic> data = {
      "userId": Preferences.getId(),
      "date": Preferences.formatDate(time),
      "updateFields": {
        "title": _titleController.text,
        "story": _storyController.text
      }
    };
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
    await Api().pushDataUpdateWithoutId("update-user-date-activity", data);
    Navigator.pop(context);
    setSDWState(2);
    return;
  }

  Future<void> putDataImage(DateTime time) async {}
}

class _BottomRow extends StatelessWidget {
  final DateTime time;
  final void Function(int) setState;
  final bool isEditing;
  final void Function() onSave;

  const _BottomRow(
      {super.key,
      required this.setState,
      required this.isEditing,
      required this.time,
      required this.onSave});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    double t = (size.width + size.height) / 2;
    return Row(
      children: [
        ElevatedButton(
            onPressed: () => setState(1),
            style: ElevatedButton.styleFrom(
                fixedSize: Size.square(size.height / 13.5),
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent),
            child: Center(
              child: Icon(
                Icons.edit_note_outlined,
                color: Colors.black,
                size: t / 12,
              ),
            )),
        ElevatedButton(
            onPressed: () => setState(3),
            style: ElevatedButton.styleFrom(
                fixedSize: Size.square(size.height / 13.5),
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent),
            child: Center(
              child: Icon(
                Icons.image_outlined,
                color: Colors.black,
                size: t / 12,
              ),
            )),
        ElevatedButton(
            onPressed: () => setState(2),
            style: ElevatedButton.styleFrom(
                fixedSize: Size.square(size.height / 13.5),
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent),
            child: Center(
              child: Icon(
                Icons.bookmark_border,
                color: Colors.black,
                size: t / 12,
              ),
            )),
        SizedBox(
          width: size.width / 3.5,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              DateFormat("dd MM yy").format(time),
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: t / 32,
                  fontFamily: "Paytone One",
                  fontWeight: FontWeight.w100),
            ),
          ),
        ),
        if (isEditing)
          Expanded(
            child: Center(
              child: TextButton(
                onPressed: () {
                  onSave();
                },
                child: Text(
                  "SAVE",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: t / 32,
                      fontFamily: "Paytone One",
                      fontWeight: FontWeight.w100),
                ),
              ),
            ),
          )
      ],
    );
  }
}

class _ViewWidget extends StatelessWidget {
  final Uint8List? imageData;
  final String title;
  final String story;

  const _ViewWidget(
      {super.key, this.imageData, required this.title, required this.story});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    double t = (size.width + size.height) / 2;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              height: size.height / 10,
              child: Center(
                child: Text(
                  "Diary",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Mistrully",
                      fontStyle: FontStyle.italic,
                      fontSize: t / 10,
                      decoration: TextDecoration.underline,
                      decorationThickness: 1,
                      decorationColor: Colors.black,
                      decorationStyle: TextDecorationStyle.solid),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          if (imageData != null) ...[
            SizedBox(
              height: 50,
            ),
            Image.memory(imageData!),
          ],
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 30,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Title:",
                style: TextStyle(
                    fontFamily: "DancingScript",
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: Colors.black, width: 2),
                color: Color.fromARGB(200, 173, 193, 254)),
            child: Center(
              child: Text(
                title,
                maxLines: 1,
                style: TextStyle(
                  fontFamily: "Paytone One",
                  fontSize: t / 30,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 30,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Story:",
                style: TextStyle(
                    fontFamily: "DancingScript",
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.all(30),
            constraints: BoxConstraints(minHeight: size.height / 2),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: Colors.black, width: 2),
                color: Color.fromARGB(200, 173, 193, 254)),
            child: Text(
              story,
              style: TextStyle(
                fontFamily: "Paytone One",
                fontSize: t / 40,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ImageInput extends StatelessWidget {
  const _ImageInput({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class _TitleInput extends StatelessWidget {
  final TextEditingController controller;

  const _TitleInput({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    double t = (size.width + size.height) / 2;
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 5),
            child: Text(
              "Title",
              style: TextStyle(
                  fontFamily: "DancingScript",
                  fontSize: t / 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(5),
          child: Container(
            height: size.height / 12,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                color: Color.fromARGB(150, 173, 193, 254)),
            child: Center(
              child: TextField(
                controller: controller,
                maxLines: 1,
                minLines: 1,
                style: TextStyle(
                  fontFamily: "Paytone One",
                  fontSize: t / 30,
                ),
                decoration: InputDecoration(
                  hintText: "Nhập title mà bạn muốn chọn",
                  hintMaxLines: 1,
                  hintStyle: TextStyle(
                    fontFamily: "Paytone One",
                    fontSize: t / 30,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class _StoryInput extends StatelessWidget {
  final TextEditingController controller;

  const _StoryInput({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    double t = (size.width + size.height) / 2;
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 5),
            child: Text(
              "Story",
              style: TextStyle(
                  fontFamily: "DancingScript",
                  fontSize: t / 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(5),
          child: Container(
            height: size.height / 2,
            padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                color: Color.fromARGB(150, 173, 193, 254)),
            child: TextField(
              controller: controller,
              maxLines: null,
              minLines: 1,
              style: TextStyle(
                fontFamily: "Paytone One",
                fontSize: t / 40,
              ),
              decoration: InputDecoration(
                hintText: "Hãy kể cho tôi nghe ngày hôm nay của bạn thế nào ?",
                hintMaxLines: 2,
                hintStyle: TextStyle(
                  fontFamily: "Paytone One",
                  fontSize: t / 40,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        )
      ],
    );
  }
}
