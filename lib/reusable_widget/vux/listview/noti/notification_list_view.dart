import 'package:flutter/material.dart';
import 'package:flutterapp/setting.dart';

import '../../../../model/notification.dart';
import '../../../../util/process/notification/NotificationManager.dart';
import 'normal_cell.dart';

class NotificationListView extends StatefulWidget {
  const NotificationListView({Key? key}) : super(key: key);

  @override
  _NotificationListViewState createState() => _NotificationListViewState();
}

class _NotificationListViewState extends State<NotificationListView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late NotificationManager _manager;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
    _manager = NotificationManager();
    _manager.removedItemBuilder = _buildRemovedItem;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: AnimatedList(
        key: _manager.listKey,
        initialItemCount: _manager.notificationCount,
        physics: BouncingScrollPhysics(),
        itemBuilder:
            (BuildContext context2, int index, Animation<double> animation) {
          return _buildItem(_manager.notifications[index], context2, animation);
        },
      ),
    );
  }

  Widget _buildItem(NotificationContent item, BuildContext context,
      Animation<double> animation) {
    double w = Setting.widthSize / 40;
    return SizeTransition(
      sizeFactor: animation,
      child: Padding(
        padding: EdgeInsets.only(left: w, right: w, top: 0, bottom: w),
        child: NormalCell(noti: item),
      ),
    );
  }

  Widget _buildRemovedItem(NotificationContent item, BuildContext context,
      Animation<double> animation) {
    return Container();
  }
}
