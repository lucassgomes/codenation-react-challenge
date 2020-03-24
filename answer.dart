import 'dart:convert';

class Answer {
  int _numeroCasas;
  String _token;
  String _cifrado;
  String _decifrado;
  String _resumoCriptografico;

  Answer(
      {int numeroCasas,
      String token,
      String cifrado,
      String decifrado,
      String resumoCriptografico}) {
    this._numeroCasas = numeroCasas;
    this._token = token;
    this._cifrado = cifrado;
    this._decifrado = decifrado;
    this._resumoCriptografico = resumoCriptografico;
  }

  int get numeroCasas => _numeroCasas;
  set numeroCasas(int numeroCasas) => _numeroCasas = numeroCasas;
  String get token => _token;
  set token(String token) => _token = token;
  String get cifrado => _cifrado;
  set cifrado(String cifrado) => _cifrado = cifrado;
  String get decifrado => _decifrado;
  set decifrado(String decifrado) => _decifrado = decifrado;
  String get resumoCriptografico => _resumoCriptografico;
  set resumoCriptografico(String resumoCriptografico) =>
      _resumoCriptografico = resumoCriptografico;

  factory Answer.fromJson(Map<String, dynamic> json) => Answer(
      numeroCasas: json['numero_casas'],
      token: json['token'],
      cifrado: json['cifrado'],
      decifrado: json['decifrado'],
      resumoCriptografico: json['resumo_criptografico']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['numero_casas'] = this._numeroCasas;
    data['token'] = this._token;
    data['cifrado'] = this._cifrado;
    data['decifrado'] = this._decifrado;
    data['resumo_criptografico'] = this._resumoCriptografico;
    return data;
  }
}
