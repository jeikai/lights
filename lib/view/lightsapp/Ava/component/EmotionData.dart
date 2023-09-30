import 'package:collection/collection.dart';
import 'package:flutterapp/services/api.dart';
import 'package:flutterapp/util/Preferences.dart';

class EmotionData {
  final double x;
  final double y;

  EmotionData({required this.x, required this.y});
}

Future<List<double>> getDataFromApi() async {
  String id = Preferences.getId()!;
  final api = await Api().getDataByIdForChart("emotionChart", id);

  if (api != null) {
    // Chuyển danh sách dữ liệu từ dynamic sang double
    final List<double> doubleList = api.map<double>((item) {
      return item.toDouble();
    }).toList();

    return doubleList;
  } else {
    // Trường hợp có lỗi, trả về một danh sách trống hoặc thông báo lỗi tùy bạn
    return <double>[];
  }
}

List<EmotionData> getEmotionDatas(List<double> data2) {
  print(data2);
  return data2
      .mapIndexed(
          (index, element) => EmotionData(x: index.toDouble(), y: element))
      .toList();
}
