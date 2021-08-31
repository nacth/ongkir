import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dropdown_search/dropdown_search.dart';

import '../views/widgets/province.dart';
import '../views/widgets/city.dart';
import '../views/widgets/weight.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ongkos Kirim Indonesia'),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: SafeArea(
        child: ListView(
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
            WeightWidget(),
            Padding(
              padding: const EdgeInsets.only(bottom: 25),
              child: DropdownSearch<Map<String, dynamic>>(
                mode: Mode.MENU,
                showClearButton: true,
                items: [
                  {"code": "jne", "name": "JNE"},
                  {"code": "pos", "name": "POS Indonesia"},
                  {"code": "tiki", "name": "TIKI"},
                ],
                label: "Tipe Kurir",
                hint: "Pilih tipe kurir...",
                onChanged: (value) {
                  if (value != null) {
                    controller.courier.value = value["code"];
                    controller.showButton();
                  } else {
                    controller.courier.value = "";
                    controller.hiddenButton.value = true;
                  }
                },
                itemAsString: (item) => "${item['name']}",
                popupItemBuilder: (context, item, isSelected) {
                  return Container(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      "${item['name']}",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  );
                },
              ),
            ),
            Obx(
              () => controller.hiddenButton.isTrue
                  ? SizedBox()
                  : ElevatedButton(
                      onPressed: () => controller.ongkosKirim(),
                      child: Text("CEK ONGKOS KIRIM"),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        primary: Colors.orange,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
