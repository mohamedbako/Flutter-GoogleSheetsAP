import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:apply_job/api_sheets/user_sheet_api.dart';
import 'package:apply_job/page/pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserSheetApi.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = "Apply Job";

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme:
            ThemeData(primarySwatch: Colors.blue, brightness: Brightness.dark),
        home: CreateSheetsPage(),
      );
}
