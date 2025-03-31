import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_charts/flutter_charts.dart';
import 'package:jumla/app/common/common_appbar.dart';
import 'package:jumla/app/core/app_storage.dart';
import 'package:jumla/app/modules/reports/views/saved_reports.dart';
import 'package:jumla/app/modules/reports/views/summary_reports.dart';
import 'package:jumla/app/resources/app_colors.dart';
import 'package:jumla/app/resources/app_styles.dart';

class ReportsView extends StatefulWidget {
var index ;
  ReportsView({super.key,this.index});

  @override
  State<ReportsView> createState() => _ReportsViewState();
}

class _ReportsViewState extends State<ReportsView>with TickerProviderStateMixin {
  final RxInt selectedTabIndex = 0.obs;

  late TabController _tabController = TabController(length: 3, vsync: this);

  final List<String> summaryReports = [
    "Sales By Month",
    "Sales By Quarter",
    "Sales By Year",
    "Sales By Customer",
    "Sales By Item",
    "Customer Aging",
    "Profit and Loss",
    "Sales By Users",
  ];

  final List<String> savedReports = [
    "Sales register",
    "Monthly tax report",
    "Customer profitability",
    "Items sold",
    "Payments report",
    "Inventory report",
    "Out of stock items",
    "Items sold details",
    "Purchase register",
  ];

