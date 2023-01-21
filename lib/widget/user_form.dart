import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:apply_job/model/user.dart';
import 'button.dart';

class UserFormWidget extends StatefulWidget {
  final ValueChanged<User> onSavedUser;

  const UserFormWidget({
    Key? key,
    required this.onSavedUser,
  }) : super(key: key);

  @override
  _UserFormWidgetState createState() => _UserFormWidgetState();
}

class _UserFormWidgetState extends State<UserFormWidget> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController controllerName;
  late TextEditingController controllerNickname;
  late TextEditingController controllerPhone;
  late TextEditingController controllerEmail;
  late bool experience;
  late TextEditingController controllerMsg;
  final fieldText = TextEditingController();

  @override
  void initState() {
    super.initState();
    initUser();
  }

  void clearText() {
    fieldText.clear();
  }

  void initUser() {
    controllerName = TextEditingController();
    controllerNickname = TextEditingController();
    controllerPhone = TextEditingController();
    controllerEmail = TextEditingController();
    this.experience = true;
    controllerMsg = TextEditingController();
  }

  @override
  Widget build(BuildContext context) => Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildName(),
          const SizedBox(
            height: 16,
          ),
          buildNickname(),
          const SizedBox(
            height: 16,
          ),
          buildPhone(),
          const SizedBox(
            height: 16,
          ),
          buildEmail(),
          const SizedBox(
            height: 16,
          ),
          experienceCheck(),
          const SizedBox(
            height: 16,
          ),
          buildMsg(),
          const SizedBox(
            height: 16,
          ),
          buildSubmit(),
        ],
      ));

  Widget buildName() => TextFormField(
        controller: controllerName,
        decoration: InputDecoration(
            labelText: "Name",
            border: OutlineInputBorder(),
            suffixIcon: IconButton(
                icon: Icon(Icons.clear),
                onPressed: () {
                  controllerName.clear();
                })),
        validator: (value) =>
            value != null && value.isEmpty || RegExp(r'[0-9]').hasMatch(value!)
                ? "Enter Name"
                : null,
      );

  Widget buildNickname() => TextFormField(
        controller: controllerNickname,
        decoration: InputDecoration(
            labelText: "Nickname",
            border: OutlineInputBorder(),
            suffixIcon: IconButton(
                icon: Icon(Icons.clear),
                onPressed: () {
                  controllerNickname.clear();
                })),
        validator: (value) =>
            value != null && value.isEmpty || RegExp(r'[0-9]').hasMatch(value!)
                ? "Enter Nickname"
                : null,
      );

  Widget buildPhone() => TextFormField(
        controller: controllerPhone,
        keyboardType: TextInputType.number,
        maxLength: 10,
        decoration: InputDecoration(
            counterText: "",
            labelText: "Phone",
            border: OutlineInputBorder(),
            hintText: "05x xxx xxxx",
            alignLabelWithHint: true,
            hintStyle: new TextStyle(
              color: Color.fromARGB(153, 158, 158, 158),
            ),
            suffixIcon: IconButton(
                icon: Icon(Icons.clear),
                onPressed: () {
                  controllerPhone.clear();
                })),
        validator: (value) => value != null && value.isEmpty ||
                RegExp(r'[A-Za-z]').hasMatch(value!)
            ? "Enter Phone"
            : null,
      );

  Widget buildEmail() => TextFormField(
        controller: controllerEmail,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            labelText: "Email",
            border: OutlineInputBorder(),
            suffixIcon: IconButton(
                icon: Icon(Icons.clear),
                onPressed: () {
                  controllerEmail.clear();
                })),
        validator: (value) =>
            value != null && !value.contains("@") ? "Enter Email" : null,
      );

  Widget experienceCheck() => SwitchListTile(
      contentPadding: EdgeInsets.zero,
      controlAffinity: ListTileControlAffinity.leading,
      value: experience,
      title: Text("Do you Have Experience?"),
      onChanged: (value) => setState(() => experience = value));

  Widget buildMsg() => SizedBox(
      height: 150,
      child: TextFormField(
        controller: controllerMsg,
        textAlignVertical: TextAlignVertical.top,
        // textDirection: TextDirection.rtl,
        expands: true,
        maxLines: null,
        minLines: null,
        maxLength: 250,

        decoration: InputDecoration(
            labelText: "Your Message",
            border: OutlineInputBorder(),
            suffixIcon: IconButton(
                padding: EdgeInsets.only(bottom: 70),
                icon: Icon(Icons.clear),
                onPressed: () {
                  controllerMsg.clear();
                })),
        validator: (value) =>
            value != null && value.isEmpty ? "Enter Message" : null,
      ));

  Widget buildSubmit() => ButtonWidget(
        text: "Send",
        onClicked: () {
          final form = formKey.currentState!;
          final isValid = form.validate();

          if (isValid) {
            final user = User(
                name: controllerName.text,
                nickname: controllerNickname.text,
                phone: controllerPhone.text,
                email: controllerEmail.text,
                experience: experience,
                msg: controllerMsg.text);
            widget.onSavedUser(user);
          }
          if (isValid) {
            Future.delayed(const Duration(seconds: 1), () {
              showDialog(
                context: context,
                builder: (context) {
                  return CupertinoAlertDialog(
                    title: const Text(
                      "THANK YOU",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    content: const Text(
                      "We will get back to you as soon as possible. We wish you all the best",
                      style: TextStyle(fontWeight: FontWeight.w400),
                    ),
                    actions: [
                      CupertinoDialogAction(
                          onPressed: () {
                            Navigator.of(context).pop();
                            controllerName.clear();
                            controllerNickname.clear();
                            controllerPhone.clear();
                            controllerEmail.clear();
                            controllerMsg.clear();
                          },
                          child: Text("Close")),
                    ],
                  );
                },
              );
            });
          }
        },
      );
}
