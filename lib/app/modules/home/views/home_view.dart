import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body: InkWell(
        onTap: () {
          _showPopup();
        },
        child: const Center(
          child: Text(
            'HomeView is working',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }

  void _showPopup() {
    Get.defaultDialog(
      radius: 0.0,
      title: "More shortcuts",
      titleStyle: TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(thickness: 1, color: Colors.blue),
          Column(
            children: ['ds', 'dsdsa', 'dsd'].map((key) {
              return CheckboxListTile(
                title: Text(key, style: TextStyle(fontWeight: FontWeight.bold)),
                value: true,
                onChanged: (bool? value) {
                  // controller.shortcuts[key] = value ?? false;
                },
                activeColor: Colors.blue,
                checkColor: Colors.white,
              );
            }).toList(),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => Get.back(),
            child: Text("Done"),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(title, style: TextStyle(fontSize: 16)),
    );
  }
}
