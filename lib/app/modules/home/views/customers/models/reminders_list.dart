// To parse this JSON data, do
//
//     final remindersList = remindersListFromJson(jsonString);

import 'dart:convert';

RemindersList remindersListFromJson(String str) =>
    RemindersList.fromJson(json.decode(str));

String remindersListToJson(RemindersList data) => json.encode(data.toJson());

class RemindersList {
  String? title;
  String? subTitle;
  String? count;

  RemindersList({
    this.title,
    this.subTitle,
    this.count,
  });

  factory RemindersList.fromJson(Map<String, dynamic> json) => RemindersList(
        title: json["title"],
        subTitle: json["subTitle"],
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "subTitle": subTitle,
        "count": count,
      };
}
