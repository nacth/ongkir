import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

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
          DropdownSearch(
            label: "Provinsi Asal",
            showSearchBox: true,
            searchBoxDecoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              hintText: "Cari Provinsi...",
            ),
            showClearButton: true,
            items: [
              "Jawa Timur",
              "Jawa Tengah",
              "Jawa Barat",
            ],
          )
        ],
      ),
    );
  }
}
