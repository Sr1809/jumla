import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // For date formatting in the custom date picker
import 'package:jumla/app/common/common_appbar.dart';
import 'package:jumla/app/common/common_button.dart';
import 'package:jumla/app/core/app_storage.dart';
import 'package:jumla/app/resources/app_colors.dart';

/// A model class for sort criteria (field + direction).
class SortCriteria {
  RxString field;      // e.g. "Date", "Amount", etc.
  RxString direction;  // "Ascending" or "Descending"

  SortCriteria({required String field, required String direction})
      : field = field.obs,
        direction = direction.obs;
}

class FilterSortScreen extends StatelessWidget {
  FilterSortScreen({Key? key}) : super(key: key);

  /// Tabs
  final RxInt selectedTab = 0.obs;
  final List<String> tabTitles = ["FILTERS", "RESULTS", "COLUMNS"];

  /// FILTERS
  final RxString selectedDateRange = 'Last 2 months'.obs;
  final RxString selectedDueDateRange = ''.obs;      // For "Due Date"
  final RxString selectedStatus = ''.obs;
  final RxString selectedCustomer = ''.obs;
  final RxString selectedUser = ''.obs;
  final RxString selectedSaleType = 'Cash Sale'.obs;
  final RxString selectedIsProcessed = ''.obs;       // For "Is Processed"

  /// RESULTS (Sort criteria)
  final RxList<SortCriteria> sortCriteria = <SortCriteria>[
    // Example default sort rows
    SortCriteria(field: "Date", direction: "Descending"),
    SortCriteria(field: "Not set", direction: "Ascending"),
  ].obs;

  /// COLUMNS
  // Tracks which columns are selected
  final RxList<String> selectedColumns = [
    "Date",
    "Sale",
    "Customer",
    "Status",
    "Amount",
    "Paid",
    "Balance",
  ].obs;

  // Master list controlling the visible order of columns
  final RxList<String> allColumns = [
    "Date",
    "Sale",
    "Customer",
    "Status",
    "Amount",
    "Paid",
    "Balance",
    "Due Date",
    "Customer ID",
    "Project",
    "Created From",
    "Discount",
    "Memo",
    "Term Days",
    "Bill Address",
    "Is Processed",
    "Tax Amount",
    "Tax 2 Amount",
    "Yuy",
  ].obs;

