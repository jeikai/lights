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
      'https://res.cloudinary.com/dycsfcnso/image/upload/v1723397825/lights/images/favorite/windy_v2joja.png',
      fit: BoxFit.cover,
      width: 200, // Đặt chiều rộng của hình ảnh
      height: 200, // Đặt chiều cao của hình ảnh
    ),
  ),
  Container(
    color: Colors.transparent,
    child: Image.network(
      'https://res.cloudinary.com/dycsfcnso/image/upload/v1723397824/lights/images/favorite/sun_doumx7.png',
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
      'https://res.cloudinary.com/dycsfcnso/image/upload/v1723397824/lights/images/favorite/snow_lgcebr.png',
      fit: BoxFit.cover,
      width: 200, // Đặt chiều rộng của hình ảnh
      height: 200, // Đặt chiều cao của hình ảnh
    ),
  ),
  Container(
    color: Colors.transparent,
    child: Image.network(
      'https://res.cloudinary.com/dycsfcnso/image/upload/v1723397824/lights/images/favorite/rain_eqthia.png',
      fit: BoxFit.cover,
      width: 200, // Đặt chiều rộng của hình ảnh
      height: 200, // Đặt chiều cao của hình ảnh
    ),
  ),
  Container(
    color: Colors.transparent,
    child: Image.network(
      'https://res.cloudinary.com/dycsfcnso/image/upload/v1723397823/lights/images/favorite/colleague_vjbd4y.png',
      fit: BoxFit.cover,
      width: 200, // Đặt chiều rộng của hình ảnh
      height: 200, // Đặt chiều cao của hình ảnh
    ),
  ),
  Container(
    color: Colors.transparent,
    child: Image.network(
      'https://res.cloudinary.com/dycsfcnso/image/upload/v1723397825/lights/images/favorite/familiar_dw7r3a.png',
      fit: BoxFit.cover,
      width: 200, // Đặt chiều rộng của hình ảnh
      height: 200, // Đặt chiều cao của hình ảnh
    ),
  ),
  Container(
    color: Colors.transparent,
    child: Image.network(
      'https://res.cloudinary.com/dycsfcnso/image/upload/v1723397825/lights/images/favorite/family_wvt82e.png',
      fit: BoxFit.cover,
      width: 200, // Đặt chiều rộng của hình ảnh
      height: 200, // Đặt chiều cao của hình ảnh
    ),
  ),
  Container(
    color: Colors.transparent,
    child: Image.network(
      'https://res.cloudinary.com/dycsfcnso/image/upload/v1723397826/lights/images/favorite/friend_h4ichk.png',
      fit: BoxFit.cover,
      width: 200, // Đặt chiều rộng của hình ảnh
      height: 200, // Đặt chiều cao của hình ảnh
    ),
  ),
  Container(
    color: Colors.transparent,
    child: Image.network(
      'https://res.cloudinary.com/dycsfcnso/image/upload/v1723397826/lights/images/favorite/none_zfkghd.png',
      fit: BoxFit.cover,
      width: 200, // Đặt chiều rộng của hình ảnh
      height: 200, // Đặt chiều cao của hình ảnh
    ),
  ),
  Container(
    color: Colors.transparent,
    child: Image.network(
      'https://res.cloudinary.com/dycsfcnso/image/upload/v1723397826/lights/images/favorite/film_gpdble.png',
      fit: BoxFit.cover,
      width: 200, // Đặt chiều rộng của hình ảnh
      height: 200, // Đặt chiều cao của hình ảnh
    ),
  ),
  Container(
    color: Colors.transparent,
    child: Image.network(
      'https://res.cloudinary.com/dycsfcnso/image/upload/v1723397825/lights/images/favorite/book_jq9phc.png',
      fit: BoxFit.cover,
      width: 200, // Đặt chiều rộng của hình ảnh
      height: 200, // Đặt chiều cao của hình ảnh
    ),
  ),
  Container(
    color: Colors.transparent,
    child: Image.network(
      'https://res.cloudinary.com/dycsfcnso/image/upload/v1723397824/lights/images/favorite/picnic_fdmest.png',
      fit: BoxFit.cover,
      width: 200, // Đặt chiều rộng của hình ảnh
      height: 200, // Đặt chiều cao của hình ảnh
    ),
  ),
  Container(
    color: Colors.transparent,
    child: Image.network(
      'https://res.cloudinary.com/dycsfcnso/image/upload/v1723397825/lights/images/favorite/sport_jzyhu6.png',
      fit: BoxFit.cover,
      width: 200, // Đặt chiều rộng của hình ảnh
      height: 200, // Đặt chiều cao của hình ảnh
    ),
  ),
  Container(
    color: Colors.transparent,
    child: Image.network(
      'https://res.cloudinary.com/dycsfcnso/image/upload/v1723397823/lights/images/favorite/cloud_co3mxc.png',
      fit: BoxFit.cover,
      width: 200, // Đặt chiều rộng của hình ảnh
      height: 200, // Đặt chiều cao của hình ảnh
    ),
  ),
  Container(
    color: Colors.transparent,
    child: Image.network(
      'https://res.cloudinary.com/dycsfcnso/image/upload/v1723397826/lights/images/favorite/game_wzisxr.png',
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
      'https://res.cloudinary.com/dycsfcnso/image/upload/v1723397824/lights/images/favorite/delivery_dam8dy.png',
      fit: BoxFit.cover,
      width: 200, // Đặt chiều rộng của hình ảnh
      height: 200, // Đặt chiều cao của hình ảnh
    ),
  ),
  Container(
    color: Colors.transparent,
    child: Image.network(
      'https://res.cloudinary.com/dycsfcnso/image/upload/v1723397825/lights/images/favorite/fastfood_twflr3.png',
      fit: BoxFit.cover,
      width: 200, // Đặt chiều rộng của hình ảnh
      height: 200, // Đặt chiều cao của hình ảnh
    ),
  ),
  Container(
    color: Colors.transparent,
    child: Image.network(
      'https://res.cloudinary.com/dycsfcnso/image/upload/v1723397826/lights/images/favorite/healthyfood_a18eay.png',
      fit: BoxFit.cover,
      width: 200, // Đặt chiều rộng của hình ảnh
      height: 200, // Đặt chiều cao của hình ảnh
    ),
  ),
  Container(
    color: Colors.transparent,
    child: Image.network(
      'https://res.cloudinary.com/dycsfcnso/image/upload/v1723397827/lights/images/favorite/homemade_egh9tq.png',
      fit: BoxFit.cover,
      width: 200, // Đặt chiều rộng của hình ảnh
      height: 200, // Đặt chiều cao của hình ảnh
    ),
  ),
  Container(
    color: Colors.transparent,
    child: Image.network(
      'https://res.cloudinary.com/dycsfcnso/image/upload/v1723397824/lights/images/favorite/restaurant_dlmnx2.png',
      fit: BoxFit.cover,
      width: 200, // Đặt chiều rộng của hình ảnh
      height: 200, // Đặt chiều cao của hình ảnh
    ),
  ),
  Container(
    color: Colors.transparent,
    child: Image.network(
      'https://res.cloudinary.com/dycsfcnso/image/upload/v1723397826/lights/images/favorite/nomeat_uid0bt.png',
      fit: BoxFit.cover,
      width: 200, // Đặt chiều rộng của hình ảnh
      height: 200, // Đặt chiều cao của hình ảnh
    ),
  ),
  Container(
    color: Colors.transparent,
    child: Image.network(
      'https://res.cloudinary.com/dycsfcnso/image/upload/v1723397823/lights/images/favorite/nosugar_hxmul4.png',
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
