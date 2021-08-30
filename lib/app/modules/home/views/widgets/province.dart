import 'dart:convert';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../controllers/home_controller.dart';
import '../../province_model.dart';

class ProvinceWidget extends GetView<HomeController> {
  const ProvinceWidget({
    Key? key,
    required this.type,
  }) : super(key: key);

  final String type;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: DropdownSearch<Province>(
        label: type == "origin" ? "Provinsi Asal" : "Provinsi Tujuan",
        showClearButton: true,
        onFind: (String filter) async {
          Uri url = Uri.parse("https://api.rajaongkir.com/starter/province");

          try {
            final response = await http.get(
              url,
              headers: {"key": "1b34ed35dc3f4a13eacb28fced5c8ef5"},
            );

            var data = json.decode(response.body) as Map<String, dynamic>;

            var statusCode = data["rajaongkir"]["status"]["code"];
            var statusDescription = data["rajaongkir"]["status"]["description"];

            if (statusCode != 200) {
              throw statusDescription;
            }

            var listAllProvince =
                data["rajaongkir"]["results"] as List<dynamic>;

            var models = Province.fromJsonList(listAllProvince);
            return models;
          } catch (error) {
            return List<Province>.empty();
          }
        },
        onChanged: (province) {
          if (province == null) {
            if (type == "origin") {
              controller.hiddenCityOrigin.value = true;
              controller.provOriginId.value = 0;
            } else {
              controller.hiddenCityDestination.value = true;
              controller.provDestinationId.value = 0;
            }
          } else {
            if (type == "origin") {
              controller.hiddenCityOrigin.value = false;
              controller.provOriginId.value =
                  int.parse(province.provinceId as String);
            } else {
              controller.hiddenCityDestination.value = false;
              controller.provDestinationId.value =
                  int.parse(province.provinceId as String);
            }
          }
        },
        showSearchBox: true,
        searchBoxDecoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
          hintText: "Cari Provinsi...",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        popupItemBuilder: (context, item, isSelected) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text("${item.province}", style: TextStyle(fontSize: 18)),
          );
        },
        itemAsString: (item) => item.province as String,
      ),
    );
  }
}
