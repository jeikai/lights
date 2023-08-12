import 'package:flutter/material.dart';

import '../../../../model/notification.dart';
import '../../../../util/process/notification/NotificationManager.dart';

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
        itemBuilder:
            (BuildContext context, int index, Animation<double> animation) {
          return Container(
            color: Colors.yellow,
            height: 20,
          );
        },
      ),
    );
  }

  Widget _buildRemovedItem(NotificationContent item, BuildContext context,
      Animation<double> animation) {
    return Container();
  }
}
