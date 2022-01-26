import 'dart:async';
import 'package:flutter/material.dart';
import 'package:app_alianzademo/database/user.dart';

class helpers {

  static Future<void> Logout() async {
    var data = await user.getUserData();
    await user.delete(data.id);
  }
}
