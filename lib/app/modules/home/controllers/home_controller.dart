import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var hiddenCityOrigin = true.obs;
  var provOriginId = 0.obs;
  var cityOriginId = 0.obs;

  var hiddenCityDestination = true.obs;
  var provDestinationId = 0.obs;
  var cityDestinationId = 0.obs;

  double weight = 0.0;
  String unitWeight = "gram";

  late TextEditingController weightC;

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
