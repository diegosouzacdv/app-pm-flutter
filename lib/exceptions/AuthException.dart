class AuthException implements Exception {
  static const Map<String, String> errors = {
    "Login e/ou Senha inv&aacute;lidos.": "Usuário e/ou Senha inválidos",
    "500": "Serviço temporariamente indisponível, tente mais tarde."
  };

  final String msg;

  const AuthException(this.msg);

  @override
  String toString() {
    print(errors.containsKey(msg));
    if (errors.containsKey(msg)) {
      return errors[msg];
    } else {
      return "Serviço temporariamente indisponível, tente mais tarde.";
    }
  }
}
