import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:simplerecharge/utils/message_dialog.dart';

void launchURL(BuildContext context, String path) async {
  String url = path;
  try {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch URL';
    }
  } catch (err) {
    showMessageDialog(context, "URL Failed", err.toString());
  }
}
