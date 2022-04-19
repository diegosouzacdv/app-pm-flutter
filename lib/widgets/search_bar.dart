import 'package:apppmdfflutter/providers/pesquisa_providers.dart';
import 'package:apppmdfflutter/utils/sgpol_app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

// ignore: must_be_immutable
class SearchBar extends StatefulWidget {
  final void Function() pesquisaViatura;
  double paddingLR;

  SearchBar(this.pesquisaViatura, this.paddingLR);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  TextEditingController _controller;

  @override
  void initState() {
    print('didChangeDependencies do SearchBar');
    _controller = new TextEditingController(text: '');
    super.initState();
  }

  @override
  void dispose() {
    _controller.clear();
    super.dispose();
    _controller.dispose();
  }

  bool _folded = true;

  Widget limparTextController() {
    final pesquisaProvider = Provider.of<PesquisaProvider>(context);
    if(pesquisaProvider.pesquisa == 'false') {
      _controller.clear();
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    final pesquisaProvider = Provider.of<PesquisaProvider>(context);
    final width = MediaQuery.of(context).size.width;
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      width: _folded ? 56 : width,
      height: 57,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(_folded
            ? 32
            : widget.paddingLR == 20
                ? 32
                : widget.paddingLR),
        gradient: SgpolAppTheme.colorGradientSgpol,
        boxShadow: kElevationToShadow[6],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 16),
              child: !_folded
                  ? TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'Placa ou Prefixo',
                        hintStyle: TextStyle(color: SgpolAppTheme.white),
                        border: InputBorder.none,
                      ),
                      onChanged: (text) {
                        // ignore: close_sinks
                        final _query = BehaviorSubject<String>();
                        text = text.toLowerCase();
                        _query.add(text);
                        _query.debounce((_) => TimerStream(true, Duration(milliseconds: 500))).listen(
                          (event) {
                            event.isNotEmpty ? pesquisaProvider.setPesquisa(event) : pesquisaProvider.setPesquisa('false');
                            widget.pesquisaViatura();
                          },
                        );
                      },
                    )
                  : null,
            ),
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 400),
            child: Material(
              type: MaterialType.transparency,
              child: InkWell(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(_folded ? 32 : 0),
                  topRight: Radius.circular(32),
                  bottomLeft: Radius.circular(_folded ? 32 : 0),
                  bottomRight: Radius.circular(32),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(
                    _folded ? Icons.search : Icons.close,
                    color: SgpolAppTheme.white,
                  ),
                ),
                onTap: () {
                  this.setState(() {
                    _folded = !_folded;
                    _controller.clear();
                  });
                  pesquisaProvider.setPesquisa('false');
                  widget.pesquisaViatura();
                },
              ),
            ),
          ),
    ChangeNotifierProvider(
    create: (_) => pesquisaProvider,
    child: limparTextController(),
    ),
        ],
      ),
    );
  }
}
