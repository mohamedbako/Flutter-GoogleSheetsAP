import 'package:apply_job/api_sheets/user_sheet_api.dart';
import 'package:apply_job/main.dart';
import 'package:apply_job/model/user.dart';
import 'package:apply_job/widget/button.dart';
import 'package:apply_job/widget/user_form.dart';
import 'package:flutter/material.dart';

class CreateSheetsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(MyApp.title),
          centerTitle: true,
        ),
        body: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(32),
            child: SingleChildScrollView(
              child: UserFormWidget(onSavedUser: (user) async {
                final id = await UserSheetApi.getRowCount() + 1;
                final newUser = user.copy(id: id);
                await UserSheetApi.insert([newUser.toJson()]);
              }),
            )),
      );
}
