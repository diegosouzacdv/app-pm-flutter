class Versao {
  int id;
  String versao;
  String url;
  String observacao;
  String mensagemUsuario;

  Versao(
      {this.id, this.versao, this.url, this.observacao, this.mensagemUsuario});

  Versao.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    versao = json['versao'];
    url = json['url'];
    observacao = json['observacao'];
    mensagemUsuario = json['mensagemUsuario'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['versao'] = this.versao;
    data['url'] = this.url;
    data['observacao'] = this.observacao;
    data['mensagemUsuario'] = this.mensagemUsuario;
    return data;
  }


  @override
  String toString() {
    return 'id: $id, versao: $versao, url: $url, observacao: $observacao, mensagemUsuario: $mensagemUsuario' ;
  }
}