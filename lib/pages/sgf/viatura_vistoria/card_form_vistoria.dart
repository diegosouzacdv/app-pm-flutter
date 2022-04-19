import 'package:apppmdfflutter/models/situacao_viatura.dart';
import 'package:apppmdfflutter/models/viaturaDTO.dart';
import 'package:apppmdfflutter/models/vistoria_viatura.dart';
import 'package:apppmdfflutter/providers/sgf_providers.dart';
import 'package:apppmdfflutter/utils/app_routes.dart';
import 'package:apppmdfflutter/utils/sgpol_app_theme.dart';
import 'package:apppmdfflutter/widgets/alert_dialog_sgpol.dart';
import 'package:apppmdfflutter/widgets/bottom_sgpol.dart';
import 'package:apppmdfflutter/widgets/error_http_show_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardFormVistoria extends StatefulWidget {
  final AnimationController animationController;
  final Animation animation;
  final VistoriaViatura vistoriaViatura;
  final ViaturaDTO viatura;

  const CardFormVistoria(
      {Key key,
      this.animationController,
      this.animation,
      this.vistoriaViatura,
      this.viatura})
      : super(key: key);

  @override
  _CardFormVistoriaState createState() => _CardFormVistoriaState();
}

class _CardFormVistoriaState extends State<CardFormVistoria> {
  double valueSlide = 0;
  final _percursoFocusNode = FocusNode();
  final _alteracoesAssumir = FocusNode();
  final _odometroFinal = FocusNode();
  final _form = GlobalKey<FormState>();
  final _formData = Map<String, Object>();
  VistoriaViatura vistoria = new VistoriaViatura();
  ViaturaDTO via = new ViaturaDTO();
  bool _loading = false;
  SGFProvider sgfProvider;

  @override
  void initState() {
    sgfProvider = Provider.of(context, listen: false);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    sgfProvider = Provider.of(context, listen: false);
    setState(() {
      vistoria = widget.vistoriaViatura;
      via = widget.viatura;
    });
    super.didChangeDependencies();
    if (_formData.isEmpty) {
      vistoria.odometro != null
          ? _formData['odometro'] = vistoria.odometro
          : _formData['odometro'] = '';
      _formData['nivelCombustivel'] = vistoria.nivelCombustivel;
      _formData['percurso'] = vistoria.percurso;
      _formData['observacaoMotorista'] = vistoria.observacaoMotorista;
      _formData['observacaoMotoristaFinal'] = vistoria.observacaoMotoristaFinal;
      vistoria.odometroFinal != null
          ? _formData['odometroFinal'] = vistoria.odometroFinal
          : _formData['odometroFinal'] = '';
      valueSlide = double.parse(vistoria.nivelCombustivel);
    }
  }

  @override
  void dispose() {
    _percursoFocusNode.dispose();
    _alteracoesAssumir.dispose();
    _odometroFinal.dispose();
    super.dispose();
  }

  bool _saveForm() {
    var isValid = _form.currentState.validate();
    if (!isValid) {
      return false;
    }
    _form.currentState.save();
    vistoria.percurso = _formData['percurso'];
    vistoria.nivelCombustivel = _formData['nivelCombustivel'].toString();
    vistoria.observacaoMotorista = _formData['observacaoMotorista'];
    vistoria.observacaoMotoristaFinal = _formData['observacaoMotoristaFinal'];
    vistoria.odometro = int.parse(_formData['odometro']);
    if (_formData['odometroFinal'].toString().isNotEmpty)
      vistoria.odometroFinal = int.parse(_formData['odometroFinal']);
    return true;
  }

  Future<void> _cancelarVistoria(bool value) async {
    if (value) {
      await sgfProvider
          .cancelarVistoria(vistoria.id)
          .then((_) {
        Navigator.of(context).pop();
      }).catchError((error) {
        dialogAlertErrorHttp(context: context, mensagem: error.toString());
      });
    }
  }

