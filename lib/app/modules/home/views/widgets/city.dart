import 'dart:convert';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../controllers/home_controller.dart';
import '../../city_model.dart';

class CityWidget extends GetView<HomeController> {
  const CityWidget({
    required this.provId,
    required this.type,
    Key? key,
  }) : super(key: key);

  final int provId;
  final String type;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: DropdownSearch<City>(
        label: type == "origin"
            ? "Kota / Kabupaten Asal"
            : "Kota / Kabupaten Tujuan",
        showClearButton: true,
        onFind: (String filter) async {
          Uri url = Uri.parse(
              "https://api.rajaongkir.com/starter/city?province=$provId");

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

            var listAllCity = data["rajaongkir"]["results"] as List<dynamic>;

            var models = City.fromJsonList(listAllCity);
            return models;
          } catch (error) {
            return List<City>.empty();
          }
        },
        onChanged: (city) {
          if (city == null) {
            if (type == "origin") {
              print("Tidak memilih Kota / Kabupaten Asal");
              controller.cityOriginId.value = 0;
            } else {
              print("Tidak memilih Kota / Kabupaten Tujuan");
              controller.cityDestinationId.value = 0;
            }
          } else {
            if (type == "origin") {
              controller.cityOriginId.value = int.parse(city.cityId as String);
            } else {
              controller.cityDestinationId.value =
                  int.parse(city.cityId as String);
            }
          }
          controller.showButton();
        },
        showSearchBox: true,
        searchBoxDecoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
          hintText: "Cari Kota / Kabupaten...",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        popupItemBuilder: (context, item, isSelected) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text("${item.type} ${item.cityName}",
                style: TextStyle(fontSize: 18)),
          );
        },
        itemAsString: (item) => "${item.type} ${item.cityName}",
      ),
    );
  }
}
