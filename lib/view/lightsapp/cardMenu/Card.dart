
class Cardd {
  String id = "";
  String userI;
  String cardId;
  String description;
  int _isCompleted;
  int _isScanned;
  String answer;

  Cardd(
      {
      required this.id,
        this.userI = "",
       this.cardId = "",
      required this.description,
      required int isCompleted,
      required int isScanned,
      required this.answer}): _isScanned = isScanned, _isCompleted = isCompleted;

  //make an isScanned getter that returns a bool
  bool get isScanned => _isScanned == 1;
  bool get isCompleted => _isCompleted == 1;

  @override
  String toString() {
    return 'Cardd{userI: $userI, cardId: $cardId, description: $description, isCompleted: $isCompleted, isScanned: $isScanned, answer: $answer}';
  }

  static Cardd map(Map data) {
    return Cardd(
      id: data['_id'],
      userI: data['userId'],
      cardId: data['cardId'],
      description: data['description'],
      isCompleted: data['isCompleted'],
      isScanned: data['isScanned'],
      answer: data['answer'],
    );
  }
}
