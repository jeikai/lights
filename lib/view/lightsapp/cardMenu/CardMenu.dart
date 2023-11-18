import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutterapp/services/api.dart';
import 'package:flutterapp/util/image/ImageManager.dart';
import 'package:flutterapp/util/rive/RiveUtil.dart';
import 'package:flutterapp/view/lightsapp/cardMenu/Card.dart';
import 'package:rive/rive.dart';




class CardMenu extends StatefulWidget {
  const CardMenu({super.key});

  @override
  State<CardMenu> createState() => _CardMenuState();
}

class _CardMenuState extends State<CardMenu> {

  Future<List<Cardd>?> fetchCards() async {
    try{
      print("Fetching cards");
      List<Cardd> cards = await Api().getCards();
      print("Cards fetched: $cards");
      // List<Cardd> cards = [
      //   Cardd(
      //     description: "This is a card",
      //     isCompleted: 0,
      //     isScanned: 0,
      //     answer: "This is an answer"
      //   ),
      //   Cardd(
      //     description: "This is a card",
      //     isCompleted: 0,
      //     isScanned: 0,
      //     answer: "This is an answer"
      //   ),
      //   Cardd(
      //     description: "This is a card",
      //     isCompleted: 0,
      //     isScanned: 0,
      //     answer: "This is an answer"
      //   ),
      //   Cardd(
      //     description: "This is a card",
      //    isCompleted: 0,
      //     isScanned: 0,
      //     answer: "This is an answer"
      //   ),
      //   Cardd(
      //     description: "This is a card",
      //     isCompleted: 0,
      //     isScanned: 0,
      //     answer: "This is an answer"
      //   ),
      //   Cardd(
      //     description: "This is a card",
      //     isCompleted: 0,
      //     isScanned: 1,
      //     answer: "This is an answer"
      //   ),
      //   Cardd(
      //     description: "This is a card",
      //     isCompleted: 0,
      //     isScanned: 0,
      //     answer: "This is an answer"
      //   ),
      //   Cardd(
      //     description: "This is a card",
      //     isCompleted: 0,
      //     isScanned: 0,
      //     answer: "This is an answer"
      //   ),
      //   Cardd(
      //     description: "This is a card",
      //     isCompleted: 0,
      //     isScanned: 0,
      //     answer: "This is an answer"
      //   ),
      //   Cardd(
      //       description: "This is a card",
      //       isCompleted: 0,
      //       isScanned: 0,
      //       answer: "This is an answer"
      //   ),
      //   Cardd(
      //       description: "This is a card",
      //       isCompleted: 0,
      //       isScanned: 0,
      //       answer: "This is an answer"
      //   ),
      //   Cardd(
      //       description: "This is a card",
      //       isCompleted: 0,
      //       isScanned: 0,
      //       answer: "This is an answer"
      //   ),
      //   Cardd(
      //       description: "This is a card",
      //       isCompleted: 0,
      //       isScanned: 0,
      //       answer: "This is an answer"
      //   ),
      //   Cardd(
      //       description: "This is a card",
      //       isCompleted: 0,
      //       isScanned: 0,
      //       answer: "This is an answer"
      //   ),
      //   Cardd(
      //       description: "This is a card",
      //       isCompleted: 0,
      //       isScanned: 1,
      //       answer: "This is an answer"
      //   ),
      //   Cardd(
      //       description: "This is a card",
      //       isCompleted: 0,
      //       isScanned: 0,
      //       answer: "This is an answer"
      //   ),
      //   Cardd(
      //       description: "This is a card",
      //       isCompleted: 0,
      //       isScanned: 0,
      //       answer: "This is an answer"
      //   ),
      //   Cardd(
      //       description: "This is a card",
      //       isCompleted: 0,
      //       isScanned: 0,
      //       answer: "This is an answer"
      //   ),
      //   Cardd(
      //       description: "This is a card",
      //       isCompleted: 0,
      //       isScanned: 0,
      //       answer: "This is an answer"
      //   ),
      //   Cardd(
      //       description: "This is a card",
      //       isCompleted: 0,
      //       isScanned: 0,
      //       answer: "This is an answer"
      //   ),
      //   Cardd(
      //       description: "This is a card",
      //       isCompleted: 0,
      //       isScanned: 0,
      //       answer: "This is an answer"
      //   ),
      //   Cardd(
      //       description: "This is a card",
      //       isCompleted: 0,
      //       isScanned: 0,
      //       answer: "This is an answer"
      //   ),
      //   Cardd(
      //       description: "This is a card",
      //       isCompleted: 0,
      //       isScanned: 0,
      //       answer: "This is an answer"
      //   ),
      //   Cardd(
      //       description: "This is a card",
      //       isCompleted: 0,
      //       isScanned: 1,
      //       answer: "This is an answer"
      //   ),
      //   Cardd(
      //       description: "This is a card",
      //       isCompleted: 0,
      //       isScanned: 0,
      //       answer: "This is an answer"
      //   ),
      //   Cardd(
      //       description: "This is a card",
      //       isCompleted: 0,
      //       isScanned: 0,
      //       answer: "This is an answer"
      //   ),
      //   Cardd(
      //       description: "This is a card",
      //       isCompleted: 0,
      //       isScanned: 0,
      //       answer: "This is an answer"
      //   )
      // ];
      return cards;
    }catch(e){
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
          alignment: Alignment.center,
          children: [
            RiveAnimation.direct(
              RiveUtil.BGONE,
              fit: BoxFit.fill,
            ),
            FutureBuilder(future: fetchCards() , builder: (context, snapshot){
              if(snapshot.hasData){
                return CardTable(list: snapshot.data as List<Cardd>);
              }else{
                return WillPopScope(
                    child: Dialog(
                      backgroundColor: Colors.transparent,
                      child: Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ),
                    onWillPop: () async => false
                );
              }
            })
          ]
      ),
    );
  }
}

