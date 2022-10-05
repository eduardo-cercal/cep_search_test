import 'package:cep_search_test/helpers/api_service.dart';
import 'package:get/get.dart';

import '../../../../../controller/home_controller.dart';

class AdvanceSearchController extends GetxController {
  final homeController = Get.find<HomeController>();

  final stateMap = {}.obs;

  final cityMap = {}.obs;

  final districtMap = {}.obs;

  Future<List> getStatesFromApi() async {
    homeController.loading.value = true;
    final List stateList = await ApiService.getState();
    homeController.loading.value = false;
    return stateList;
  }
}
