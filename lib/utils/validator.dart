class ValidatorForm {
  static String validatorUser(value) {
    if (value.isEmpty) {
      return "Informe um usuário válido!";
    }
    return '';
  }
}
