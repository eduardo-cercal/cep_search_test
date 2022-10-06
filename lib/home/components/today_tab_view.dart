import 'dart:async';

import 'package:cep_search_test/home/controller/home_controller.dart';
import 'package:cep_search_test/model/cep_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class TodayTabView extends StatelessWidget {
  final homeController = Get.find<HomeController>();

  TodayTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Completer<GoogleMapController> _controller = Completer();
    final mediaData = MediaQuery.of(context).size;
    homeController.todaySearch(
        DateTime.parse(DateFormat("yyyy-MM-dd").format(DateTime.now()))
            .millisecondsSinceEpoch);
    return Obx(
      () {
        if (homeController.loadingList.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return homeController.cepList.isEmpty
            ? const Center(
                child: Text("Nenhuma pesquisa feita hoje"),
              )
            : ListView.builder(
                itemCount: homeController.cepList.length,
                itemBuilder: (context, index) {
                  final item = homeController.cepList[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: ExpansionTile(
                      title: Text(item.cep),
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            children: [
                              const FaIcon(
                                FontAwesomeIcons.locationDot,
                                size: 20,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(item.bairro),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: mediaData.width,
                          height: mediaData.height * 0.5,
                          child: GoogleMap(
                            mapType: MapType.normal,
                            initialCameraPosition: CameraPosition(
                                target: LatLng(item.marcadorLatitude.toDouble(),
                                    item.marcadorLongitude.toDouble()),
                                zoom: 11),
                            markers: {
                              Marker(
                                  markerId: const MarkerId("dist"),
                                  position: LatLng(
                                      item.marcadorLatitude.toDouble(),
                                      item.marcadorLongitude.toDouble()),
                                  icon: BitmapDescriptor.defaultMarker)
                            },
                            onMapCreated: (GoogleMapController controller) =>
                                _controller.complete(controller),
                            gestureRecognizers: Set()
                              ..add(Factory<PanGestureRecognizer>(
                                  () => PanGestureRecognizer())),
                          ),
                        )
                      ],
                    ),
                  );
                },
              );
      },
    );
  }
}
