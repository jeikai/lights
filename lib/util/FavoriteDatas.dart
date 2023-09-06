import 'package:flutter/material.dart';

class FavoriteWrapper {
  bool isChose;
  int _index;

  int get index => _index;

  FavoriteWrapper({this.isChose = false, required int index}) : _index = index;
}

class FavoriteData {
  late final List<FavoriteWrapper> _wrappers;

  FavoriteData() {
    _wrappers = List.generate(22, (index) => FavoriteWrapper(index: index));
  }

  FavoriteWrapper getWrapper(int index) => _wrappers[index];

  void setChose(int index, bool value) {
    _wrappers[index].isChose = value;
  }

  void sendData() async {}
}

List<String> mappingToString = [
  'Nắng',
  'Mây',
  'Tuyết',
  'Gió',
  'Mưa',
  'Bạn bè',
  'Gia đình',
  'Đồng nghiệp',
  'Người quen',
  'None',
  'Xem phim',
  'Đọc sách',
  'Chơi game',
  'Thể thao',
  'Du lịch',
  'Ăn lành mạnh',
  'Fastfood',
  'Homemade',
  'Restaurant',
  'Delivery',
  'No meat',
  'No sweets'
];

List<Widget> mappingToWidget = [
  Container(
    color: Colors.black,
  ),
  Container(
    color: Colors.black,
  ),
  Container(
    color: Colors.black,
  ),
  Container(
    color: Colors.black,
  ),
  Container(
    color: Colors.black,
  ),
  Container(
    color: Colors.black,
  ),
  Container(
    color: Colors.black,
  ),
  Container(
    color: Colors.black,
  ),
  Container(
    color: Colors.black,
  ),
  Container(
    color: Colors.black,
  ),
  Container(
    color: Colors.black,
  ),
  Container(
    color: Colors.black,
  ),
  Container(
    color: Colors.black,
  ),
  Container(
    color: Colors.black,
  ),
  Container(
    color: Colors.black,
  ),
  Container(
    color: Colors.black,
  ),
  Container(
    color: Colors.black,
  ),
  Container(
    color: Colors.black,
  ),
  Container(
    color: Colors.black,
  ),
  Container(
    color: Colors.black,
  ),
  Container(
    color: Colors.black,
  ),
  Container(
    color: Colors.black,
  ),
];

List<(int, int)> categories = [
  (0, 4),
  (5, 9),
  (10, 14),
  (15, 21),
];

List<String> categoriesNames = [
  'WEATHER',
  'ACQUAINTANCE',
  'ACTIVITY',
  'FOOD',
];

Widget getWidgetOfCategory(int cate, int index) {
  return mappingToWidget[getGlobalIndex(cate, index)];
}

int getCategorySize(int index) {
  assert(index < categoriesNames.length && index >= 0);
  var bound = categories[index];
  return bound.$2 - bound.$1 + 1;
}

int getCategoryIndex(String name) {
  return categoriesNames.indexOf(name);
}

int getGlobalIndex(int cate, int index) {
  assert(cate < categoriesNames.length && cate >= 0);
  assert(index >= 0 && index < getCategorySize(cate));
  return categories[cate].$1 + index;
}

bool isTLC(int cate) {
  return cate == 4 - 1;
}
