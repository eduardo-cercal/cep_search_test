import 'package:cep_search_test/helpers/constants.dart';

class DateModel {
  final DateTime dateTime;
  final int contador;

  DateModel({required this.dateTime, required this.contador});

  factory DateModel.fromJson(Map<String, dynamic> json) => DateModel(
      dateTime: DateTime.fromMillisecondsSinceEpoch(json[dateTimeIns]),
      contador: json[count]);

  Map<String, dynamic> toMap() =>
      {dateTimeIns: dateTime.millisecondsSinceEpoch, count: contador};
}
