import 'package:cep_search_test/home/controller/home_controller.dart';
import 'package:cep_search_test/model/cep_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../model/date_model.dart';

class AllTabView extends StatelessWidget {
  final homeController = Get.find<HomeController>();

  AllTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () => homeController.allSearch());
    return Obx(
      () {
        if (homeController.loadingList.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return homeController.dateList.isEmpty
            ? const Text(
                "Nenhuma pesquisa feita",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              )
            : ListView.builder(
                itemCount: homeController.dateList.length,
                itemBuilder: (context, index) {
                  final DateModel item = homeController.dateList[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: ExpansionTile(
                      title: Text(
                        '${DateFormat("dd/MM/yyyy").format(item.dateTime)} (${item.count})',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      children: _getChildren(item.dateTime),
                    ),
                  );
                },
              );
      },
    );
  }

  List<Widget> _getChildren(dateTime) {
    List<Widget> children = [];
    for (var element in homeController.cepDateList) {
      for (CepModel cep in element[dateTime]) {
        children.add(Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '${cep.cep} - ${cep.bairro}',
            style: const TextStyle(fontSize: 17),
            textAlign: TextAlign.justify,
          ),
        ));
      }
    }
    return children;
  }
}
