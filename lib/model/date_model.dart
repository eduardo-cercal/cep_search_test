import 'package:cep_search_test/helpers/constants.dart';

class DateModel {
  final DateTime dateTime;
  final int count;

  DateModel({required this.dateTime, required this.count});

  factory DateModel.fromJson(Map<String, dynamic> json) => DateModel(
      dateTime: DateTime.fromMillisecondsSinceEpoch(json[dateTimeIns]),
      count: json["count(*)"]);
}
