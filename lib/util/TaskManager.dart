import 'dart:math';

import 'package:flutterapp/util/Preferences.dart';

class TaskManager {
  static Future<void> updateTask(String emotion) async {
    List<String> a;
    switch (emotion) {
      case "CucVui":
        a = CUCVUI;
      case "Vui":
        a = VUI;
      case "BinhThuong":
        a = BINHTHUONG;
      case "Buon":
        a = BUON;
      case "CucBuon":
        a = CUCBUON;
      default:
        throw Exception("Unknown emotion for tasks: $emotion");
    }
    Random random = Random(DateTime.now().timeZoneOffset.inSeconds);
    List<String> ret = [];
    for (int i = 0; i < 4; i++) {
      String task = "";
      while (true) {
        int index = random.nextInt(a.length);
        task = a[index];
        print("task: $task");
        if (!ret.contains(task)) break;
        print("task-already-in-ret");
      }
      ret.add(task);
    }
    print("Tasks is: $ret");
    await Preferences.setTasks(ret);
    return;
  }

  static final List<String> CUCBUON = [
    "Nghe 1 bài nhạc từ kho nhạc của app",
    "Ngồi thiền 30p",
    "Ăn 1 món có cá/ bò/ trứng",
    "Uống 1 ly smoothie có hạt chia",
    "Tập thể dục 30p",
    "Uống 1 ly trà hoa cúc/ trà hoa hồng/trà chanh/trà bạc hà",
    "Gặp gỡ 1 người bạn",
    "Gặp/Thăm 1 thành viên yêu thích trong già đình",
    "Lau dọn nhà",
    "Đi bộ 20p",
    "Xem 1 bộ phim từ kho phim của app",
    "Tập 1 bài yoga cơ bản",
    "Ngủ 8 tiếng/ngày",
    "Chụp 3 bức ảnh",
    //"Viết nhật ký ( thời gian sau nv xuất hiện mỗi ngày)",
  ];
  static final List<String> BUON = [
    "Nghe 1 bài nhạc từ kho nhạc của app",
    "Ngồi thiền 30p",
    "Tập thể dục 30p",
    "Ăn 1 món có cá/ bò/ trứng",
    "Uống 1 ly trà hoa cúc/ trà hoa hồng/trà chanh/trà bạc hà",
    "Uống 1 ly smoothie có hạt chia",
    "Gặp gỡ 1 người bạn mới",
    "Gặp gỡ 1 người bạn",
    "Gặp/Thăm 1 thành viên yêu thích trong già đình",
    "Đi bộ 20p",
    "Xem 1 bộ phim từ kho phim của app",
    "Tập 1 bài yoga cơ bản",
    //"Đi 1 quán coffee/ coffee chó mèo ( nếu không dị ứng lông chó mèo)",
    "Ngủ 8 tiếng/ngày",
    //"Viết nhật ký ( thời gian sau nv xuất hiện mỗi ngày)",
    "Chơi 1 game trong kho game của app",
  ];
  static final List<String> BINHTHUONG = [
    "Nghe 1 bài nhạc từ kho nhạc của app",
    "Tập thể dục 30p",
    "Uống 1 ly trà hoa cúc/ trà hoa hồng/trà chanh/trà bạc hà",
    "Ăn 1 món có cá/ bò/ trứng",
    "Gặp gỡ 1 người bạn mới",
    "Gặp/Thăm 1 thành viên yêu thích trong già đình",
    "Xem 1 bộ phim từ kho phim của app",
    "Tập 1 bài yoga cơ bản",
    "Đi bộ 20p",
    "Xem 1 bộ phim từ kho phim của app",
    "Đi 1 quán ăn đang nổi tiếng",
    "Lau dọn nhà",
    "Đi chợ",
    "Chơi 1 game trong kho game của app",
    //"Viết nhật ký ( thời gian sau nv xuất hiện mỗi ngày",
  ];
  static final List<String> VUI = [
    "Nghe 1 bài nhạc từ kho nhạc của app",
    "Tập thể dục 30p",
    "Gặp gỡ 1 người bạn",
    "Gặp/Thăm 1 thành viên yêu thích trong già đình",
    "Lau dọn nhà",
    "Đi bộ 20p",
    "Chơi 1 game trong kho game của app",
    "Xem 1 bộ phim từ kho phim của app",
    "Gặp gỡ 1 người bạn mới",
    "Đi xem 1 bộ phim đang nổi ở rạp",
    "Gặp/Thăm 1 thành viên yêu thích trong già đình",
    "Uống 1 ly trà hoa cúc/ trà hoa hồng/trà chanh/trà bạc hà/trà hoa oải hương",
    "Uống 1 ly smoothie có hạt chia",
    //"Đi 1 quán coffee/ coffee chó mèo ( nếu không dị ứng lông chó mèo)",
    "Đi chợ",
    "Chụp 3 tấm hình",
    //"Viết nhật ký ( thời gian sau nv xuất hiện mỗi ngày)",
  ];
  static final List<String> CUCVUI = [
    "Nghe 1 bài nhạc từ kho nhạc của app",
    "Tập thể dục 30p",
    "Gặp gỡ 1 người bạn",
    "Gặp/Thăm 1 thành viên yêu thích trong già đình",
    "Lau dọn nhà",
    "Nấu 1 món ăn và tặng cho 1 người",
    "Đi bộ 20p",
    "Xem 1 bộ phim từ kho phim của app",
    "Gặp gỡ 1 người bạn mới",
    "Đi xem 1 bộ phim đang nổi ở rạp",
    "Viết nhật ký ( bắt buộc mỗi ngày)",
    "Gặp/Thăm 1 thành viên yêu thích trong già đình",
    "Uống 1 ly trà",
    //"Đi 1 quán coffee/ coffee chó mèo ( nếu không dị ứng lông chó mèo)",
    "Đi chợ",
    "Chơi 1 game trong kho game của app",
    "Chụp 3 tấm hình",
  ];
}
