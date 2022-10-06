import 'dart:async';

import 'package:cep_search_test/home/components/dialog/components/simple_search/controller/simple_search_controller.dart';
import 'package:cep_search_test/model/cep_model.dart';
import 'package:cep_search_test/model/date_model.dart';
import 'package:cep_search_test/sqlite.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

import '../components/dialog/components/advance_search/controller/advance_search_controller.dart';

class HomeController extends GetxController {
  final googleController = Completer<GoogleMapController>().obs;

  final loading = false.obs;

  final isSaving = false.obs;

  final loadingList = false.obs;

  final cepList = [].obs;

  final dateList = [].obs;

  final cepDateList = [].obs;

  Future<void> todaySearch(int date) async {
    loadingList.value = true;
    cepList.value = await DatabaseHelper.instance.getTodaySearch(date);
    loadingList.value = false;
  }

  Future<void> allSearch() async {
    loadingList.value = true;
    cepDateList.clear();
    dateList.value = await DatabaseHelper.instance.getAllDates();
    for (DateModel element in dateList) {
      final List<CepModel> listCep = await DatabaseHelper.instance
          .getTodaySearch(element.dateTime.millisecondsSinceEpoch);
      final map = {element.dateTime: listCep};
      cepDateList.add(map);
    }
    loadingList.value = false;
  }

  Future<void> saveCep() async {
    isSaving.value = true;
    final simpleSearchController = Get.find<SimpleSearchController>();
    final map = simpleSearchController.cepMap;
    final CepModel cepModel = CepModel(
        cep: map["cep"],
        bairro: map["bairro"],
        cidadeLatitude: map['cityLatitude'],
        cidadeLongitude: map['cityLongitude'],
        marcadorLatitude: map['markerLatitude'],
        marcadorLongitude: map["markerLongitude"],
        dateTime:
            DateTime.parse(DateFormat("yyyy-MM-dd").format(DateTime.now())));
    await DatabaseHelper.instance.insert(cepModel);
    isSaving.value = false;
  }

  void clearAll() {
    final simpleSearchController = Get.find<SimpleSearchController>();
    /*final advanceSearchController = Get.find<AdvanceSearchController>();*/

    simpleSearchController.cepController.value.clear();
    simpleSearchController.cepMap.clear();
    /*advanceSearchController.districtMap.clear();
    advanceSearchController.cityMap.clear();
    advanceSearchController.stateMap.clear();*/
  }
}
