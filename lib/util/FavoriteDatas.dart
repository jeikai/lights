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

  void sendData() async {

  }
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
    color: Colors.transparent,
    child: Image.network(
      'https://storage.googleapis.com/lightskn/cloud.png',
      fit: BoxFit.cover,
      width: 200, // Đặt chiều rộng của hình ảnh
      height: 200, // Đặt chiều cao của hình ảnh
    ),
  ),
  Container(
    color: Colors.transparent,
    child: Image.network(
      'https://storage.googleapis.com/lightskn/windy.png',
      fit: BoxFit.cover,
      width: 200, // Đặt chiều rộng của hình ảnh
      height: 200, // Đặt chiều cao của hình ảnh
    ),
  ),
  Container(
    color: Colors.transparent,
    child: Image.network(
      'https://storage.googleapis.com/lightskn/sun.png',
      fit: BoxFit.cover,
      width: 200, // Đặt chiều rộng của hình ảnh
      height: 200, // Đặt chiều cao của hình ảnh
    ),
  ),
  Container(
    color: Colors.transparent,
    child: Image.network(
      'https://storage.googleapis.com/lightskn/cloud.png',
      fit: BoxFit.cover,
      width: 200, // Đặt chiều rộng của hình ảnh
      height: 200, // Đặt chiều cao của hình ảnh
    ),
  ),
  Container(
    color: Colors.transparent,
    child: Image.network(
      'https://storage.googleapis.com/lightskn/snow.png',
      fit: BoxFit.cover,
      width: 200, // Đặt chiều rộng của hình ảnh
      height: 200, // Đặt chiều cao của hình ảnh
    ),
  ),
  Container(
    color: Colors.transparent,
    child: Image.network(
      'https://storage.googleapis.com/lightskn/rain.png',
      fit: BoxFit.cover,
      width: 200, // Đặt chiều rộng của hình ảnh
      height: 200, // Đặt chiều cao của hình ảnh
    ),
  ),
  Container(
    color: Colors.transparent,
    child: Image.network(
      'https://storage.googleapis.com/lightskn/colleague.png',
      fit: BoxFit.cover,
      width: 200, // Đặt chiều rộng của hình ảnh
      height: 200, // Đặt chiều cao của hình ảnh
    ),
  ),
  Container(
    color: Colors.transparent,
    child: Image.network(
      'https://storage.googleapis.com/lightskn/familiar.png',
      fit: BoxFit.cover,
      width: 200, // Đặt chiều rộng của hình ảnh
      height: 200, // Đặt chiều cao của hình ảnh
    ),
  ),
  Container(
    color: Colors.transparent,
    child: Image.network(
      'https://storage.googleapis.com/lightskn/family.png',
      fit: BoxFit.cover,
      width: 200, // Đặt chiều rộng của hình ảnh
      height: 200, // Đặt chiều cao của hình ảnh
    ),
  ),
  Container(
    color: Colors.transparent,
    child: Image.network(
      'https://storage.googleapis.com/lightskn/friend.png',
      fit: BoxFit.cover,
      width: 200, // Đặt chiều rộng của hình ảnh
      height: 200, // Đặt chiều cao của hình ảnh
    ),
  ),
  Container(
    color: Colors.transparent,
    child: Image.network(
      'https://storage.googleapis.com/lightskn/none.png',
      fit: BoxFit.cover,
      width: 200, // Đặt chiều rộng của hình ảnh
      height: 200, // Đặt chiều cao của hình ảnh
    ),
  ),
  Container(
    color: Colors.transparent,
    child: Image.network(
      'https://storage.googleapis.com/lightskn/film.png',
      fit: BoxFit.cover,
      width: 200, // Đặt chiều rộng của hình ảnh
      height: 200, // Đặt chiều cao của hình ảnh
    ),
  ),
  Container(
    color: Colors.transparent,
    child: Image.network(
      'https://storage.googleapis.com/lightskn/book.png',
      fit: BoxFit.cover,
      width: 200, // Đặt chiều rộng của hình ảnh
      height: 200, // Đặt chiều cao của hình ảnh
    ),
  ),
  Container(
    color: Colors.transparent,
    child: Image.network(
      'https://storage.googleapis.com/lightskn/picnic.png',
      fit: BoxFit.cover,
      width: 200, // Đặt chiều rộng của hình ảnh
      height: 200, // Đặt chiều cao của hình ảnh
    ),
  ),
  Container(
    color: Colors.transparent,
    child: Image.network(
      'https://storage.googleapis.com/lightskn/sport.png',
      fit: BoxFit.cover,
      width: 200, // Đặt chiều rộng của hình ảnh
      height: 200, // Đặt chiều cao của hình ảnh
    ),
  ),
  Container(
    color: Colors.transparent,
    child: Image.network(
      'https://storage.googleapis.com/lightskn/cloud.png',
      fit: BoxFit.cover,
      width: 200, // Đặt chiều rộng của hình ảnh
      height: 200, // Đặt chiều cao của hình ảnh
    ),
  ),
  Container(
    color: Colors.transparent,
    child: Image.network(
      'https://storage.googleapis.com/lightskn/game.png',
      fit: BoxFit.cover,
      width: 200, // Đặt chiều rộng của hình ảnh
      height: 200, // Đặt chiều cao của hình ảnh
    ),
  ),
  Container(
    color: Colors.transparent,
    child: Image.network(
      'https://storage.googleapis.com/lightskn/cloud.png',
      fit: BoxFit.cover,
      width: 200, // Đặt chiều rộng của hình ảnh
      height: 200, // Đặt chiều cao của hình ảnh
    ),
  ),
  Container(
    color: Colors.transparent,
    child: Image.network(
      'https://storage.googleapis.com/lightskn/delivery.png',
      fit: BoxFit.cover,
      width: 200, // Đặt chiều rộng của hình ảnh
      height: 200, // Đặt chiều cao của hình ảnh
    ),
  ),
  Container(
    color: Colors.transparent,
    child: Image.network(
      'https://storage.googleapis.com/lightskn/fastfood.png',
      fit: BoxFit.cover,
      width: 200, // Đặt chiều rộng của hình ảnh
      height: 200, // Đặt chiều cao của hình ảnh
    ),
  ),
  Container(
    color: Colors.transparent,
    child: Image.network(
      'https://storage.googleapis.com/lightskn/healthyfood.png',
      fit: BoxFit.cover,
      width: 200, // Đặt chiều rộng của hình ảnh
      height: 200, // Đặt chiều cao của hình ảnh
    ),
  ),
  Container(
    color: Colors.transparent,
    child: Image.network(
      'https://storage.googleapis.com/lightskn/homemade.png',
      fit: BoxFit.cover,
      width: 200, // Đặt chiều rộng của hình ảnh
      height: 200, // Đặt chiều cao của hình ảnh
    ),
  ),
  Container(
    color: Colors.transparent,
    child: Image.network(
      'https://storage.googleapis.com/lightskn/restaurant.png',
      fit: BoxFit.cover,
      width: 200, // Đặt chiều rộng của hình ảnh
      height: 200, // Đặt chiều cao của hình ảnh
    ),
  ),
  Container(
    color: Colors.transparent,
    child: Image.network(
      'https://storage.googleapis.com/lightskn/nomeat.png',
      fit: BoxFit.cover,
      width: 200, // Đặt chiều rộng của hình ảnh
      height: 200, // Đặt chiều cao của hình ảnh
    ),
  ),
  Container(
    color: Colors.transparent,
    child: Image.network(
      'https://storage.googleapis.com/lightskn/nosugar.png',
      fit: BoxFit.cover,
      width: 200, // Đặt chiều rộng của hình ảnh
      height: 200, // Đặt chiều cao của hình ảnh
    ),
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
