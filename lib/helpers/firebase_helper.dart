import 'package:cep_search_test/helpers/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/cep_model.dart';

class FireBaseHelper {
  static Future<void> insert(CepModel cepModel) async {
    final docCep = FirebaseFirestore.instance.collection(cepTable).doc();
    await docCep.set(cepModel.toMap());
  }

  static Future<List<CepModel>> getCep(int dateTime) async {
    final queryResult = FirebaseFirestore.instance
        .collection(cepTable)
        .where(dateTimeIns, isEqualTo: dateTime)
        .snapshots()
        .map(
          (event) => event.docs.map(
            (json) => CepModel.fromJson(
              json.data(),
            ),
          ).toList(),
    ).distinct().;


    print("11111111111");
    print(queryResult.length);
    print("2222222");

    return [];
  }
}
