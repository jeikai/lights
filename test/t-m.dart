// Hàm đồng bộ sử dụng từ khóa 'await'
void mySyncFunction() async {
  print('Start of mySyncFunction');

  // Đợi một Future hoàn thành bằng từ khóa 'await'
  String result = await fetchData();

  // Sau khi Future hoàn thành, chương trình tiếp tục thực hiện từ đoạn này
  print('Result from fetchData: $result');

  print('End of mySyncFunction');
}

// Hàm bất đồng bộ (Future) mô phỏng việc tải dữ liệu từ mạng
Future<String> fetchData() {
  return Future.delayed(Duration(seconds: 2), () => 'Data from the Future');
}

void main() {
  double a = 1.934;
  print(a.toInt());
}
