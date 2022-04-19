import 'package:apppmdfflutter/utils/sgpol_app_theme.dart';
import 'package:flutter/material.dart';

class BotaoOutlineSgpol extends StatelessWidget {
  final String textButton;
  final IconData iconButton;
  final Function(bool) onpressButton;
  final Color colorButtonSgpol;

  const BotaoOutlineSgpol({
    Key key,
    @required this.textButton,
    @required this.iconButton,
    this.onpressButton,
    this.colorButtonSgpol = SgpolAppTheme.whiteGradient,
  }) : super(key: key);

  resposta(bool value) {
    onpressButton(value);
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      label: Text(
        textButton,
        style: TextStyle(color: colorButtonSgpol),
      ),
      icon: Icon(
        iconButton,
        color: colorButtonSgpol,
      ),
      onPressed: () => resposta(true),
      style: ButtonStyle(
        shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
          (_) {
            return RoundedRectangleBorder(
              side: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(15),
            );
          },
        ),
      ),
    );
  }
}
