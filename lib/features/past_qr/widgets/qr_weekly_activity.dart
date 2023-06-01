import 'package:flutter/material.dart';
import 'package:fox/features/past_qr/logic/past_qr_controller.dart';
import 'package:fox/shared/shared.dart';
import 'package:fox/themes/app_text.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class QrWeeklyActivity extends StatefulWidget {
  final PastQrController controller;
  QrWeeklyActivity({
    super.key,
    required this.controller,
  });

  @override
  State<QrWeeklyActivity> createState() => _QrWeeklyActivityState();
}

class _QrWeeklyActivityState extends State<QrWeeklyActivity> {
  final data = <_SalesData>[
    _SalesData('S', 35),
    _SalesData('M', 28),
    _SalesData('T', 34),
    _SalesData('W', 32),
    _SalesData('Ṭ ', 40),
    _SalesData('F', 40),
    _SalesData('s', 40),
  ];

  String weekmonth = "Weekly View";

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.topRight,
          // TODO: convert this to app dropdown
          child: DropdownButton<String>(
            value: weekmonth,
            icon: Icon(
              Icons.arrow_drop_down,
              color: AppColors.black,
            ),
            dropdownColor: AppColors.white,
            underline: const SizedBox(),
            items: ['Weekly View', 'Monthly View'].map((String items) {
              return DropdownMenuItem(
                value: items,
                child: Text(
                  items,
                  style: AppText.text10w400.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                weekmonth = newValue!;
              });
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Total Scans',
                  style: AppText.text12w400.copyWith(
                    color: AppColors.black.withOpacity(0.7),
                  ),
                ),
                Text(widget.controller.qrdetail!.qr.scanCount.toString(),
                    style: AppText.text60w600)
              ],
            ),
            sizedBoxWithWidth(24),
            SizedBox(
              height: 180.h,
              width: 220.w,
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(
                    majorGridLines: MajorGridLines(width: 0.w),
                    labelStyle: AppText.text12w600
                        .copyWith(color: AppColors.greyTextColor)),
                primaryYAxis: CategoryAxis(
                  interval: 10,
                  edgeLabelPlacement: EdgeLabelPlacement.hide,
                  axisLabelFormatter: (_) => ChartAxisLabel(
                    '',
                    AppText.text12w400,
                  ),
                ),
                plotAreaBackgroundColor: Colors.white,
                palette: [AppColors.pinkColor],
                series: <ChartSeries<_SalesData, String>>[
                  ColumnSeries<_SalesData, String>(
                    isVisible: true,
                    width: 0.3,
                    isVisibleInLegend: true,
                    dataSource: data,
                    xValueMapper: (_SalesData sales, _) => sales.year,
                    yValueMapper: (_SalesData sales, _) => sales.sales,
                  )
                ],
              ),
            ),
          ],
        ),
        sizedBoxWithWidth(32),
      ],
    );
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);
  final String year;
  final double sales;
}
