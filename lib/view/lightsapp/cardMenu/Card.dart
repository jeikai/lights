import 'package:flutter/material.dart';

class Cardd {
  String id = "";
  String userI;
  String cardId;
  String description;
  int isCompleted;
  int _isScanned;
  String answer;

  Cardd(
      {
      required this.id,
        this.userI = "",
       this.cardId = "",
      required this.description,
      required this.isCompleted,
      required int isScanned,
      required this.answer}): _isScanned = isScanned;

  //make an isScanned getter that returns a bool
  bool get isScanned => _isScanned == 1;


  @override
  String toString() {
    return 'Cardd{userI: $userI, cardId: $cardId, description: $description, isCompleted: $isCompleted, isScanned: $isScanned, answer: $answer}';
  }

  static Cardd map(Map data) {
    return Cardd(
      id: data['_id'],
      userI: data['user_id'],
      cardId: data['card_id'],
      description: data['description'],
      isCompleted: data['is_completed'],
      isScanned: data['is_scanned'],
      answer: data['answer'],
    );
  }
}
