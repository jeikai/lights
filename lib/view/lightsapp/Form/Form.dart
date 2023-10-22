import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/reusable_widget/Button_Post.dart';
import 'package:flutterapp/reusable_widget/toast.dart';
import 'package:flutterapp/services/api.dart';
import 'package:flutterapp/util/Preferences.dart';

class TableView extends StatefulWidget {
  TableView({super.key});

  @override
  _TableViewState createState() => _TableViewState();
}

class _TableViewState extends State<TableView> {
  List rowHeaders = [];
  List columnHeaders = [];
  Map selected = {};

  @override
  void initState() {
    super.initState();
    saveHeaders(); //Iterate and store all Row and column Headers
  }

  saveHeaders() {
    //Saving All Headers
    columnHeaders.addAll([
      "Rất nhiều",
      "Nhiều",
      "Vừa  vừa",
      "Có 1 chút",
      "Không hề",
    ]);
    rowHeaders.addAll([
      "Cảm thấy cô đơn",
      'Mất hứng thú với gia đình ,bạn bè , đồng nghiệp',
      "Thấy mình vô dụng , kém cỏi , tự ti vào bản thân",
      "Khó ngủ , ngủ hay tỉnh giấc , ngủ quá nhiều",
      "Luôn cảm thấy vô vọng , chán nản",
      "Luôn thèm ăn , lúc chẳng ăn",
      "Có suy nghĩ kết thúc cuộc đời mình",
      "Có kế hoạch làm hại bản thân",
      "Sức khỏe tụt giảm nghiêm trọng",
    ]);
  }

  bool check() {
    for (String b in rowHeaders) {
      if (selected[b] == null) return false;
    }
    return true;
  }

  int calcDepression() {
    int a = 0;
    for (String b in rowHeaders) {
      int temp = selected[b] ?? 0;
      a = a + temp;
    }
    return a ~/ rowHeaders.length;
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return new Scaffold(
        body: new OrientationBuilder(builder: (context, orientation) {
      return Stack(
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.white),
            child: Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Container(
                          padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
                          alignment: FractionalOffset.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              //headers
                              new Container(
                                margin: EdgeInsets.all(0.0),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Color.fromRGBO(168, 195, 230, 1),
                                        width: 5),
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                                child: new Row(
                                    children: [
                                      new Container(
                                        alignment: FractionalOffset.center,
                                        width: 200.0,
                                        height: 80.0,
                                        margin: EdgeInsets.all(0.0),
                                        padding: const EdgeInsets.only(
                                            top: 5.0, bottom: 5.0, right: 3.0, left: 3.0),
                                        child: Text(
                                          //Leave an empty text in Row(0) and Column (0)
                                          "",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: "Paytone One",
                                              fontWeight: FontWeight.w100),
                                          textAlign: TextAlign.center,
                                        ),
                                      )
                                    ]..addAll(columnHeaders
                                        .map((header) => new Container(
                                      alignment: FractionalOffset.center,
                                      width: 120.0,
                                      height: 80.0,
                                      margin: EdgeInsets.all(0.0),
                                      padding: const EdgeInsets.only(
                                          top: 5.0,
                                          bottom: 5.0,
                                          right: 3.0,
                                          left: 3.0),
                                      child: new Text(
                                        header,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "Paytone One",
                                            fontWeight: FontWeight.w100),
                                        textAlign: TextAlign.center,
                                      ),
                                    ))
                                        .toList())),
                              ),
                            ],
                          ),
                        )
                      ]..addAll(createRows()), //Create Rows
                    ),
                  ),
                )
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Button(
              text: "Next",
              onPress: () async {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return WillPopScope(
                          child: Dialog(
                            backgroundColor: Colors.transparent,
                            child: Container(
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          ),
                          onWillPop: () async => false);
                    });
                await Future.delayed(Duration(seconds: 1));
                if (!check()) {
                  Navigator.pop(context);
                  ToastNoti.show("Bạn hãy điền đầy đủ thông tin");
                  return;
                }
                int val = calcDepression();
                if (!kReleaseMode) {
                  print("Depression Value: $val");
                }
                Map<String, dynamic> data = {
                  "userId": Preferences.getId(),
                  "level": val
                };
                if (!kReleaseMode) {
                  print("Posting User Depression Level:");
                }
                var temp1 = await Api().postData("Test", data);
                if (!kReleaseMode) {
                  print("Data: $temp1");
                }
                if (!kReleaseMode) {
                  print("Posting User Depression Level:");
                }
                var temp = await Api().postData("levelDepression", data);
                if (!kReleaseMode) {
                  print("Data: $temp");
                }
                Navigator.pop(context);
                Navigator.pushReplacementNamed(
                    context, "/GeneratedMainScreenWidget");
              },
            ),
          )
        ],
      );
    }));
  }

  List<Widget> createRows() {
    List<Widget> allRows = []; //For Saving all Created Rows

    for (int i = 0; i < rowHeaders.length; i++) {
      List<Widget> singleRow = []; //For creating a single row
      for (int j = 0; j < columnHeaders.length; j++) {
        singleRow.add(Container(
            alignment: FractionalOffset.center,
            decoration: BoxDecoration(
                border: Border.all(
                    color: Color.fromRGBO(168, 195, 230, 1), width: 5),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            width: 120.0,
            height: 50.0,
            padding: const EdgeInsets.only(
                top: 6.0, bottom: 6.0, right: 3.0, left: 3.0),
            child: Radio(
              value: j, //Index of created Radio Button
              groupValue: selected[rowHeaders[i]] !=
                      null //If groupValue is equal to value, the radioButton will be selected
                  ? selected[rowHeaders[i]]
                  : "",
              onChanged: (value) {
                this.setState(() {
                  selected[rowHeaders[i]] =
                      value; //Adding selected rowName with its Index in a Map tagged "selected"
                  print("${rowHeaders[i]} ==> $value");
                });
              },
            )));
      }
      //Adding single Row to allRows widget
      allRows.add(new Container(
          child: new Row(
            children: [
              Container(
            alignment: FractionalOffset.centerLeft,
            decoration: BoxDecoration(
                border: Border.all(
                    color: Color.fromRGBO(168, 195, 230, 1), width: 5),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            width: 200.0,
            height: 80.0,
            padding: const EdgeInsets.only(
                top: 6.0, bottom: 6.0, right: 3.0, left: 10.0),
            child: Center(
              child: Text(rowHeaders[i],
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Paytone One",
                      fontWeight: FontWeight.w100)),
            ),
          )
            ]..addAll(singleRow), //Add single row here
          )));
    }
    return allRows; //Return all single rows
  }
}
