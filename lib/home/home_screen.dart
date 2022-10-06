import 'package:cep_search_test/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/all_tab_view.dart';
import 'components/floating_button.dart';
import 'components/today_tab_view.dart';

class HomePage extends StatelessWidget {
  final homeController = Get.put(HomeController());

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: const Text("CEPs pesquisados"),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(
                text: "Hoje",
              ),
              Tab(
                text: "Todas",
              )
            ],
          ),
        ),
        floatingActionButton: const FloatingButton(),
        body: TabBarView(
          children: [
            TodayTabView(),
            AllTabView(),
          ],
        ),
      ),
    );
  }
}
