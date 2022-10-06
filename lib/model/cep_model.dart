import 'package:cep_search_test/helpers/constants.dart';

class CepModel {
  int? id;
  String cep;
  String bairro;
  num cidadeLatitude;
  num cidadeLongitude;
  num marcadorLatitude;
  num marcadorLongitude;
  DateTime dateTime;

  CepModel(
      {this.id,
      required this.cep,
      required this.bairro,
      required this.cidadeLatitude,
      required this.cidadeLongitude,
      required this.marcadorLatitude,
      required this.marcadorLongitude,
      required this.dateTime});

  factory CepModel.fromJson(Map<String, dynamic> json) => CepModel(
      cep: json[zipcode],
      bairro: json[district],
      cidadeLatitude: json[cityLatitude],
      cidadeLongitude: json[cityLongitude],
      marcadorLatitude: json[markerLatitude],
      marcadorLongitude: json[markerLongitude],
      dateTime: DateTime.fromMillisecondsSinceEpoch(json[dateTimeIns]));

  Map<String, dynamic> toMap() => {
        zipcode: cep,
        district: bairro,
        cityLatitude: cidadeLatitude,
        cityLongitude: cidadeLongitude,
        markerLatitude: marcadorLatitude,
        markerLongitude: marcadorLongitude,
        dateTimeIns: dateTime.millisecondsSinceEpoch
      };
}
