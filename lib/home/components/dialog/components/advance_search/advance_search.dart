import 'package:cep_search_test/home/components/dialog/components/advance_search/controller/advance_search_controller.dart';
import 'package:cep_search_test/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'components/search_field.dart';
import 'components/state_selection_screen.dart';

class AdvanceSearch extends StatelessWidget {
  final advanceSearchController = Get.put(AdvanceSearchController());
  final homeController = Get.find<HomeController>();

  AdvanceSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          SearchField(
            controller: advanceSearchController.stateMap["nome"],
            label: 'Estado',
            icon: FontAwesomeIcons.magnifyingGlassLocation,
            function: () => Get.to(const StateSelectionScreen()),
          ),
          if (advanceSearchController.stateMap.isNotEmpty)
            SearchField(
              controller: advanceSearchController.cityMap["nome"],
              label: 'Cidade',
              icon: FontAwesomeIcons.magnifyingGlassLocation,
              function: () {},
            ),
          if (advanceSearchController.stateMap.isNotEmpty &&
              advanceSearchController.cityMap.isNotEmpty)
            SearchField(
              controller: advanceSearchController.districtMap["name"],
              label: 'Bairro',
              icon: FontAwesomeIcons.magnifyingGlassLocation,
              function: () {},
            ),
        ],
      ),
    );
  }
}
