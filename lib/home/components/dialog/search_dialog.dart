import 'package:cep_search_test/home/components/dialog/components/simple_search/simple_search.dart';
import 'package:cep_search_test/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'components/advance_search/advance_search.dart';

class SearchDialog extends StatelessWidget {
  final homeController = Get.find<HomeController>();

  SearchDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DefaultTabController(
        length: 2,
        child: SingleChildScrollView(
          child: Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  /*const TabBar(
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
                  ),*/
                  SimpleSearch(),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    height: MediaQuery.of(context).size.height * 0.07,
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          homeController.clearAll();
                          homeController.todaySearch(DateTime.parse(
                                  DateFormat("yyyy-MM-dd")
                                      .format(DateTime.now()))
                              .millisecondsSinceEpoch);
                          Get.back();
                        },
                        style: ButtonStyle(
                          shape: MaterialStateProperty.resolveWith(
                            (states) => RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        child: const Text(
                          "Visualizar Pesquisados",
                          style: TextStyle(fontSize: 16),
                        )),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
