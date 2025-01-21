import 'package:aiplus_to_do/app/app.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences sharedPrefInstance =
      await SharedPreferences.getInstance();
  runApp(App(sharedPreferences: sharedPrefInstance));
}
