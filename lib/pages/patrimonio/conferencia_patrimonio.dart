import 'package:apppmdfflutter/utils/sgpol_app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class ConferenciaPatrimonio extends StatefulWidget {
  final AnimationController animationController;

  const ConferenciaPatrimonio({Key key, this.animationController})
      : super(key: key);

  @override
  _ConferenciaPatrimonioState createState() => _ConferenciaPatrimonioState();
}

class _ConferenciaPatrimonioState extends State<ConferenciaPatrimonio> {
  String resultCodeBar = '';

  _codeBar() async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666', 'Cancelar', true, ScanMode.DEFAULT);

    if (barcodeScanRes == '-1') {
      SnackBar(content: Text('Leitura Cancelada'));
    } else {
      setState(() {
        resultCodeBar = barcodeScanRes;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Valor do código de barras: ',
          style: Theme.of(context).textTheme.headline6.copyWith(
              fontWeight: FontWeight.bold, color: SgpolAppTheme.darkText),
        ),
        Text(
          resultCodeBar,
          style: Theme.of(context)
              .textTheme
              .headline5
              .copyWith(color: SgpolAppTheme.darkText),
        ),
        SizedBox(height: 10),
        TextButton.icon(
          onPressed: _codeBar,
          icon: Icon(
            Icons.bar_chart_sharp,
            size: 50,
            color: SgpolAppTheme.accentColorSgpol,
          ),
          label: Text(
            'Escanear',
            style: Theme.of(context)
                .textTheme
                .headline5
                .copyWith(color: SgpolAppTheme.darkText),
          ),
        ),
      ],
    );
  }
}
