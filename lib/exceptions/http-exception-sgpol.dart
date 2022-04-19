class HttpExceptionSGpol implements Exception {
  static const Map<String, String> errors = {
    "Internal Server Error": "Serviço temporariamente indisponível, tente mais tarde.",
    "unauthorized": "Não Autorizado",
    "invalid_token": "FAÇA NOVO LOGIN",
  };

  final String msg;

  const HttpExceptionSGpol(this.msg);

  @override
  String toString() {
    if (errors.containsKey(msg)) {
      return errors[msg];
    } else {
      return "Erro, tente mais tarde!";
    }
  }
}
