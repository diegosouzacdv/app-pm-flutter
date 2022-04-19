import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SavePassword extends StatefulWidget {
  final Function(bool) checkBoxSavePassword;
  bool checkIsUser;
  SavePassword(this.checkBoxSavePassword, this.checkIsUser);

  @override
  _SavePasswordState createState() => _SavePasswordState();
}

class _SavePasswordState extends State<SavePassword> {
  bool _checked = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          CheckboxListTile(
            checkColor: Theme.of(context).primaryColor,
            activeColor: Colors.greenAccent,
            title: Text(
              "Salvar Senha",
            ),
            secondary: Icon(
              Icons.security,
            ),
            value: _checked,
            onChanged: (_) {
              setState(() {
                _checked = !_checked;
                widget.checkBoxSavePassword(_checked);
              });
            },
          )
        ],
      ),
    );
  }
}
