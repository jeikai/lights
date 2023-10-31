import 'package:flutter/material.dart';

class Cardd {
  String userI;
  String cardId;
  String description;
  int isCompleted;
  int _isScanned;
  String answer;

  Cardd(
      { this.userI = "",
       this.cardId = "",
      required this.description,
      required this.isCompleted,
      required int isScanned,
      required this.answer}): _isScanned = isScanned;

  //make an isScanned getter that returns a bool
  bool get isScanned => _isScanned == 1;

  static Cardd map(Map data) {
    return Cardd(
      userI: data['user_id'],
      cardId: data['card_id'],
      description: data['description'],
      isCompleted: data['is_completed'],
      isScanned: data['is_scanned'],
      answer: data['answer'],
    );
  }
}