  final RxBool selectAllColumns = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBarWithTitleAndIcon(title: "Filter & Sort", hideLogo: true),
      body: Column(
        children: [
          // Tab bar
          Obx(
                () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                tabTitles.length,
                    (index) => GestureDetector(
                  onTap: () => selectedTab.value = index,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: selectedTab.value == index
                              ? AppStorages.appColor.value
                              : Colors.transparent,
                          width: 3,
                        ),
                      ),
                    ),
                    child: Text(
                      tabTitles[index],
                      style: TextStyle(
                        color: selectedTab.value == index
                            ? AppStorages.appColor.value
                            : Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Tab content
          Expanded(
            child: Obx(() {
              switch (selectedTab.value) {
                case 0:
                  return _buildFilters(context);
                case 1:
                  return _buildResults(context);
                case 2:
                  return _buildColumns();
                default:
                  return Container();
              }
            }),
          ),

          // Bottom action buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CommonElevatedButton(text: "Apply",onPressed:  () {
              Get.back();
              }),
              CommonElevatedButton(text:"Clear all",onPressed: () {
                // Clear all filters
                selectedDateRange.value = '';
                selectedDueDateRange.value = '';
                selectedStatus.value = '';
                selectedCustomer.value = '';
                selectedUser.value = '';
                selectedSaleType.value = '';
                selectedIsProcessed.value = '';
                // Clear columns
                selectedColumns.clear();
                selectAllColumns.value = false;
                // Clear sort criteria
                sortCriteria.clear();
              }),
              CommonElevatedButton(text:"Cancel",onPressed: () {
                Navigator.of(context).pop();
              }),
            ],
          ),
        ],
      ),
    );
  }

  /// FILTERS TAB
  Widget _buildFilters(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _filterRow(
          "Type",
          selectedSaleType.value,
              () => _showSaleTypePopup(context),
        ),
        _filterRow(
          "Date",
          selectedDateRange.value,
              () => _showDateRangePopup(context, selectedDateRange),
        ),
        _filterRow(
          "Due Date",
          selectedDueDateRange.value,
              () => _showDateRangePopup(context, selectedDueDateRange),
        ),
        _filterRow(
          "Status",
          selectedStatus.value,
              () => _showStatusPopup(context),
        ),
        _filterRow(
          "Customer",
          selectedCustomer.value,
              () => _showCustomerPopup(context),
        ),
        // "Is Processed" has "Not set", "Yes", "No"
        _filterRow(
          "Is Processed",
          selectedIsProcessed.value,
              () => _showIsProcessedPopup(context),
        ),
        _filterRow(
          "User",
          selectedUser.value,
              () => _showUserPopup(context),
        ),
      ],
    );
  }

  /// RESULTS TAB
  Widget _buildResults(BuildContext context) {
    return Obx(
          () => ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Each row of sort criteria
          ...sortCriteria.map((criteria) {
            final index = sortCriteria.indexOf(criteria);
            return Row(
              children: [
                const Text("Sort by"),
                const SizedBox(width: 8),
                // Choose sort field from allColumns
                ElevatedButton(
                  onPressed: () {
                    // Reuse the same popup logic but pass in 'criteria.field'
                    Get.bottomSheet(
                      _popupTemplate(
                        "Select a sort field",
                        allColumns.toList(),
                        criteria.field,
                      ),
                      isScrollControlled: true,
                    );
                  },
                  child: Obx(() => Text(criteria.field.value)),
                ),
                const SizedBox(width: 8),
                // Toggle Asc/Desc
                ElevatedButton(
                  onPressed: () {
                    if (criteria.direction.value == "Ascending") {
                      criteria.direction.value = "Descending";
                    } else {
                      criteria.direction.value = "Ascending";
                    }
                  },
                  child: Obx(() => Text(criteria.direction.value)),
                ),
                const SizedBox(width: 8),
                // Up arrow to move this row up
              ],
            );
          }).toList(),

          const SizedBox(height: 16),
          // Max Results
          const Text("Max Results"),
          const TextField(),

        ],
      ),
    );
  }

  /// COLUMNS TAB
  Widget _buildColumns() {
    return Obx(
          () => ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Select All
          Row(
            children: [
              Checkbox(
                value: selectAllColumns.value,
                onChanged: (value) {
                  selectAllColumns.value = value ?? false;
                  if (selectAllColumns.value) {
                    selectedColumns.assignAll(allColumns);
                  } else {
                    selectedColumns.clear();
                  }
                },
              ),
              const Text("All"),
            ],
          ),
          // Show columns in order
          ...allColumns.map((field) {
            final bool isSelected = selectedColumns.contains(field);
            final int indexInAll = allColumns.indexOf(field);
            return Row(
              children: [
                // Checkbox for selecting/deselecting
                Checkbox(
                  value: isSelected,
                  onChanged: (checked) {
                    if (checked == true) {
                      selectedColumns.add(field);
                    } else {
                      selectedColumns.remove(field);
                    }
                    if (selectedColumns.length != allColumns.length) {
                      selectAllColumns.value = false;
                    }
                  },
                ),
                Expanded(child: Text(field)),
                // Up button
                ElevatedButton(
                  onPressed: indexInAll > 0
                      ? () {
                    final aboveItem = allColumns[indexInAll - 1];
                    allColumns[indexInAll - 1] = allColumns[indexInAll];
                    allColumns[indexInAll] = aboveItem;
                  }
                      : null,
                  child: const Text("Up"),
                ),
                const SizedBox(width: 8),
                // Down button
                ElevatedButton(
                  onPressed: indexInAll < allColumns.length - 1
                      ? () {
                    final belowItem = allColumns[indexInAll + 1];
                    allColumns[indexInAll + 1] = allColumns[indexInAll];
                    allColumns[indexInAll] = belowItem;
                  }
                      : null,
                  child: const Text("Down"),
                ),
              ],
            );
          }).toList(),
        ],
      ),
    );
  }

  /// A row in the Filters tab
  Widget _filterRow(String label, String currentValue, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          SizedBox(width: 100, child: Text(label)),
          ElevatedButton(
            onPressed: onTap,
            child: const Text("Change"),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              currentValue.isEmpty ? "Not set" : currentValue,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  /// Common action button
  Widget _actionButton(String label, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        backgroundColor: Colors.grey[300],
      ),
      child: Text(label),
    );
  }

  //////////////////////////////////////////////////////////////////////////////
  //                             POPUP METHODS                                 //
  //////////////////////////////////////////////////////////////////////////////

  /// Shows a large list of date ranges (from your screenshot) in a bottom sheet.
  /// Also includes a "Custom date" picker at the bottom.
  void _showDateRangePopup(BuildContext context, RxString targetValue) {
    // Full date range list as seen in your screenshot
    final dateRanges = [
      "Today",
      "Yesterday",
      "Tomorrow",
      "This week",
      "Next week",
      "This month",
      "Next month",
      "This year",
      "Next year",
      "Next 3 weeks",
      "Next 2 months",
      "Next 3 months",
      "Next 6 months",
      "Next 12 months",
      "Last 1 week",
      "Last 2 weeks",
      "Last 3 weeks",
      "Last 4 weeks",
      "2 weeks ago",
      "3 weeks ago",
      "Last 2 months",
      "Last 3 months",
      "1 month ago",
      "2 months ago",
      "3 months ago",
      "4 months ago",
      "5 months ago",
      "6 months ago",
      "7 months ago",
      "8 months ago",
      "9 months ago",
      "10 months ago",
      "11 months ago",
      "1 year ago",
      "Year to date",
      "Last year",
    ];

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        height: Get.height * 0.8,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
        ),
        child: Column(
          children: [
            const Text(
              "Select a date range",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.cyan,
              ),
            ),
            const Divider(),
            // Scrollable list of checkboxes (single select)
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: dateRanges.map((item) {
                    return Obx(
                          () => CheckboxListTile(
                        title: Text(item),
                        value: targetValue.value == item,
                        onChanged: (v) {
                          if (v == true) {
                            targetValue.value = item;
                          } else {
                            if (targetValue.value == item) {
                              targetValue.value = '';
                            }
                          }
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            const Divider(),
            // Bottom row: Done, Done & apply, Custom date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => Get.back(),
                  child: const Text("Done"),
                ),
                TextButton(
                  onPressed: () {
                    // If you want to apply the filter right away, do it here
                    Get.back();
                  },
                  child: const Text("Done & apply"),
                ),
                TextButton(
                  onPressed: () async {
                    // Show a built-in date range picker
                    final picked = await showDateRangePicker(
                      context: context,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (picked != null) {
                      final start = DateFormat('yyyy-MM-dd').format(picked.start);
                      final end = DateFormat('yyyy-MM-dd').format(picked.end);
                      targetValue.value = "Custom: $start - $end";
                    }
                    Get.back();
                  },
                  child: const Text("Custom date"),
                ),
              ],
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  /// Popup for selecting "Status"
  void _showStatusPopup(BuildContext context) {
    final statuses = [
      "Cash Sale: Fully Paid",
      "Invoice: Pending Payment",
      "Quote: Closed Lost",
      // Add more if needed
    ];
    Get.bottomSheet(
      _popupTemplate("Select a status", statuses, selectedStatus),
      isScrollControlled: true,
    );
  }

  /// Popup for selecting "Customer"
  void _showCustomerPopup(BuildContext context) {
    final customers = [
      "Anonymous Customer",
      "ABC Customer",
      "XYZ Customer",
    ];
    Get.bottomSheet(
      _popupTemplate("Select a customer", customers, selectedCustomer),
      isScrollControlled: true,
    );
  }

  /// Popup for "Is Processed" with "Not set", "Yes", and "No"
  void _showIsProcessedPopup(BuildContext context) {
    final options = [
      "Not set",
      "Yes",
      "No",
    ];
    Get.bottomSheet(
      _popupTemplate("Is Processed", options, selectedIsProcessed),
      isScrollControlled: true,
    );
  }

  /// Popup for selecting "User"
  void _showUserPopup(BuildContext context) {
    final users = [
      "Test Test",
      "Admin",
      "Guest",
    ];
    Get.bottomSheet(
      _popupTemplate("Select a user", users, selectedUser),
      isScrollControlled: true,
    );
  }

  /// Popup for selecting "Sale Type"
  void _showSaleTypePopup(BuildContext context) {
    final saleTypes = [
      "Quote",
      "Invoice",
      "Sales Order",
      "Cash Sale",
    ];
    Get.bottomSheet(
      _popupTemplate("Select a sale type", saleTypes, selectedSaleType),
      isScrollControlled: true,
    );
  }

  /// A generic single-select bottom sheet popup, reused for status, user, etc.
  Widget _popupTemplate(
      String title,
      List<String> options,
      RxString selectedValue,
      ) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: Get.height * 0.5,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.cyan,
            ),
          ),
          const Divider(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: options.map((item) {
                  return Obx(
                        () => CheckboxListTile(
                      title: Text(item),
                      value: selectedValue.value == item,
                      onChanged: (v) {
                        if (v == true) {
                          selectedValue.value = item;
                        } else {
                          if (selectedValue.value == item) {
                            selectedValue.value = '';
                          }
                        }
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () => Get.back(),
                child: const Text("Done"),
              ),
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text("Done & apply"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
