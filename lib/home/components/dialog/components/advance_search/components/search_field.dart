import 'package:cep_search_test/home/components/dialog/components/advance_search/components/state_selection_screen.dart';
import 'package:cep_search_test/home/components/dialog/components/advance_search/controller/advance_search_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class SearchField extends StatelessWidget {
  final String? controller;
  final String label;
  final IconData icon;
  final VoidCallback function;

  const SearchField(
      {Key? key,
      required this.controller,
      required this.label,
      required this.icon,
      required this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: function,
        child: TextField(
          controller: TextEditingController(text: controller),
          enabled: false,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            labelText: label,
            suffixIcon: IconButton(
              onPressed: function,
              icon: FaIcon(icon),
            ),
          ),
        ),
      ),
    );
  }
}
