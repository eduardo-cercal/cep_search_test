import 'package:cep_search_test/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class AllTabView extends StatelessWidget {
  final homeController = Get.find<HomeController>();

  AllTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaData = MediaQuery.of(context).size;
    return Obx(
      () {
        if (homeController.loadingList.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
          itemCount: homeController.cepList.length,
          itemBuilder: (context, index) {
            final item = homeController.cepList[index];
            return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: ExpansionTile(
                title: Text(item.cep),
                children: [],
              ),
            );
          },
        );
      },
    );
  }
}