  final chartData = ChartData(
    dataRows: [
      [0, 0, 8.92, 0, 0, 0, 0, 0, 0, 0, 0, 0] // Jan to Dec sales
    ],
    xUserLabels: [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ],
    dataRowsLegends: const ['Monthly Sales (2025)'],
    chartOptions: const ChartOptions(),
  );

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this,initialIndex: widget.index??0);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: CommonAppBarWithTitleAndIcon(title: "Reports",hideLogo: true,),
        body: Column(
          children: [
            Container(
              height: 45,
              color: AppStorages.appColor.value,
              child: TabBar(
                labelColor: AppColors.blackColor,
                controller: _tabController,
                unselectedLabelColor: Colors.white,
                labelStyle: AppTextStyles.bold(fontSize: 13.0, fontColor: AppColors.blackColor),
                unselectedLabelStyle: AppTextStyles.regular(fontSize: 13.0, fontColor: AppColors.whiteColor),
                indicator: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(4),
                ),
                isScrollable: true,

                padding: EdgeInsets.only(top: 4,bottom: 4,),
                tabs:  [
                  Tab(child: Container(padding: EdgeInsets.only(left: 20,right: 20,top: 4,bottom: 4), child: Center(child: Text("DASHBOARD")))),
                  Tab(child: Container(padding: EdgeInsets.only(left: 20,right: 20,top: 4,bottom: 4), child: Center(child: Text("SUMMARY REPORTS")))),
                  Tab(child: Container(padding: EdgeInsets.only(left: 20,right: 20,top: 4,bottom: 4), child: Center(child: Text("SAVED REPORTS")))),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _dashboardTab(),
                  _summaryReportsTab(),
                  _savedReportsTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dashboardTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('2025', style: TextStyle(fontSize: 18)),
              const SizedBox(width: 10),
              TextButton(onPressed: () {}, child: const Text('Refresh')),
            ],
          ),
          _summaryRow('Total sales', '8.92'),
          _summaryRow('Average sale value', '0.89'),
          _summaryRow('Average day total', '0.02'),
          _summaryRow('Largest sale value', '8.92'),
          _summaryRow('Number of sales', '10'),
          const SizedBox(height: 10),
          SizedBox(
            height: 180,
            child: VerticalBarChart(
              painter: VerticalBarChartPainter(

                verticalBarChartContainer: VerticalBarChartTopContainer(chartData: chartData),
              ),
              size: Size(Get.width, Get.height/2),
            ),
          ),
          const SizedBox(height: 16),
          _quarterSection('1st Quarter', {'JAN': 0, 'FEB': 0, 'MAR': 8.92}),
          _quarterSection('2nd Quarter', {'APR': 0, 'MAY': 0, 'JUN': 0}),
          _quarterSection('3rd Quarter', {'JUL': 0, 'AUG': 0, 'SEP': 0}),
          _quarterSection('4th Quarter', {'OCT': 0, 'NOV': 0, 'DEC': 0}),
          const SizedBox(height: 16),
          _highlightSection('TOP CUSTOMERS', {'Anonymous Customer': '8.92'}),
          const SizedBox(height: 10),
          _highlightSection('TOP REVENUE PRODUCTS', {'Cable - IDE': '8.93'}),
        ],
      ),

    );
  }

  Widget chartToRun() {
    LabelLayoutStrategy? xContainerLabelLayoutStrategy;
    ChartData chartData;
    ChartOptions chartOptions = const ChartOptions();
    // Example shows an explicit use of the DefaultIterativeLabelLayoutStrategy.
    // The xContainerLabelLayoutStrategy, if set to null or not set at all,
    //   defaults to DefaultIterativeLabelLayoutStrategy
    // Clients can also create their own LayoutStrategy.
    xContainerLabelLayoutStrategy = DefaultIterativeLabelLayoutStrategy(
      options: chartOptions,
    );
    chartData = ChartData(
      dataRows: const [
        [10.0, 20.0, 5.0, 30.0, 5.0, 20.0],
        [30.0, 60.0, 16.0, 100.0, 12.0, 120.0],
        [25.0, 40.0, 20.0, 80.0, 12.0, 90.0],
        [12.0, 30.0, 18.0, 40.0, 10.0, 30.0],
      ],
      xUserLabels: const ['Wolf', 'Deer', 'Owl', 'Mouse', 'Hawk', 'Vole'],
      dataRowsLegends: const [
        'Spring',
        'Summer',
        'Fall',
        'Winter',
      ],
      chartOptions: chartOptions,
    );
    // chartData.dataRowsDefaultColors(); // if not set, called in constructor
    var verticalBarChartContainer = VerticalBarChartTopContainer(
      chartData: chartData,
      xContainerLabelLayoutStrategy: xContainerLabelLayoutStrategy,
    );

    var verticalBarChart = VerticalBarChart(
      painter: VerticalBarChartPainter(
        verticalBarChartContainer: verticalBarChartContainer,
      ),
      size: Size(Get.width, Get.height/2),
    );
    return verticalBarChart;
  }

  Widget _summaryReportsTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: summaryReports.length,
      itemBuilder: (context, index) {
        return Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: ListTile(
            tileColor: AppStorages.appColor.value.withOpacity(0.1),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text(summaryReports[index]),
            onTap: ()=>Get.to(()=>SummaryReport()),
          ),
        );
      },
    );
  }

  Widget _savedReportsTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: savedReports.length,
      itemBuilder: (context, index) {
        return Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: ListTile(
            tileColor: AppStorages.appColor.value.withOpacity(0.1),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text(savedReports[index]),
            textColor: index < 6 ? Colors.blue : null,
            trailing: index == 6 ? const Text("0", style: TextStyle(color: Colors.green)) : null,
            onTap: ()=>Get.to(()=>SavedReports()),
          ),
        );
      },
    );
  }

  Widget _summaryRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _quarterSection(String title, Map<String, double> data) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),

      child: Container(

        decoration: BoxDecoration(
          color: AppStorages.appColor.value.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10)
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
              ...data.entries.map((e) => _summaryRow(e.key, e.value.toStringAsFixed(2))).toList(),
              _summaryRow('', data.values.reduce((a, b) => a + b).toStringAsFixed(2))
            ],
          ),
        ),
      ),
    );
  }

  Widget _highlightSection(String title, Map<String, String> entries) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyles.semiBold(fontSize: 14.0, fontColor: AppStorages.appColor.value)),
        const SizedBox(height: 6),
        ...entries.entries.map(
              (e) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(e.key,style: AppTextStyles.regular(fontSize: 14.0, fontColor: AppColors.blackColor),), Text(e.value,style:  AppTextStyles.bold(fontSize: 16.0, fontColor: AppColors.blackColor),)],
          ),
        ),
      ],
    );
  }
}

