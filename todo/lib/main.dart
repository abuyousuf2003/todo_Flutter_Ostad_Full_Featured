import 'package:flutter/material.dart';
import 'package:todo/to_do_page.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';

void main() => runApp(
  DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => MyApp(), // Wrap your app
  ),
);

class MyApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch:Colors.blue ,
      ),
home:MyHomePage() ,
    ) ;
  }
}


class MyHomePage extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return ToDoPage();
  }
}
