import 'package:finalproject/login_ui.dart';
import 'package:finalproject/services/notifier/event_notifier.dart';
import 'package:finalproject/services/notifier/user_create.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

main() => runApp(
    MultiProvider(
      child: MyApp(),
      providers: [
        ChangeNotifierProvider(
          create: (_)=>EventNotifier(),
        ),
        ChangeNotifierProvider(
          create: (_)=>UserCreateNotifier(),
        ),
      ],
    )
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginUI(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.blueGrey,
      ),
    );
  }
}