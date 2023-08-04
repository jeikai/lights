## Event System gồm 2 phần: EventCallable và Event
- Event là phần chứa data.
- EventCallable là phần chạy và xử lý Handler.

## Để gọi một Event (hay call an Event), ta thực hiện các bước sau:

- Tạo một EventCallable.
- Tạo một Event với các Data cần thiết. (VD: `NotificationEvent` class)
- Set Event vào EventCallable bằng cách sử dụng `EventCallable::setEvent(T event)`. 
- Sử dụng method callEvent() để chạy Event. (VD: `NotificationProcess::callEvent`)
- Để thêm các Handler vào Event để chúng chạy thông qua addListener, ta có thể sử dụng cả thuộc tính Priority để xác định mức độ quan trọng của Handler, từ đó quyết định Handler nào được gọi trước Handler nào.
- Add cac Handler vao de Event chay thong qua `EventCallable::addListenr`, co muc Priority de biet muc do quan trong cua Handler nham muc dich biet Handlder nao duoc goi truoc Handler nao

***Demo Code:***
```
import 'package:flutterapp/util/Event.dart';

import '../../../model/notification.dart';

class NotificationEvent extends Event with Cancelable {
  final NotificationContent notificationContent;

  NotificationEvent(this.notificationContent);
}

class NotificationEventCallable extends EventCallable<NotificationEvent> {
  NotificationEventCallable();

  @override
  void preCall() {}

  @override
  void postCall() {}
}
```
```
late NotificationEventCallable callable;

void callEvent(NotificationContent notificationContent) {
    callable.setEvent(NotificationEvent(notificationContent));
    callable.callEvent();
  }
```
- `Cancelable` là một mixin hữu ích hỗ trợ việc bạn muốn huỷ event trong handler, 
  - Nếu event là một Cancelable, bạn có thể dùng `Cancelable::cancel` để bỏ Event này, bất kì Handler nào chạy phía sau sẽ bị loại bỏ
- `preCall()` và `postCall()` là 2 method hữu ích sẽ luôn được gọi ở đầu và cuối một lần Call Event
  - `Cancelable` không thể cancel 2 cái method này

***Lưu ý:***
- nhớ import `package:flutterapp/util/Event.dart` để sử dụng
- Event sẽ được tạo mới mỗi lần call (hãy nhớ cái này để vt handler)

**(hết cái để nói rồi, chill bru)**

*Xem Cái `lib/util/process/notification` để hiểu rõ hơn*
