import 'package:cep_search_test/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../../helpers/api_service.dart';

class SimpleSearchController extends GetxController {
  final homeController = Get.find<HomeController>();

  final cepController = TextEditingController().obs;

  final cepMap = {}.obs;

  Future<void> getCepInfo(String cep) async {
    homeController.loading.value = true;
    final clearCep = cep.replaceAll(RegExp("[.-]"), "");
    final Map<String, dynamic> cepInfo = await ApiService.getCep(clearCep);
    /*cepInfo return success
    {
      cep: 81730 - 010,
      logradouro: Rua Anne Frank,
      complemento: de 4281/4282 ao fim,
      bairro: Boqueirão,
      localidade: Curitiba,
      uf: PR,
      ibge: 4106902,
      gia: ,
      ddd: 41,
      siafi: 7535
      }
      cepInfo return error
      {erro: true}
      */
    print(cepInfo.toString());
    if (cepInfo["cep"] != null) {
      List<Location> placeMarks = await locationFromAddress(
          "${cepInfo["bairro"]}, ${cepInfo["localidade"]}");
      List<Location> cityMarks =
          await locationFromAddress(cepInfo["localidade"]);
      Set<Marker> marker = {};
      List<Marker> markersList = [
        Marker(
            markerId: const MarkerId("dist"),
            position: LatLng(placeMarks[0].latitude, placeMarks[0].longitude),
            icon: BitmapDescriptor.defaultMarker)
      ];
      marker.addAll(markersList);

      cepMap.value = {
        "cep": cepInfo["cep"],
        "cidade": cepInfo["localidade"],
        "estado": cepInfo["uf"],
        "bairro": cepInfo["bairro"],
        "logradouro": cepInfo["logradouro"],
        "complemento": cepInfo["complemento"],
        "cityMarks": cityMarks,
        "marker": marker,
        "cityLatitude": cityMarks[0].latitude,
        "cityLongitude": cityMarks[0].longitude,
        "markerLatitude": placeMarks[0].latitude,
        "markerLongitude": placeMarks[0].longitude,
      };
    } else {
      cepMap.value = cepInfo;
    }

    homeController.loading.value = false;
  }
}
