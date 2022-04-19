import 'package:flutter/material.dart';

import '../../utils/sgpol_app_theme.dart';

class ConferenciaFormScreen extends StatefulWidget {
  @override
  _ConferenciaFormScreenState createState() => _ConferenciaFormScreenState();
}

class _ConferenciaFormScreenState extends State<ConferenciaFormScreen> {
  final _form = GlobalKey<FormState>();
  String dropdownValue = 'Ditel';

  List<String> _unidades = ['Ditel', '1º BPM'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _form,
        child: ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: [
            DropdownButton(
              value: dropdownValue,
              icon: const Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(
                color: Color.fromRGBO(0, 0, 65, 1),
              ),
              underline: Container(
                height: 2,
                color: SgpolAppTheme.accentColorSgpol,
              ),
              onChanged: (String newValue) {
                setState(() {
                  dropdownValue = newValue;
                });
              },
              items: _unidades.map((value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
