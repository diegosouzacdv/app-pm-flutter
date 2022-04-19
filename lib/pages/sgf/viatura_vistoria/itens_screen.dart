import 'package:apppmdfflutter/models/vistoria_viatura_itens_vistoria.dart';
import 'package:apppmdfflutter/providers/sgf_providers.dart';
import 'package:apppmdfflutter/utils/sgpol_app_theme.dart';
import 'package:apppmdfflutter/widgets/error_http_show_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItensScreen extends StatefulWidget {
  final List<VistoriaViaturaItensVistoria> itensVistoria;

  const ItensScreen({Key key, @required this.itensVistoria}) : super(key: key);

  @override
  _ItensScreenState createState() => _ItensScreenState();
}

class _ItensScreenState extends State<ItensScreen> {
  double distValue = 50.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: SgpolAppTheme.whiteGradient,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: <Widget>[
            getAppBarUI(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[todosItens()],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget todosItens() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Atenção: Selecione se há alterações',
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: SgpolAppTheme.darkText,
                  fontSize: MediaQuery.of(context).size.width > 360 ? 18 : 16,
                  fontWeight: FontWeight.normal),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16, left: 16),
          child: Column(
            children: getItensListUI(),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }

  List<Widget> getItensListUI() {
    final List<Widget> noList = <Widget>[];
    for (int i = 0; i < widget.itensVistoria.length; i++) {
      final VistoriaViaturaItensVistoria date = widget.itensVistoria[i];
      noList.add(
        Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(4.0)),
            onTap: () {
              setState(() {
                selectItem(i);
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      date.nome,
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  CupertinoSwitch(
                    activeColor: date.vistoriaOk == 1
                        ? SgpolAppTheme.colorDanger
                        : Colors.grey.withOpacity(0.6),
                    onChanged: (bool value) {
                      setState(() {
                        selectItem(i);
                      });
                    },
                    value: date.vistoriaOk == 1 ? true : false,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
      if (i == 0) {
        noList.add(const Divider(
          height: 1,
        ));
      }
    }
    return noList;
  }

  Future<void> selectItem(int index) async {
    setState(() {
      widget.itensVistoria[index].vistoriaOk == 1
          ? widget.itensVistoria[index].vistoriaOk = 0
          : widget.itensVistoria[index].vistoriaOk = 1;
    });

    SGFProvider sgfProvider = Provider.of(context, listen: false);
    await sgfProvider.inserirItem(widget.itensVistoria[index].id).then((value) {
      setState(() {
        widget.itensVistoria[index].vistoriaOk = value['vistoriaOk'];
      });
    }).catchError((error) {
        dialogAlertErrorHttp(context: context, mensagem: error);
      });
  }

  Widget getAppBarUI() {
    return Container(
      decoration: BoxDecoration(
        color: SgpolAppTheme.primaryColorSgpol,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: const Offset(0, 2),
              blurRadius: 4.0),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top, left: 8, right: 8),
        child: Row(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(32.0),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.close),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  'Itens'.toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Container(
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
            )
          ],
        ),
      ),
    );
  }
}
