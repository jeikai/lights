import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutterapp/services/api.dart';
import 'package:flutterapp/util/Preferences.dart';
import 'package:flutterapp/util/image/ImageManager.dart';
import 'package:flutterapp/util/rive/RiveUtil.dart';
import 'package:flutterapp/view/lightsapp/Form/Form.dart';
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

      //List<Cardd> cards = (await Api().getDataUsersById("getUserCard", Preferences.getId()!))!.map<Cardd>((_element) => Cardd.map(_element)).toList();

      List<Cardd> cards = [
        Cardd(
          description: "This is a card",
          isCompleted: 0,
          isScanned: 0,
          answer: "This is an answer"
        ),
        Cardd(
          description: "This is a card",
          isCompleted: 0,
          isScanned: 0,
          answer: "This is an answer"
        ),
        Cardd(
          description: "This is a card",
          isCompleted: 0,
          isScanned: 0,
          answer: "This is an answer"
        ),
        Cardd(
          description: "This is a card",
         isCompleted: 0,
          isScanned: 0,
          answer: "This is an answer"
        ),
        Cardd(
          description: "This is a card",
          isCompleted: 0,
          isScanned: 0,
          answer: "This is an answer"
        ),
        Cardd(
          description: "This is a card",
          isCompleted: 0,
          isScanned: 1,
          answer: "This is an answer"
        ),
        Cardd(
          description: "This is a card",
          isCompleted: 0,
          isScanned: 0,
          answer: "This is an answer"
        ),
        Cardd(
          description: "This is a card",
          isCompleted: 0,
          isScanned: 0,
          answer: "This is an answer"
        ),
        Cardd(
          description: "This is a card",
          isCompleted: 0,
          isScanned: 0,
          answer: "This is an answer"
        ),
        Cardd(
            description: "This is a card",
            isCompleted: 0,
            isScanned: 0,
            answer: "This is an answer"
        ),
        Cardd(
            description: "This is a card",
            isCompleted: 0,
            isScanned: 0,
            answer: "This is an answer"
        ),
        Cardd(
            description: "This is a card",
            isCompleted: 0,
            isScanned: 0,
            answer: "This is an answer"
        ),
        Cardd(
            description: "This is a card",
            isCompleted: 0,
            isScanned: 0,
            answer: "This is an answer"
        ),
        Cardd(
            description: "This is a card",
            isCompleted: 0,
            isScanned: 0,
            answer: "This is an answer"
        ),
        Cardd(
            description: "This is a card",
            isCompleted: 0,
            isScanned: 1,
            answer: "This is an answer"
        ),
        Cardd(
            description: "This is a card",
            isCompleted: 0,
            isScanned: 0,
            answer: "This is an answer"
        ),
        Cardd(
            description: "This is a card",
            isCompleted: 0,
            isScanned: 0,
            answer: "This is an answer"
        ),
        Cardd(
            description: "This is a card",
            isCompleted: 0,
            isScanned: 0,
            answer: "This is an answer"
        ),
        Cardd(
            description: "This is a card",
            isCompleted: 0,
            isScanned: 0,
            answer: "This is an answer"
        ),
        Cardd(
            description: "This is a card",
            isCompleted: 0,
            isScanned: 0,
            answer: "This is an answer"
        ),
        Cardd(
            description: "This is a card",
            isCompleted: 0,
            isScanned: 0,
            answer: "This is an answer"
        ),
        Cardd(
            description: "This is a card",
            isCompleted: 0,
            isScanned: 0,
            answer: "This is an answer"
        ),
        Cardd(
            description: "This is a card",
            isCompleted: 0,
            isScanned: 0,
            answer: "This is an answer"
        ),
        Cardd(
            description: "This is a card",
            isCompleted: 0,
            isScanned: 1,
            answer: "This is an answer"
        ),
        Cardd(
            description: "This is a card",
            isCompleted: 0,
            isScanned: 0,
            answer: "This is an answer"
        ),
        Cardd(
            description: "This is a card",
            isCompleted: 0,
            isScanned: 0,
            answer: "This is an answer"
        ),
        Cardd(
            description: "This is a card",
            isCompleted: 0,
            isScanned: 0,
            answer: "This is an answer"
        )
      ];
      return cards;
    }catch(e){
      print(e);
      return null;
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
            FutureBuilder(future: fetchCards(), builder: (context, snapshot){
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
    return Container(
      child: Stack(
        children: [
          Image.memory(
            ImageManager().getBytes(ImageManager.card)!,
            //make image gray if is not scanned
            color: card.isScanned ? null : Colors.grey,
            colorBlendMode: BlendMode.saturation,
          )
        ],
      ),
    );
  }
}

//a Card detail widget with a text field to edit the answer at the bottom and a text to display the description on top, a back button and a tick button in the middle, with a dedicated Theme of random Pastels color
class CardDetail extends StatelessWidget {
  final Cardd card;
  const CardDetail({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            card.description,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Text(
            card.answer,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.arrow_back_rounded,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.check,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          )
        ],
      ),
    );
  }
}

//a Card edit widget with a text field to edit the description at the top and a text field to edit the answer at the bottom, a back button and a tick button in the middle, with a dedicated Theme of random Pastels color
class CardEdit extends StatelessWidget {
  final Cardd card;
  const CardEdit({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            card.description,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Text(
            card.answer,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.arrow_back_rounded,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.check,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          )
        ],
      ),
    );
  }
}

class CardAdd extends StatelessWidget {
  final Cardd card;

  const CardAdd({super.key, required this.card});
  
  
  Color generateRandomColor(Color? mix) {
    Random random = new Random();
    int red = random.nextInt(256);
    int green = random.nextInt(256);
    int blue = random.nextInt(256);

    // mix the color
    if (mix != null) {
      red = ((red + mix.red) / 2) as int;
      green = ((green + mix.green) / 2) as int;
      blue = ((blue + mix.blue) / 2) as int;
    }

    Color color = new Color.fromARGB(255, red, green, blue);
    return color;
  }

  @override
  Widget build(BuildContext context) {

    //generate random pastel color
    Color color = generateRandomColor(null);

    return Scaffold(
      //apply generated color as theme

        appBar: AppBar(
          title: Text('Edit Card'),
        ),

        body: Padding(
          padding: const EdgeInsets.all(16.0),

          child: Column(
            children: [

              //description text field
              TextField(
                decoration: InputDecoration(labelText: 'Description'),
                onChanged: (value) => card.description = value,
              ),

              SizedBox(height: 24),

              //buttons row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  //back button
                  ElevatedButton(
                      onPressed: () {},
                      child: Text('Back')
                  ),

                  //tick button
                  ElevatedButton(
                      onPressed: () {},
                      child: Text('Tick')
                  )

                ],
              ),

              SizedBox(height: 24),

              //answer text field
              TextField(
                decoration: InputDecoration(labelText: 'Answer'),
                onChanged: (value) => card.answer = value,
              )

            ],
          ),
        )
    );
  }
}