  Future<void> _salvarAlteracaoesVistoria(bool value) async {
    isLoading(true);
    var mensagem = '';
    var titulo = 'Dados Salvos';
    var botaoSim = true;
    var textBotaoCancel = 'Não';
    var textBotaoOk = 'Sim';
    if (value) {
      await sgfProvider
          .alterarVistoria(vistoria, context)
          .then((value) async {
        setState(() {
          vistoria = value;
        });
        isLoading(false);
        await getViatura();
        if (via.status == SituacaoViatura.EM_VISTORIA) {
          mensagem = 'Deseja cautelar a viatura de prefixo: ${via.prefixo}?';
        } else if (via.status == SituacaoViatura.EM_USO) {
          mensagem = 'Deseja devolver a viatura de prefixo: ${via.prefixo}?';
        }
        if (mensagem.length > 0 && mensagem.isNotEmpty) {
          _avisoAlert(mensagem, titulo, botaoSim, textBotaoCancel, textBotaoOk,
              _verficarOdometroFinal);
        }
      }).catchError((error) {
        isLoading(false);
        dialogAlertErrorHttp(context: context, mensagem: error.toString());
      });
    }
  }

  void isLoading(bool loading) {
    setState(() {
      _loading = loading;
    });
  }

  _avisoAlert(String mensagem, String titulo, bool botaoSim,
      String textBotaoCancel, String textBotaoOk, Function function) {
    dialogAlert(
      titulo: titulo,
      mensagem: mensagem,
      botaoSim: botaoSim,
      textBotaoCancel: textBotaoCancel,
      textBotaoOk: textBotaoOk,
      context: context,
      function: function,
    );
  }

  Future<void> _verficarOdometroFinal(bool value) async {
    var titulo = '';
    var mensagem = '';
    Function function = (_) => '';
    bool botaoSim = false;
    var textBotaoCancel = 'Não';
    var textBotaoOk = 'Sim';

    if (vistoria.odometroFinal != null &&
        (vistoria.odometroFinal < vistoria.odometro)) {
      titulo = 'Atenção Odômetro Final';
      mensagem = 'Odômetro Final é menor que Odômetro Inicial';
      textBotaoCancel = 'Fechar';
      await _avisoAlert(
          mensagem, titulo, botaoSim, textBotaoCancel, textBotaoOk, function);
      return Future.value();
    }

    _cautelarDevolverViatura();
  }

  _cautelarDevolverViatura() async {
    isLoading(true);
    var titulo = 'Atenção';
    var mensagem = '';
    bool botaoSim = true;
    var textBotaoCancel = '';
    var textBotaoOk = 'OK';

    await sgfProvider
        .cautelarViaturaFinalizarVistoria(vistoria)
        .then((value) async {
      isLoading(false);
      await getViatura();
      print(via.status);
      if (via.status == SituacaoViatura.EM_USO) {
        mensagem = 'Viatura de prefixo ${via.prefixo} foi cautelada';
      } else if (via.status == SituacaoViatura.INCORPORADA) {
        mensagem = 'Viatura de prefixo ${via.prefixo} foi entregue';
      }
      if (mensagem != null && mensagem.length > 0 && mensagem.isNotEmpty)
        _avisoAlert(mensagem, titulo, botaoSim, textBotaoCancel, textBotaoOk,
            _routerHome);
    }).catchError((error) {
      dialogAlertErrorHttp(context: context, mensagem: error.toString());
      isLoading(false);
    });
  }

  Future<void> getViatura() async {
    await sgfProvider.getViatura(via.id).then((value) {
      setState(() {
        via = value;
      });
    }).catchError((error) {
      dialogAlertErrorHttp(context: context, mensagem: error.toString());
    });
  }

  Future<void> _routerHome(bool value) {
    Navigator.of(context).pushReplacementNamed(AppRoutes.HOME);
    return Future.value();
  }

