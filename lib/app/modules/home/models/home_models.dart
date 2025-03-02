// To parse this JSON data, do
//
//     final expandablListModel = expandablListModelFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';

ExpandablListModel expandablListModelFromJson(String str) =>
    ExpandablListModel.fromJson(json.decode(str));

String expandablListModelToJson(ExpandablListModel data) =>
    json.encode(data.toJson());

class ExpandablListModel {
  String? title;
  bool? actions = false;
  var isExpanded = false.obs;

  ExpandablListModel({
    this.title,
    this.actions = false,
    // required this.isExpanded,
  });

  factory ExpandablListModel.fromJson(Map<String, dynamic> json) =>
      ExpandablListModel(
        title: json["title"],
        actions: json["actions"],
        // isExpandable: json["isExpandable"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "actions": actions,
        "isExpandable": isExpanded,
      };
}
