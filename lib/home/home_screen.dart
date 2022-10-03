import 'package:cep_search_test/home/components/floating_button.dart';
import 'package:cep_search_test/home/components/today_tab_view.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

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
            const TodayTabView(),
            ListView.builder(
              itemBuilder: (context, index) => const ExpansionTile(
                title: Text("01/10/2022"),
                children: [
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
