import 'package:collection/collection.dart';

class EmotionData {
  final double x;
  final double y;

  EmotionData({required this.x, required this.y});
}

List<EmotionData> get emotionDatas {
  final data = <double>[2, 3, 4, 5];
  return data
      .mapIndexed(
          (index, element) => EmotionData(x: index.toDouble(), y: element))
      .toList();
}
