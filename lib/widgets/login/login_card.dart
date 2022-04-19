import 'package:apppmdfflutter/Animations/FadeAnimation.dart';
import 'package:apppmdfflutter/exceptions/AuthException.dart';
import 'package:apppmdfflutter/providers/auth_providers.dart';
import 'package:apppmdfflutter/utils/app_routes.dart';
import 'package:apppmdfflutter/utils/sgpol_app_theme.dart';
import 'package:apppmdfflutter/utils/show_erro_dialog.dart';
import 'package:apppmdfflutter/widgets/botao_outline_sgpol.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginCard extends StatefulWidget {
  @override
  _LoginCardState createState() => _LoginCardState();
}

class _LoginCardState extends State<LoginCard> {
  GlobalKey<FormState> _form = GlobalKey();
  bool _isLoading = false;
  bool _checked = false;
  bool _viewPass = false;
  final _usuarioController = TextEditingController();
  final _senhaController = TextEditingController();
  final Map<String, String> _loginData = {'usuario': '', 'senha': ''};

  @override
  void initState() {
    senha();
    super.initState();
  }

  @override
  void dispose() {
    _usuarioController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  void senha() {
    AuthProvider authProvider = Provider.of(context, listen: false);
    authProvider.getUserLocalStorage().then((value) {
      setState(() {
        _usuarioController.text = value['usuario'];
        _senhaController.text = value['senha'];
        if (value['usuario'] != '' || value['senha'] != '') _checked = true;
      });
    });
  }

  Future<void> _submit(bool value) async {
    if (!_form.currentState.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    _form.currentState.save();

    AuthProvider loginProvider = Provider.of(context, listen: false);

    try {
      await loginProvider
          .login(
            _loginData['usuario'].trim(),
            _loginData['senha'].trim(),
            _checked,
          )
          .then((value) => {
                if (loginProvider.isAuth)
                  {Navigator.of(context).pushNamed(AppRoutes.AUTH_HOME)}
              });
    } on AuthException catch (error) {
      showErrorDialogAuthLogout(error.toString(), context);
    } catch (e) {
      print(e);
      showErrorDialogAuthLogout("Erro desconhecido", context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return FadeAnimation(
      1.5,
      SingleChildScrollView(
        child: Container(
          width: deviceSize.width * 0.8,
          padding: EdgeInsets.all(10.0),
          child: Form(
            key: _form,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: TextFormField(
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                          ),
                          controller: _usuarioController,
                          decoration: InputDecoration(
                            labelText: 'Usuário',
                            labelStyle:
                                TextStyle(color: Theme.of(context).accentColor),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(29),
                              borderSide:
                                  BorderSide(color: Colors.red, width: 5.0),
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Informe um usuário válido!";
                            }
                            return null;
                          },
                          onSaved: (value) => _loginData['usuario'] = value,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: TextFormField(
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                          ),
                          controller: _senhaController,
                          decoration: InputDecoration(
                            labelText: 'Senha',
                            labelStyle:
                                TextStyle(color: Theme.of(context).accentColor),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(29),
                              borderSide:
                                  BorderSide(color: Colors.red, width: 5.0),
                            ),
                            suffixIcon: IconButton(
                              icon: _viewPass
                                  ? Icon(Icons.visibility_off,
                                      color: Colors.grey)
                                  : Icon(Icons.visibility),
                              onPressed: () {
                                setState(() {
                                  _viewPass = !_viewPass;
                                });
                              },
                            ),
                          ),
                          obscureText: _viewPass ? false : true,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Informe uma senha válida!";
                            }
                            return null;
                          },
                          onSaved: (value) => _loginData['senha'] = value,
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            CheckboxListTile(
                              checkColor: Theme.of(context).primaryColor,
                              activeColor: Colors.greenAccent,
                              title: Text(
                                "Salvar Senha",
                                style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                ),
                              ),
                              secondary: Icon(
                                Icons.security,
                                color: Theme.of(context).accentColor,
                              ),
                              value: _checked,
                              onChanged: (_) {
                                setState(() {
                                  _checked = !_checked;
                                });
                              },
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      if (_isLoading)
                        CircularProgressIndicator(
                          backgroundColor: Colors.white,
                          color: SgpolAppTheme.grey,
                        )
                      else
                        FadeAnimation(
                          1.3,
                          Container(
                            width: deviceSize.height * 0.3,
                            child:
                            BotaoOutlineSgpol(
                              iconButton: Icons.input,
                              textButton: 'ENTRAR',
                              onpressButton: _submit,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
