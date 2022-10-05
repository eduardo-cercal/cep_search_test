import 'package:cep_search_test/home/components/dialog/components/simple_search/simple_search.dart';
import 'package:cep_search_test/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/advance_search/advance_search.dart';

class SearchDialog extends StatelessWidget {
  final homeController = Get.find<HomeController>();

  SearchDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const TabBar(
                labelColor: Colors.black,
                tabs: [
                  Tab(
                    text: "Pesq. simples",
                  ),
                  Tab(
                    text: "Pesq. Avançada",
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(children: [
                  SimpleSearch(),
                  AdvanceSearch(),
                ]),
              ),
              ElevatedButton(
                  onPressed: () {
                    homeController.clearAll();
                    Get.back();
                  },
                  child: const Text("Visualizar Pesquisados"))
            ],
          ),
        ),
      ),
    );
  }
}
