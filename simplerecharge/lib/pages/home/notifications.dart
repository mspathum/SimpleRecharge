import 'package:flutter/material.dart';
import 'package:simplerecharge/main.dart';
import 'package:simplerecharge/state/app_state.dart';
import 'package:simplerecharge/themes/app_themes.dart';
import 'package:simplerecharge/widgets/app_widgets/list_empty.dart';

class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final appState = getIt.get<AppState>();

  List<String> notificationList = [];

  Widget _buildNotificationCard() {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0))),
      color: Colors.white,
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Row(
          children: [
            Container(
              color: AppColors.secondary,
              width: 2.5,
              height: 35.0,
            ),
            SizedBox(width: 5.0),
            Icon(
              Icons.notifications_rounded,
              color: AppColors.secondary,
            ),
            SizedBox(width: 5.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Notifications Title',
                    style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w500)),
                Text('Notifications description goes here.',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(fontSize: 14.0, color: Colors.black)),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text(appState.getTranslation("Notifications"),
            style: TextStyle(fontSize: 18.0, color: Colors.white)),
        backgroundColor: AppColors.primary,
      ),
      body: notificationList.isEmpty
          ? ListEmptyImage(appState.getTranslation("No_notifications"),
              appState.getTranslation("Stay_tuned"))
          : ListView.builder(
              itemCount: notificationList.length,
              itemBuilder: (BuildContext context, int index) {
                return _buildNotificationCard();
              }),
    );
  }
}
