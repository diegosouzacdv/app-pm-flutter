class ViaturaDTO {
  int id;
  int odometro;
  int odometroProximaRevisao;
  String placa;
  String prefixo;
  String marca;
  String modelo;
  String status;
  String ufPlaca;
  String placaVinculada;
  String chassi;
  String tombamento;
  String renavam;
  int anoFabricacao;
  int anoModelo;
  String dataInclusao;
  String dataProximaRevisao;
  String tipoCombustivel;
  String tipoViatura;
  String lotacao;
  int lotacaoCodigo;
  int lotacaoCodigoSubordinacao;
  String lotacaoSubordinacao;
  String marcaSigla;
  String motorista;

  ViaturaDTO({
    this.id,
    this.odometro,
    this.odometroProximaRevisao,
    this.placa,
    this.prefixo,
    this.marca,
    this.modelo,
    this.status,
    this.ufPlaca,
    this.placaVinculada,
    this.chassi,
    this.tombamento,
    this.renavam,
    this.anoFabricacao,
    this.anoModelo,
    this.dataInclusao,
    this.dataProximaRevisao,
    this.tipoCombustivel,
    this.tipoViatura,
    this.lotacao,
    this.lotacaoCodigo,
    this.lotacaoCodigoSubordinacao,
    this.lotacaoSubordinacao,
    this.marcaSigla,
    this.motorista,
  });

  ViaturaDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    placa = json['placa'];
    prefixo = json['prefixo'];
    marca = json['marca'];
    modelo = json['modelo'];
    status = json['status'];
    ufPlaca = json['ufPlaca'];
    placaVinculada = json['placaVinculada'];
    chassi = json['chassi'];
    tombamento = json['tombamento'];
    renavam = json['renavam'];
    anoFabricacao = json['anoFabricacao'];
    anoModelo = json['anoModelo'];
    dataInclusao = json['dataInclusao'];
    dataProximaRevisao = json['dataProximaRevisao'];
    tipoCombustivel = json['tipoCombustivel'];
    tipoViatura = json['tipoViatura'];
    lotacao = json['lotacao'];
    lotacaoCodigo = json['lotacaoCodigo'];
    lotacaoCodigoSubordinacao = json['lotacaoCodigoSubordinacao'];
    lotacaoSubordinacao = json['lotacaoSubordinacao'];
    marcaSigla = json['marcaSigla'];
    motorista = json['motorista'];
    odometroProximaRevisao = json['odometroProximaRevisao'];
    odometro = json['odometro'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['placa'] = this.placa;
    data['prefixo'] = this.prefixo;
    data['marca'] = this.marca;
    data['modelo'] = this.modelo;
    data['status'] = this.status;
    data['ufPlaca'] = this.ufPlaca;
    data['placaVinculada'] = this.placaVinculada;
    data['chassi'] = this.chassi;
    data['tombamento'] = this.tombamento;
    data['renavam'] = this.renavam;
    data['anoFabricacao'] = this.anoFabricacao;
    data['anoModelo'] = this.anoModelo;
    data['dataInclusao'] = this.dataInclusao;
    data['dataProximaRevisao'] = this.dataProximaRevisao;
    data['tipoCombustivel'] = this.tipoCombustivel;
    data['tipoViatura'] = this.tipoViatura;
    data['lotacao'] = this.lotacao;
    data['lotacaoCodigo'] = this.lotacaoCodigo;
    data['lotacaoCodigoSubordinacao'] = this.lotacaoCodigoSubordinacao;
    data['lotacaoSubordinacao'] = this.lotacaoSubordinacao;
    data['marcaSigla'] = this.marcaSigla;
    data['motorista'] = this.motorista;
    data['odometroProximaRevisao'] = this.odometroProximaRevisao;
    data['odometro'] = this.odometro;
    return data;
  }
}