class CardTable extends StatelessWidget {
  final List<Cardd> list;
  const CardTable({super.key, required this.list});

  List<TableRow> buidTable() {
    List<TableRow> list = [];
    for(int i = 0; i < this.list.length; i++) {
      List<Widget> row = [];
      for(; i < this.list.length && row.length < 3; i++) {
        row.add(Padding(padding: EdgeInsets.all(8), child: CarddWidget(card: this.list[i])));
      }
      if(row.length < 3) {
        for(; row.length < 3; row.add(Container())) {}
      }
      list.add(TableRow(
        children: row
      ));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    double a = (size.width + size.height) / 2;
    //a Column with 2 child, first is a text to display the title, second is a Table with 3 column and a dynamic number of row, each row is a CarddWidget
    return Column(
      children: [
        Container(
          width: size.width / 2,
          //decoration with a round-edge border
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1),
            borderRadius: BorderRadius.all(Radius.elliptical(100, 50)),
            color: Color.fromARGB(255, 250,241,255)
          ),
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.only(top: 16, bottom: 16, left: 16, right: 16),
          child: Text(
            'BỘ SƯU TẬP',
            style: TextStyle(
              fontSize: a/30,
              fontWeight: FontWeight.bold,
              fontFamily: "Paytone One",
              color: Colors.black
            ),
            textAlign: TextAlign.center
          ),
        ),
        Expanded(child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Table(
                children: buidTable(),
              ),
            )
        ))
      ],
    );
  }
}

class CarddWidget extends StatelessWidget {
  final Cardd card;
  const CarddWidget({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if(!card.isScanned) return;
        Navigator.push(context, MaterialPageRoute(builder: (context) => CardDetail(card: card)));
      },
      child: Container(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.memory(
              ImageManager().getBytes(ImageManager.card)!,
              //make image gray if is not scanned
              color: card.isScanned ? null : Colors.grey,
              colorBlendMode: BlendMode.saturation,
            ),
            if(card.isCompleted)
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.all(Radius.circular(100))
                ),
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 50,
                )
              )
          ],
        ),
      ),
    );
  }
}

//a Card detail widget with a text field to edit the answer at the bottom and a text to display the description on top, a back button and a tick button in the middle, with a dedicated Theme of random Pastels color
class CardDetail extends StatefulWidget {
  final Cardd card;
  const CardDetail({super.key, required this.card});

  @override
  State<CardDetail> createState() => _CardDetailState();
}

class _CardDetailState extends State<CardDetail> {
  get card => widget.card;

  var a;
  var focus = FocusNode(canRequestFocus: true);
  late final TextEditingController controller;
  ValueNotifier<bool> isFocus = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    a = getRandomPastelColor();
    controller = TextEditingController(text: card.answer);
  }

  (Color, Color, Color) getRandomPastelColor() {
    Random random = new Random(DateTime.now().microsecond);
    int red = random.nextInt(256);
    int green = random.nextInt(256);
    int blue = random.nextInt(256);
    Color color = new Color.fromARGB(255, (red + 255) ~/ 2, (green + 255) ~/ 2, (blue + 255) ~/ 2);
    Color roloc = new Color.fromARGB(255, red ~/2, green ~/2, blue ~/2);
    Color locro = new Color.fromARGB(255, (red + 255*3) ~/4, (green + 255*3) ~/4, (blue + 255*3) ~/4);
    return (color, roloc, locro);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    //a TextStyle with align center and text size fit it parent bounds and center vertically
    Widget child = Container(
      //make the Container fit parent
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
        color: a.$1,
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: size.height / 8),
            child: Text(
              "Question",
              style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  fontFamily: "SuperComic",
                  color: a.$2
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: size.height / 16, vertical: size.width / 8),
            height: size.height / 8,
            child: Center(
              child: Text(
                  card.description,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: size.width / 15,
                      fontWeight: FontWeight.bold,
                      fontFamily: "DFVNDoris",
                      color: Color.fromARGB(255, 16,52,80)
                  )
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: size.height / 25),
            child: //a tick button
            GestureDetector(
              onTap: () async {
                print("Submit");
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
                String answer = (await Api().updateCard(card.id, controller.text))!["message"];
                print("Answer: $answer");
                Navigator.pop(context);
                Navigator.pop(context);
                print("Clicked");
              },
              child: Container(
                width: size.width / 8,
                height: size.width / 8,
                decoration: BoxDecoration(
                    color: a.$2,
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    border: Border.all(color: a.$2, width: 3)
                ),
                child: Center(
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: size.width / 10,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            //a text field to edit the answer without underline
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: size.width / 16, vertical: size.width / 14),
              padding: EdgeInsets.symmetric(horizontal: size.width / 16, vertical: size.width /25),
              decoration: BoxDecoration(
                  color: a.$3,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  border: Border.all(color: a.$2, width: 3)
              ),
              child: SingleChildScrollView(
                child: TextField(
                  key: Key("textfield"),
                  focusNode: focus,
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: 'Điền ở đây...',
                    hintStyle: TextStyle(
                        fontSize: size.width / 25,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Paytone One",
                        color: Color.fromARGB(255, 16,52,80)
                    ),
                    border: InputBorder.none,
                  ),
                  maxLines: null,
                  minLines: 12,
                  style: TextStyle(
                      fontSize: size.width / 25,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Paytone One",
                      color: Color.fromARGB(255, 16,52,80)
                  ),),
                ),
              ),
            ),
        ],
      ),
    );
    return Material(
      child: Stack(
        children: [
          child,
          Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: BackButton(),
              )
          )
        ],
      ),
    );
  }
}




