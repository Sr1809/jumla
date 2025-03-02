// To parse this JSON data, do
//
//     final savedReportList = savedReportListFromJson(jsonString);

import 'dart:convert';

SavedReportList savedReportListFromJson(String str) =>
    SavedReportList.fromJson(json.decode(str));

String savedReportListToJson(SavedReportList data) =>
    json.encode(data.toJson());

class SavedReportList {
  String? title;
  String? count;

  SavedReportList({
    this.title,
    this.count,
  });

  factory SavedReportList.fromJson(Map<String, dynamic> json) =>
      SavedReportList(
        title: json["title"],
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "count": count,
      };
}