  Future<void> _clickButton(bool value, String action) async {
    print(via.status);
    var titulo = '';
    var mensagem = '';
    Function function = (_) => '';
    bool botaoSim = false;
    var textBotaoCancel = 'Não';
    var textBotaoOk = 'Sim';
    if (action == "cancelar") {
      titulo = 'Cancelar Vistoria';
      mensagem = 'Deseja cancelar a vistoria?';
      function = _cancelarVistoria;
      botaoSim = true;
    } else if (action == "salvar") {
      if (!_saveForm()) return Future.value();
      _salvarAlteracaoesVistoria(true);
    }
    if (titulo.isNotEmpty && mensagem.isNotEmpty)
      _avisoAlert(
          mensagem, titulo, botaoSim, textBotaoCancel, textBotaoOk, function);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: widget.animationController,
        builder: (BuildContext context, Widget child) {
          return FadeTransition(
            opacity: widget.animation,
            child: new Transform(
              transform: new Matrix4.translationValues(
                  0.0, 30 * (1.0 - widget.animation.value), 0.0),
              child: Builder(builder: (BuildContext contexto) {
                return Padding(
                  padding: const EdgeInsets.only(top: 30, right: 5, left: 5),
                  child: Stack(children: [
                    Positioned.fill(
                      bottom: 10,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 15, left: 13, right: 5),
                        child: _loading
                            ? Center(
                                child: Image.asset('assets/images/ripple.gif'),
                              )
                            : Form(
                                key: _form,
                                child: ListView(
                                  children: [
                                    TextFormField(
                                      initialValue:
                                          _formData['odometro'].toString(),
                                      cursorColor:
                                          SgpolAppTheme.primaryColorSgpol,
                                      textInputAction: TextInputAction.next,
                                      keyboardType:
                                          TextInputType.numberWithOptions(
                                              decimal: false),
                                      style: TextStyle(
                                        color: SgpolAppTheme.darkText,
                                      ),
                                      decoration: InputDecoration(
                                        labelText: 'Odômetro Inicial KM',
                                        labelStyle: new TextStyle(
                                          color: SgpolAppTheme.dark_grey,
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: SgpolAppTheme.grey),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: SgpolAppTheme
                                                  .primaryColorSgpol),
                                        ),
                                      ),
                                      onFieldSubmitted: (_) {
                                        FocusScope.of(context)
                                            .requestFocus(_percursoFocusNode);
                                      },
                                      onSaved: (value) =>
                                          _formData['odometro'] = value,
                                      validator: (value) {
                                        if (value.trim().isEmpty) {
                                          return 'Odômetro inicial é obrigatório!';
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    const Text.rich(
                                      TextSpan(
                                        text: 'Nível de Combustível',
                                        style: TextStyle(
                                            color: SgpolAppTheme.dark_grey,
                                            fontSize: 17),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    SliderTheme(
                                      data: SliderTheme.of(context).copyWith(
                                        trackHeight: 1,
                                        valueIndicatorColor:
                                            SgpolAppTheme.primaryColorSgpol,
                                        inactiveTrackColor:
                                            SgpolAppTheme.deactivatedText,
                                        activeTrackColor:
                                            SgpolAppTheme.primaryColorSgpol,
                                        thumbColor: SgpolAppTheme.colorSuccess,
                                        overlayColor:
                                            SgpolAppTheme.primaryColorSgpol,
                                        thumbShape: RoundSliderThumbShape(
                                            enabledThumbRadius: 12.0),
                                        overlayShape: RoundSliderOverlayShape(
                                            overlayRadius: 20.0),
                                      ),
                                      child: Slider.adaptive(
                                        value: valueSlide,
                                        min: 0,
                                        max: 100,
                                        divisions: 20,
                                        label:
                                            'Combustível ${valueSlide.round()}%',
                                        onChanged: (double value) {
                                          setState(() {
                                            valueSlide = value;
                                            _formData['nivelCombustivel'] =
                                                valueSlide.toString();
                                          });
                                        },
                                      ),
                                    ),
                                    TextFormField(
                                      initialValue: _formData['percurso'],
                                      maxLines: 3,
                                      cursorColor:
                                          SgpolAppTheme.primaryColorSgpol,
                                      textInputAction: TextInputAction.next,
                                      focusNode: _percursoFocusNode,
                                      style: TextStyle(
                                        color: SgpolAppTheme.darkText,
                                      ),
                                      decoration: InputDecoration(
                                        labelText: 'Percurso',
                                        labelStyle: new TextStyle(
                                          color: SgpolAppTheme.dark_grey,
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: SgpolAppTheme.grey),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: SgpolAppTheme
                                                  .primaryColorSgpol),
                                        ),
                                      ),
                                      onFieldSubmitted: (_) {
                                        FocusScope.of(context)
                                            .requestFocus(_alteracoesAssumir);
                                      },
                                      onSaved: (value) =>
                                          _formData['percurso'] = value,
                                    ),
                                    TextFormField(
                                      initialValue:
                                          _formData['observacaoMotorista'],
                                      maxLines: 3,
                                      cursorColor:
                                          SgpolAppTheme.primaryColorSgpol,
                                      keyboardType: TextInputType.multiline,
                                      textInputAction: TextInputAction.next,
                                      focusNode: _alteracoesAssumir,
                                      style: TextStyle(
                                        color: SgpolAppTheme.darkText,
                                      ),
                                      decoration: InputDecoration(
                                        labelText:
                                            'Alterações Verificadas ao Assumir o Serviço',
                                        labelStyle: new TextStyle(
                                          color: SgpolAppTheme.dark_grey,
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: SgpolAppTheme.grey),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: SgpolAppTheme
                                                  .primaryColorSgpol),
                                        ),
                                      ),
                                      onSaved: (value) =>
                                          _formData['observacaoMotorista'] =
                                              value,
                                    ),
                                    if (widget.viatura.status !=
                                        SituacaoViatura.EM_VISTORIA)
                                      TextFormField(
                                        initialValue: _formData[
                                            'observacaoMotoristaFinal'],
                                        maxLines: 3,
                                        cursorColor:
                                            SgpolAppTheme.primaryColorSgpol,
                                        keyboardType: TextInputType.multiline,
                                        textInputAction: TextInputAction.next,
                                        style: TextStyle(
                                          color: SgpolAppTheme.darkText,
                                        ),
                                        decoration: InputDecoration(
                                          labelText:
                                              'Alterações Verificadas Durante o Serviço',
                                          labelStyle: new TextStyle(
                                            color: SgpolAppTheme.dark_grey,
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: SgpolAppTheme.grey),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: SgpolAppTheme
                                                    .primaryColorSgpol),
                                          ),
                                        ),
                                        onSaved: (value) => _formData[
                                            'observacaoMotoristaFinal'] = value,
                                      ),
                                    if (widget.viatura.status !=
                                        SituacaoViatura.EM_VISTORIA)
                                      TextFormField(
                                        initialValue: _formData['odometroFinal']
                                            .toString(),
                                        cursorColor:
                                            SgpolAppTheme.primaryColorSgpol,
                                        textInputAction: TextInputAction.next,
                                        keyboardType:
                                            TextInputType.numberWithOptions(
                                                decimal: false),
                                        focusNode: _odometroFinal,
                                        style: TextStyle(
                                          color: SgpolAppTheme.darkText,
                                        ),
                                        decoration: InputDecoration(
                                          labelText: 'Odômetro Final KM',
                                          labelStyle: new TextStyle(
                                            color: SgpolAppTheme.dark_grey,
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: SgpolAppTheme.grey),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: SgpolAppTheme
                                                    .primaryColorSgpol),
                                          ),
                                        ),
                                        onFieldSubmitted: (_) {
                                          _saveForm();
                                        },
                                        onSaved: (value) {
                                          _formData['odometroFinal'] = value;
                                        },
                                        validator: (value) {
                                          if (widget.viatura.status !=
                                                  SituacaoViatura.EM_VISTORIA &&
                                              value.trim().isEmpty) {
                                            _avisoAlert(
                                                'Odômetro Final deve ser preenchido',
                                                'Atenção Odômetro Final',
                                                false,
                                                'Fechar',
                                                '',
                                                (_) => '');

                                            return 'Odômetro final é obrigatório!';
                                          }
                                          return null;
                                        },
                                      ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            if (widget.viatura.status !=
                                                SituacaoViatura.EM_USO)
                                              ButtonSgpol(
                                                animation: widget.animation,
                                                animationController:
                                                    widget.animationController,
                                                action: 'cancelar',
                                                label: 'Cancelar',
                                                color1: Color(0xffB71C1C),
                                                color2: Color(0xffF8BBD0),
                                                icon: Icons.home,
                                                clickButton: _clickButton,
                                              ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            // if(widget.viatura.status != SituacaoViatura.EM_USO)
                                            ButtonSgpol(
                                              animation: widget.animation,
                                              animationController:
                                                  widget.animationController,
                                              action: 'salvar',
                                              label: 'Salvar',
                                              color1: Color(0xff0D47A1),
                                              color2: Color(0xff2196F3),
                                              icon: Icons.home,
                                              clickButton: _clickButton,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                      ),
                    )
                  ]),
                );
              }),
            ),
          );
        });
  }
}
