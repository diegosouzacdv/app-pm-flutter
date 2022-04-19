class IsViaturaVistoria {
  int idViatura;
  int idVistoria;
  String placa;
  String prefixo;
  String modelo;
  String status;
  String lotacao;
  String marcaSigla;
  String motoristaMatricula;

  IsViaturaVistoria(
      {this.idViatura,
      this.idVistoria,
      this.placa,
      this.prefixo,
      this.modelo,
      this.status,
      this.lotacao,
      this.marcaSigla,
      this.motoristaMatricula});

  IsViaturaVistoria.fromJson(Map<String, dynamic> json) {
    idViatura = json['idViatura'];
    idVistoria = json['idVistoria'];
    placa = json['placa'];
    prefixo = json['prefixo'];
    modelo = json['modelo'];
    status = json['status'];
    lotacao = json['lotacao'];
    marcaSigla = json['marcaSigla'];
    motoristaMatricula = json['motoristaMatricula'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idViatura'] = this.idViatura;
    data['idVistoria'] = this.idVistoria;
    data['placa'] = this.placa;
    data['prefixo'] = this.prefixo;
    data['modelo'] = this.modelo;
    data['status'] = this.status;
    data['lotacao'] = this.lotacao;
    data['marcaSigla'] = this.marcaSigla;
    data['motoristaMatricula'] = this.motoristaMatricula;
    return data;
  }
}

