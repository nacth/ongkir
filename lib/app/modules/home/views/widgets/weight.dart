import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/home_controller.dart';

class WeightWidget extends GetView<HomeController> {
  const WeightWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            autocorrect: false,
            controller: controller.weightC,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              labelText: "Berat Barang",
              hintText: "Berat Barang",
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              controller.convertWeight(value);
            },
          ),
        ),
        SizedBox(width: 10),
        Container(
          width: 150,
          child: DropdownSearch<String>(
            mode: Mode.BOTTOM_SHEET,
            showSelectedItem: true,
            showSearchBox: true,
            searchBoxDecoration: InputDecoration(
              hintText: "Cari satuan berat...",
              border: OutlineInputBorder(),
            ),
            items: [
              "ton",
              "kwintal",
              "kilogram",
              "hektogram",
              "dekagram",
              "gram",
              "desigram",
              "centigram",
              "miligram"
            ],
            label: "Satuan",
            onChanged: (value) {
              controller.convertWeight(value);
            },
            selectedItem: "gram",
          ),
        ),
      ],
    );
  }
}
