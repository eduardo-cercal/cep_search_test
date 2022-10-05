import 'dart:async';

import 'package:cep_search_test/home/components/dialog/components/simple_search/controller/simple_search_controller.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../components/dialog/components/advance_search/controller/advance_search_controller.dart';

class HomeController extends GetxController {
  final googleController = Completer<GoogleMapController>().obs;

  final loading = false.obs;

  final isSaving = false.obs;

  Future<void> saveCep() async {
    isSaving.value = true;
    await Future.delayed(Duration(seconds: 3));
    isSaving.value = false;
  }

  void clearAll() {
    final simpleSearchController = Get.find<SimpleSearchController>();
    final advanceSearchController = Get.find<AdvanceSearchController>();

    simpleSearchController.cepController.value.clear();
    simpleSearchController.cepMap.clear();
    advanceSearchController.districtMap.clear();
    advanceSearchController.cityMap.clear();
    advanceSearchController.stateMap.clear();
  }
}
