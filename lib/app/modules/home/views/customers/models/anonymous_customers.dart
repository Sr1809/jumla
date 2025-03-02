// To parse this JSON data, do
//
//     final anonymousCustomers = anonymousCustomersFromJson(jsonString);

import 'dart:convert';

AnonymousCustomers anonymousCustomersFromJson(String str) =>
    AnonymousCustomers.fromJson(json.decode(str));

String anonymousCustomersToJson(AnonymousCustomers data) =>
    json.encode(data.toJson());

class AnonymousCustomers {
  String? title;
  String? date;

  AnonymousCustomers({
    this.title,
    this.date,
  });

  factory AnonymousCustomers.fromJson(Map<String, dynamic> json) =>
      AnonymousCustomers(
        title: json["title"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "date": date,
      };
}
