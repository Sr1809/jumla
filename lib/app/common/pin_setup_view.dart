import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jumla/app/common/common_appbar.dart';
import 'package:jumla/app/common/common_button.dart';
import 'package:jumla/app/resources/app_colors.dart';

class PinSetupScreen extends StatelessWidget {
  /// Stores the PIN digits as the user types
  final RxString pin = ''.obs;

  /// Controls whether the PIN is shown or masked
  final RxBool showPin = false.obs;

  PinSetupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBarWithTitleAndIcon(title: "Setup PIN",hideLogo: true,),
      body: Column(
        children: [
          const SizedBox(height: 20),

          // Title text
          const Text(
            "Enter your new PIN",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          // "Show PIN" checkbox
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(
                    () => Checkbox(
                  value: showPin.value,
                  onChanged: (val) {
                    if (val != null) showPin.value = val;
                  },
                ),
              ),
              const Text("Show PIN"),
            ],
          ),

          // Display the PIN (masked or unmasked)
          Obx(
                () => Text(
              showPin.value
                  ? pin.value
                  : pin.value.replaceAll(RegExp('.'), '*'),
              style: const TextStyle(fontSize: 28, letterSpacing: 8),
            ),
          ),

          const SizedBox(height: 20),

          // Numeric keypad
          Expanded(child: _buildKeypad()),

          // Bottom buttons: CONTINUE, CANCEL
          SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CommonElevatedButton(
                  onPressed: () {
                    // Example check: ensure user typed at least 4 digits
                    if (pin.value.length >= 4) {
                      // TODO: Store the PIN or proceed with lock logic
                      Get.back(); // close the screen
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("PIN must be at least 4 digits")),
                      );
                    }
                  },
                  text: 'CONTINUE',
                ),
                CommonElevatedButton(
                  onPressed: () => Get.back(),
                  text: "CANCEL",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Builds a 4x3 grid of keypad buttons:
  /// 1 2 3
  /// 4 5 6
  /// 7 8 9
  /// * 0 <
  Widget _buildKeypad() {
    return GridView.count(
      crossAxisCount: 3,
      childAspectRatio: 1.4,
      padding: const EdgeInsets.all(20),
      children: [
        _buildKey("1"), _buildKey("2"), _buildKey("3"),
        _buildKey("4"), _buildKey("5"), _buildKey("6"),
        _buildKey("7"), _buildKey("8"), _buildKey("9"),
        _buildKey("*"), _buildKey("0"), _buildKey("<"),
      ],
    );
  }

  /// Individual button in the keypad
  Widget _buildKey(String keyVal) {
    return InkWell(
      onTap: () {
        if (keyVal == "<") {
          // Remove last character if any
          if (pin.value.isNotEmpty) {
            pin.value = pin.value.substring(0, pin.value.length - 1);
          }
        } else {
          // Limit PIN to 6 digits (change if you prefer 4, etc.)
          if (pin.value.length < 6) {
            pin.value += keyVal;
          }
        }
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            keyVal,
            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
