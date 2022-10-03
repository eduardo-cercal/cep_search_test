import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TodayTabView extends StatelessWidget {
  const TodayTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const CameraPosition initialCameraTest =
        CameraPosition(target: LatLng(37.42796133580664, -122.085749655962));
    Completer<GoogleMapController> _controller = Completer();

    return FutureBuilder(
      future: _test(),
      builder: (context, snapshot) => snapshot.hasData
          ? ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) => Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: ExpansionTile(
                  title: Text(snapshot.data![index]["cep"]),
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
                          Text(snapshot.data![index]["bairro"]),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 300,
                      height: 300,
                      child: GoogleMap(
                        mapType: MapType.normal,
                        initialCameraPosition: initialCameraTest,
                        onMapCreated: (GoogleMapController controller) =>
                            _controller.complete(controller),
                      ),
                    )
                  ],
                ),
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Future<List<Map<String, dynamic>>> _test() async {
    await Future.delayed(const Duration(seconds: 3));
    return [
      {
        "cep": "81730-010",
        "bairro": "Boqueirão",
      },
      {
        "cep": "81654-010",
        "bairro": "Boqueirão",
      },
      {
        "cep": "81730-040",
        "bairro": "Boqueirão",
      }
    ];
  }
}
