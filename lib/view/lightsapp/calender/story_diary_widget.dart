import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/services/api.dart';
import 'package:flutterapp/util/CalenderController.dart';
import 'package:flutterapp/util/Preferences.dart';
import 'package:flutterapp/util/rive/RiveUtil.dart';
import 'package:image_picker/image_picker.dart';
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
  late final TextEditingController _titleController;
  late final TextEditingController _storyController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _storyController = TextEditingController();
  }

  int state = 2;

  Widget _buildEditView(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    double t = (size.width + size.height) / 2;
    return Column(
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
          key: ValueKey("TitleInput"),
          controller: _titleController,
        ),
        _StoryInput(
          key: ValueKey("StoryInput"),
          controller: _storyController,
        ),
        SizedBox(height: size.height / 10)
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

  Widget _buildViewView(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Column(
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
                              key: ValueKey("ViewWidget"),
                              title: data["userDate"]["title"] ?? "",
                              story: data["userDate"]["story"] ?? "",
                              imageData: data["userDate"]["image"],
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
        SizedBox(height: size.height / 10)
      ],
    );
  }

  Widget _buildImageAddingView(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    double t = (size.width + size.height) / 2;
    return Column(
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
        Expanded(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: _ImageWidget(
                  key: ValueKey("ImageInputWidget"),
                  setFile: setFile,
                ),
              )
            ],
          ),
        ),
        SizedBox(height: size.height / 10)
      ],
    );
  }

  void setSDWState(int state) {
    setState(() {
      this.state = state;
    });
  }

  Widget getChild(BuildContext context) {
    if (!kReleaseMode) {
      print("State of SDW: $state");
    }
    switch (state) {
      case 1:
        return _buildEditView(context);
      case 2:
        return _buildViewView(context);
      case 3:
        return _buildImageAddingView(context);
      default:
        throw Exception("Unknown Story Diary State!!: $state");
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
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
                child: getChild(context),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding:
                  EdgeInsets.only(bottom: 20, right: 5, left: 5, top: 5),
                  child: SizedBox(
                    height: size.height / 13,
                    child: _BottomRow(
                      key: ValueKey("CalenderBottomRow"),
                      setState: setSDWState,
                      isEditing: (state == 1 || state == 3),
                      time: widget.time,
                      onSave: () => state == 1
                          ? putDataWriting(widget.time)
                          : state == 3
                              ? putDataImage(widget.time)
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
    await CalenderController.putDataWriting(
        time, _titleController.text, _storyController.text);
    Navigator.pop(context);
    setSDWState(2);
    return;
  }

  File? file;

  void setFile(File? file) {
    this.file = file;
  }

  Future<void> putDataImage(DateTime time) async {
    if (!kReleaseMode) {
      print("Putting Image:");
    }
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
    if (file != null) {
      if (!kReleaseMode) {
        print("Putting Image: file != null");
      }
      await CalenderController.putDataImage(time, file!.path);
      if (!kReleaseMode) {
        print("Putting Image: complete");
      }
    }
    Navigator.pop(context);
    setSDWState(2);
    return;
  }
}

class _BottomRow extends StatelessWidget {
  final DateTime time;
  final void Function(int) setState;
  final bool isEditing;
  final void Function() onSave;

  const _BottomRow({super.key,
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
  final String? imageData;
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
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                color: Colors.black,
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: Center(
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: Image.network(imageData!),
                ),
              ),
            ),
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
                style: const TextStyle(
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
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: Colors.black, width: 2),
                color: const Color.fromARGB(200, 173, 193, 254)),
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
          const SizedBox(
            height: 20,
          ),
          const SizedBox(
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
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.all(30),
            width: size.width - 40,
            constraints: BoxConstraints(minHeight: size.height / 2),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: Colors.black, width: 2),
                color: const Color.fromARGB(200, 173, 193, 254)),
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

class _ImageWidget extends StatefulWidget {
  final void Function(File?) setFile;

  const _ImageWidget({super.key, required this.setFile});

  @override
  _ImageWidgetState createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<_ImageWidget> {
  /// Variables
  File? imageFile;

  /// Widget
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    double t = (size.width + size.height) / 2;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: Color.fromARGB(150, 173, 193, 254)),
          width: size.width - 40,
          height: size.height / 1.5,
          child: imageFile != null
              ? ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  clipBehavior: Clip.hardEdge,
                  child: Image.file(
                    imageFile!,
                    fit: BoxFit.contain,
                  ),
                )
              : SizedBox(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () {
                _getFromGallery();
              },
              child: Text(
                "PICK FROM GALLERY",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: t / 40,
                    fontFamily: "Paytone One",
                    fontWeight: FontWeight.w100),
              ),
            ),
            TextButton(
              onPressed: () {
                _getFromCamera();
              },
              child: Text(
                "PICK FROM CAMERA",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: t / 40,
                    fontFamily: "Paytone One",
                    fontWeight: FontWeight.w100),
              ),
            )
          ],
        )
      ],
    );
  }

  /// Get from gallery
  _getFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        widget.setFile(imageFile);
      });
    }
  }

  /// Get from Camera
  _getFromCamera() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        widget.setFile(imageFile);
      });
    }
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
                onTapOutside: (event) => {FocusScope.of(context).unfocus()},
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
              onTapOutside: (event) => {FocusScope.of(context).unfocus()},
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
