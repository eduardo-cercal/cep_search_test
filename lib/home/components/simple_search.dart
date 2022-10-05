import 'dart:async';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:cep_search_test/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SimpleSearch extends StatelessWidget {
  final homeController = Get.find<HomeController>();

  SimpleSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaData = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Obx(
        () {
          final cepMap = homeController.simpleSearchCep;
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: homeController.textController.value,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () async => await homeController
                          .getCepInfo(homeController.textController.value.text),
                      icon: const FaIcon(
                        FontAwesomeIcons.magnifyingGlassLocation,
                      ),
                    ),
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CepInputFormatter()
                  ],
                  keyboardType: TextInputType.number,
                  onSubmitted: (text) async =>
                      await homeController.getCepInfo(text),
                ),
              ),
              homeController.loading.value
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : cepMap.isNotEmpty
                      ? cepMap["erro"] == null
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                elevation: 5,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      cepMap["cep"],
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    Text(
                                        "${cepMap["cidade"]}/${cepMap["estado"]}"),
                                    Text("Bairro: ${cepMap["bairro"]}"),
                                    Text("Logradouro: ${cepMap["logradouro"]}"),
                                    Text(
                                        "Complemento: ${cepMap["complemento"]}"),
                                    SizedBox(
                                      width: mediaData.width,
                                      height: mediaData.height * 0.5,
                                      child: GoogleMap(
                                        mapType: MapType.normal,
                                        initialCameraPosition: CameraPosition(
                                            target: LatLng(
                                                cepMap["cityMarks"][0].latitude,
                                                cepMap["cityMarks"][0]
                                                    .longitude),
                                            zoom: 11),
                                        markers: cepMap["marker"],
                                        onMapCreated:
                                            (GoogleMapController controller) =>
                                                homeController
                                                    .googleController.value
                                                    .complete(controller),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          : const Center(
                              child: Text(
                                  "CEP inválido\nTente a pesquisa avançada para achar o CEP Correto"),
                            )
                      : const Center(
                          child: Text("Pesquise um CEP"),
                        ),
            ],
          );
        },
      ),
    );
  }
}
