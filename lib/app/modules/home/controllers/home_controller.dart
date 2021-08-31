import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../courier_model.dart';

class HomeController extends GetxController {
  var hiddenCityOrigin = true.obs;
  var provOriginId = 0.obs;
  var cityOriginId = 0.obs;

  var hiddenCityDestination = true.obs;
  var provDestinationId = 0.obs;
  var cityDestinationId = 0.obs;

  var hiddenButton = true.obs;

  var courier = "".obs;

  double weight = 0.0;
  String unitWeight = "gram";

  late TextEditingController weightC;

  void ongkosKirim() async {
    Uri url = Uri.parse("https://api.rajaongkir.com/starter/cost");

    try {
      final response = await http.post(
        url,
        headers: {
          "content-type": "application/x-www-form-urlencoded",
          "key": "1b34ed35dc3f4a13eacb28fced5c8ef5",
        },
        body: {
          "origin": "$cityOriginId",
          "destination": "$cityDestinationId",
          "weight": "$weight",
          "courier": "$courier",
        },
      );
      var data = json.decode(response.body) as Map<String, dynamic>;
      var results = data["rajaongkir"]["results"] as List<dynamic>;

      var listAllCost = Courier.fromJsonList(results);
      var courierData = listAllCost[0];

      Get.defaultDialog(
          title: courierData.name as String,
          content: Column(
            children: courierData.costs!
                .map(
                  (e) => ListTile(
                    title: Text("${e.description} (${e.service})"),
                    subtitle: Text("Rp. ${e.cost![0].value}"),
                    trailing: Text(courierData.code == "pos"
                        ? "${e.cost![0].etd}"
                        : "${e.cost![0].etd} Hari"),
                  ),
                )
                .toList(),
          ));
    } catch (error) {
      Get.defaultDialog(
        title: "Terjadi Kesalahan!",
        middleText: error.toString(),
      );
    }
  }

  void showButton() {
    if (cityOriginId != 0 &&
        cityDestinationId != 0 &&
        weight > 0 &&
        courier != "") {
      hiddenButton.value = false;
    } else {
      hiddenButton.value = true;
    }
  }

  void convertWeight(String? value) {
    weight = double.tryParse(value!) ?? 0.0;
    String unitCheck = unitWeight;
    switch (unitCheck) {
      case "ton":
        weight *= 1000000;
        break;
      case "kwintal":
        weight *= 100000;
        break;
      case "kilogram":
        weight *= 1000;
        break;
      case "hektogram":
        weight *= 100;
        break;
      case "dekagram":
        weight *= 10;
        break;
      case "gram":
        weight *= 1;
        break;
      case "desigram":
        weight *= 0.1;
        break;
      case "centigram":
        weight *= 0.01;
        break;
      case "miligram":
        weight *= 0.001;
        break;
      default:
        weight = weight;
    }

    print("$weight gram");
    showButton();
  }

  void convertUnit(String? value) {
    weight = double.tryParse(weightC.text) ?? 0.0;
    switch (value) {
      case "ton":
        weight *= 1000000;
        break;
      case "kwintal":
        weight *= 100000;
        break;
      case "kilogram":
        weight *= 1000;
        break;
      case "hektogram":
        weight *= 100;
        break;
      case "dekagram":
        weight *= 10;
        break;
      case "gram":
        weight *= 1;
        break;
      case "desigram":
        weight *= 0.1;
        break;
      case "centigram":
        weight *= 0.01;
        break;
      case "miligram":
        weight *= 0.001;
        break;
      default:
        weight = weight;
    }

    unitWeight = value!;
    print("$weight gram");
    showButton();
  }

  @override
  void onInit() {
    weightC = TextEditingController(text: "$weight");
    super.onInit();
  }

  @override
  void onClose() {
    weightC.dispose();
    super.onClose();
  }
}
