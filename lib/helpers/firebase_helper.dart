import 'package:cep_search_test/helpers/constants.dart';
import 'package:cep_search_test/model/date_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../model/cep_model.dart';

class FireBaseHelper {
  static Future<void> insertCep(CepModel cepModel) async {
    final doc = FirebaseFirestore.instance.collection(cepTable).doc();
    await doc.set(cepModel.toMap());
  }

  static Future<void> insertDateTimeCount(DateTime today) async {
    final doc = await FirebaseFirestore.instance
        .collection(dateTimeCount)
        .doc(today.millisecondsSinceEpoch.toString())
        .get();
    final newDoc = FirebaseFirestore.instance
        .collection(dateTimeCount)
        .doc(today.millisecondsSinceEpoch.toString());

    if (doc.exists) {
      DateModel dateModel =
          DateModel(dateTime: today, contador: doc.get(count) + 1);
      await newDoc.update(dateModel.toMap());
    } else {
      DateModel dateModel = DateModel(dateTime: today, contador: 1);
      await newDoc.set(dateModel.toMap());
    }
  }

  static Future<List<CepModel>> getCep(int dateTime) async {
    final queryResult = await FirebaseFirestore.instance
        .collection(cepTable)
        .where(dateTimeIns, isEqualTo: dateTime)
        .get();

    final List<CepModel> cepList = [];

    for (var element in queryResult.docs) {
      cepList.add(CepModel.fromJson(element.data()));
    }

    return cepList;
  }

  static Future<List<DateModel>> getDateTimeCount() async {
    final queryResult = await FirebaseFirestore.instance.collection(dateTimeCount).get();
    final List<DateModel> list = [];

    for(var element in queryResult.docs){
      list.add(DateModel.fromJson(element.data()));
    }

    return list;
  }
}
