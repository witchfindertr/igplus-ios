import 'dart:math';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:igplus_ios/domain/entities/report.dart';
import 'package:igplus_ios/presentation/resources/colors_manager.dart';
import 'package:igplus_ios/presentation/views/global/section_title.dart';
import 'package:mrx_charts/mrx_charts.dart';
import 'package:intl/intl.dart';

class LineChartSample extends StatefulWidget {
  const LineChartSample({Key? key, required this.chartData}) : super(key: key);
  final List<ChartData> chartData;

  @override
  State<LineChartSample> createState() => _LineChartSampleState();
}

class _LineChartSampleState extends State<LineChartSample> {
  @override
  Widget build(BuildContext context) {
    try {
      return Column(
        children: [
          const SectionTitle(title: "Followers tracking", icon: FontAwesomeIcons.chartLine),
          Container(
            constraints: const BoxConstraints(
              maxHeight: 180.0,
            ),
            padding: const EdgeInsets.all(24.0),
            child: Chart(
              layers: layers(widget.chartData),
              padding: const EdgeInsets.symmetric(horizontal: 30.0).copyWith(
                bottom: 12.0,
              ),
            ),
          ),
        ],
      );
    } catch (e) {
      return Container();
    }
  }

  List<ChartLayer> layers(List<ChartData> chartData) {
    // date now
    final now = DateTime.now();
    final from = now.subtract(const Duration(days: 5));
    final to = now;
    final frequency = (to.millisecondsSinceEpoch - from.millisecondsSinceEpoch) / 5.0;
    List<double> chartValues = chartValuesFromData(chartData);
    return [
      ChartHighlightLayer(
        shape: () => ChartHighlightLineShape<ChartLineDataItem>(
          backgroundColor: Colors.transparent,
          currentPos: (item) => item.currentValuePos,
          radius: const BorderRadius.all(Radius.circular(8.0)),
          width: 60.0,
        ),
      ),
      ChartAxisLayer(
        settings: ChartAxisSettings(
          x: ChartAxisSettingsAxis(
            frequency: frequency,
            max: to.millisecondsSinceEpoch.toDouble(),
            min: from.millisecondsSinceEpoch.toDouble(),
            textStyle: TextStyle(
              color: Colors.white.withOpacity(0.6),
              fontSize: 10.0,
            ),
          ),
          y: ChartAxisSettingsAxis(
            frequency: (chartValues[5] - chartValues[0]) / 5.0,
            max: chartValues[5],
            min: chartValues[0],
            textStyle: TextStyle(
              color: Colors.white.withOpacity(0.6),
              fontSize: 10.0,
            ),
          ),
        ),
        labelX: (value) => DateFormat('M/d/yy').format(DateTime.fromMillisecondsSinceEpoch(value.toInt())),
        labelY: (value) => value.toInt().toString(),
      ),
      ChartLineLayer(
        items: [
          ChartLineDataItem(
            x: (0 * frequency) + from.millisecondsSinceEpoch,
            value: chartValues[0],
          ),
          ChartLineDataItem(
            x: (1 * frequency) + from.millisecondsSinceEpoch,
            value: chartValues[1],
          ),
          ChartLineDataItem(
            x: (2 * frequency) + from.millisecondsSinceEpoch,
            value: chartValues[2],
          ),
          ChartLineDataItem(
            x: (3 * frequency) + from.millisecondsSinceEpoch,
            value: chartValues[3],
          ),
          ChartLineDataItem(
            x: (4 * frequency) + from.millisecondsSinceEpoch,
            value: chartValues[4],
          ),
          ChartLineDataItem(
            x: (5 * frequency) + from.millisecondsSinceEpoch,
            value: chartValues[5],
          )
        ],
        settings: const ChartLineSettings(
          color: ColorsManager.primaryColor,
          thickness: 4.0,
        ),
      ),
      ChartTooltipLayer(
        shape: () => ChartTooltipLineShape<ChartLineDataItem>(
          backgroundColor: Colors.white,
          circleBackgroundColor: Colors.white,
          circleBorderColor: const Color(0xFF331B6D),
          circleSize: 4.0,
          circleBorderThickness: 2.0,
          currentPos: (item) => item.currentValuePos,
          onTextValue: (item) => '${item.value.toString()}',
          marginBottom: 6.0,
          padding: const EdgeInsets.symmetric(
            horizontal: 4.0,
            vertical: 4.0,
          ),
          radius: 6.0,
          textStyle: const TextStyle(
            color: ColorsManager.primaryColor,
            letterSpacing: 0.2,
            fontSize: 14.0,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    ];
  }
}

List<double> chartValuesFromData(List<ChartData> chartData) {
  List<double> values = [];
  int totalValues = 6;
  num lastValue = chartData.last.value;

  for (var i = 0; i < totalValues; i++) {
    String day = DateFormat('M/d/yy').format(DateTime.now().subtract(Duration(days: i)));
    bool saved = false;
    for (var data in chartData) {
      if (data.date == day) {
        values.add(double.parse(data.value.toString()));
        saved = true;
        lastValue = data.value;
      }
    }
    if (saved == false) {
      for (var data in chartData.reversed) {
        if (values.length > 0 && data.value <= values.last && data.value != lastValue) {
          values.add(double.parse(data.value.toString()));
          break;
        }
      }
      // values.add(0);
    }
  }
  if (values.length < totalValues) {
    for (var i = values.length; i < totalValues; i++) {
      values.add(0);
    }
  }

  return values.reversed.toList();
}
