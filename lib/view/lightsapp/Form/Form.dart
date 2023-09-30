import 'package:flutter/material.dart';
import 'package:flutterapp/reusable_widget/Button_Post.dart';

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
      "Không hề",
      "Có 1 chút",
      "Vừa  vừa",
      "Nhiều",
      "Rất nhiều",
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

  int calcDepression() {
    int a = 0;
    for (String b in rowHeaders) {
      int temp = selected[b] ?? 0;
      a = a + temp;
    }

    return a ~/ rowHeaders.length;
  }

  Widget build(BuildContext context) {
    return new Scaffold(
        body: new OrientationBuilder(builder: (context, orientation) {
          return Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.white
                ),
                child: Center(
                    child: SingleChildScrollView(
                      scrollDirection: orientation ==
                          Orientation
                              .portrait //Handle Scroll when Orientation is changed
                          ? Axis.horizontal
                          : Axis.vertical,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Container(
                            color: Colors.blueGrey[200],
                            padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
                            alignment: FractionalOffset.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                //headers
                                new Container(
                                  margin: EdgeInsets.all(0.0),
                                  child: new Row(
                                      children: [
                                        new Container(
                                          alignment: FractionalOffset.center,
                                          width: 140.0,
                                          margin: EdgeInsets.all(0.0),
                                          padding: const EdgeInsets.only(
                                              top: 5.0, bottom: 5.0, right: 3.0, left: 3.0),
                                          child: Text(
                                            //Leave an empty text in Row(0) and Column (0)
                                            "",
                                            style: TextStyle(color: Colors.grey[800]),
                                            textAlign: TextAlign.center,
                                          ),
                                        )
                                      ]..addAll(columnHeaders
                                          .map((header) => new Container(
                                        alignment: FractionalOffset.center,
                                        width: 120.0,
                                        margin: EdgeInsets.all(0.0),
                                        padding: const EdgeInsets.only(
                                            top: 5.0,
                                            bottom: 5.0,
                                            right: 3.0,
                                            left: 3.0),
                                        child: new Text(
                                          header,
                                          style:
                                          TextStyle(color: Colors.grey[800]),
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
                    )),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Button(
                  text: "Next",
                  onPress: () {
                    print(calcDepression());
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
            width: 120.0,
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
          new Container(
            alignment: FractionalOffset.centerLeft,
            width: 140.0,
            padding: const EdgeInsets.only(
                top: 6.0, bottom: 6.0, right: 3.0, left: 10.0),
            child:
                Text(rowHeaders[i], style: TextStyle(color: Colors.grey[800])),
          )
        ]..addAll(singleRow), //Add single row here
      )));
    }
    return allRows; //Return all single rows
  }
}
