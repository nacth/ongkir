import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../views/widgets/province.dart';
import '../views/widgets/city.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ongkos Kirim Indonesia'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          ProvinceWidget(type: "origin"),
          Obx(
            () => controller.hiddenCityOrigin.isTrue
                ? SizedBox()
                : CityWidget(
                    provId: controller.provOriginId.value,
                    type: "origin",
                  ),
          ),
          ProvinceWidget(type: "destination"),
          Obx(
            () => controller.hiddenCityDestination.isTrue
                ? SizedBox()
                : CityWidget(
                    provId: controller.provDestinationId.value,
                    type: "destination",
                  ),
          ),
        ],
      ),
    );
  }
}
