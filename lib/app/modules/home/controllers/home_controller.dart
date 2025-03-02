import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jumla/app/modules/home/models/anonymous_customers.dart';
import 'package:jumla/app/modules/home/models/home_models.dart';
import 'package:jumla/app/modules/home/models/reminders_list.dart';
import 'package:jumla/app/modules/home/models/saved_report_list.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final count = 0.obs;
  List<ExpandablListModel> expandableList = <ExpandablListModel>[].obs;
  List<RemindersList> reminderList = <RemindersList>[].obs;
  List<SavedReportList> savedReportList = <SavedReportList>[].obs;
  List<AnonymousCustomers> anonymusCustomersList = <AnonymousCustomers>[].obs;

  @override
  void onInit() {
    expandableList.add(ExpandablListModel(title: "Shortcuts", actions: true));
    // Expandable list
    expandableList.add(ExpandablListModel(title: "Reminders"));
    expandableList
        .add(ExpandablListModel(title: "Saved Reports", actions: true));
    expandableList
        .add(ExpandablListModel(title: "Recent Reports", actions: true));

    // Reminders list
    reminderList.add(RemindersList(
        title: "Expiring quotes", subTitle: "Next Month", count: "0"));
    reminderList.add(RemindersList(
        title: "Orders to bill", subTitle: "This week", count: "0"));
    reminderList.add(RemindersList(
        title: "Unpaid invoices", subTitle: "This month", count: "0"));
    reminderList.add(RemindersList(
        title: "Recurring Transactions", subTitle: "This week", count: "0"));

    //Saved report list
    savedReportList.add(SavedReportList(title: "Report dashboard", count: ""));
    savedReportList.add(SavedReportList(title: "Sales register", count: "0"));
    savedReportList.add(SavedReportList(title: "Payments report", count: ""));
    savedReportList.add(SavedReportList(title: "Inventory report", count: ""));
    savedReportList
        .add(SavedReportList(title: "Out of stock items", count: "0"));
    savedReportList
        .add(SavedReportList(title: "Items sold details", count: ""));
    savedReportList.add(SavedReportList(title: "Purchase register", count: ""));

    // Annonymus list
    anonymusCustomersList.add(
        AnonymousCustomers(title: "Inventory report", date: "02/03/25 20:24"));

    expandableList[0].isExpanded.value = true;
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
