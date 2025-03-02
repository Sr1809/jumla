import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../resources/app_styles.dart';
import '../resources/app_colors.dart';

class CommonPicker {
  static void showCountryPopup(BuildContext context, Function(String) onSelect) {
    List<String> countries = [
      "Argentina ES",
      "Australia EN",
      "Austria DE",
      "Belgium NL",
      "Brazil PT",
      "Canada EN",
      "Canada FR",
      "Finland FI",
      "France FR",
      "Germany DE",
      "Greece EL",
      "India EN",
      "Indonesia EN",
    ];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Select your locale", style: AppTextStyles.bold(fontSize: 18.0, fontColor: AppColors.blueColor)),
              SizedBox(height: 5),
              Divider(color: AppColors.blueColor, thickness: 2),
            ],
          ),
          content: Container(
            width: double.maxFinite,
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: countries.length,
              separatorBuilder: (context, index) => Divider(color: AppColors.greyColor),
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: GestureDetector(
                    onTap: () {
                      onSelect(countries[index]);
                      Navigator.pop(context);
                    },
                    child: Text(
                      countries[index],
                      style: AppTextStyles.regular(fontSize: 16.0, fontColor: AppColors.blackColor),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  static void selectDateFormatPopup(BuildContext context, Function(String) onSelect) {
    List<String> optionList = [
      "Short date",
      "Medium date",
      "Long date",

    ];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Select date format", style: AppTextStyles.bold(fontSize: 18.0, fontColor: AppColors.blueColor)),
              SizedBox(height: 5),
              Divider(color: AppColors.blueColor, thickness: 2),
            ],
          ),
          content: Container(
            width: double.maxFinite,
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: optionList.length,
              separatorBuilder: (context, index) => Divider(color: AppColors.greyColor),
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: GestureDetector(
                    onTap: () {
                      onSelect(optionList[index]);
                      Navigator.pop(context);
                    },
                    child: Text(
                      optionList[index],
                      style: AppTextStyles.regular(fontSize: 16.0, fontColor: AppColors.blackColor),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  static void selectTaxTypePopup(BuildContext context, Function(String) onSelect) {
    List<String> optionList = [
      "No tax",
      "One tax",
      "Two taxes",
      "Two taxes cumulative",

    ];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Select a tax type", style: AppTextStyles.bold(fontSize: 18.0, fontColor: AppColors.blueColor)),
              SizedBox(height: 5),
              Divider(color: AppColors.blueColor, thickness: 2),
            ],
          ),
          content: Container(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListView.separated(
                  shrinkWrap: true,
                  itemCount: optionList.length,
                  separatorBuilder: (context, index) => Divider(color: AppColors.greyColor),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: GestureDetector(
                        onTap: () {
                          onSelect(optionList[index]);
                          Navigator.pop(context);
                        },
                        child: Text(
                          optionList[index],
                          style: AppTextStyles.regular(fontSize: 16.0, fontColor: AppColors.blackColor),
                        ),
                      ),
                    );
                  },
                ),
                Divider(color: AppColors.greyColor),
                GestureDetector(
                    onTap: ()=>Get.back(),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text("Cancel"),
                    ))
              ],
            ),
          ),
        );
      },
    );
  }


}
