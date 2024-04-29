import 'dart:convert';
import 'dart:math';

import 'package:blood_sugar/screens/blood_sugar_graph/define.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';

class ChartDataController extends GetxController {
  final chartData = <FlSpot>[].obs;
  final isLoaded = false.obs;
  final _yData = <double>[];
  final _bloodSugarRange = RangeData(90, 140);

  @override
  void onInit() {
    super.onInit();
    isLoaded(false);
    fetchChartData('data.json');
  }

  double getMinY() {
    if (chartData.isEmpty) {
      return 0;
    }
    return _yData.reduce(min).toDouble();
  }

  double getMaxY() {
    if (chartData.isEmpty) {
      return 0;
    }
    return _yData.reduce(max).toDouble();
  }

  void fetchChartData(String path) async {
    isLoaded(false);
    var data = await loadJsonFromAssets(path);
    List<double> xData = data.map<double>((e) => e['x'].toDouble()).toList();
    List<double> yData = data.map<double>((e) => e['y'].toDouble()).toList();
    _yData.clear();
    _yData.addAll(yData);
    final flSpots = <FlSpot>[];
    for (var i = 0; i < xData.length; i++) {
      flSpots.add(FlSpot(xData[i], yData[i]));
    }
    chartData(flSpots);
    isLoaded(true);
  }

  Future<List<dynamic>> loadJsonFromAssets(String filename) async {
    final jsonString = await rootBundle.loadString('assets/$filename');
    final data = await json.decode(jsonString);
    return data;
  }

  /// linearGradient에서 stops의 정상 혈당 범위중 최소값을 나타내기 위한 지점을 반환합니다.
  double getAquaminY() {
    if (getMinY() > _bloodSugarRange.min) return 0;
    final dataRange = getMaxY() - getMinY();
    return (_bloodSugarRange.min - getMinY()) / dataRange;
  }

  /// linearGradient에서 stops의 정상 혈당 범위중 최대값을 나타내기 위한 지점을 반환합니다.
  double getAquamaxY() {
    if (getMaxY() < _bloodSugarRange.max) return 1;
    final dataRange = getMaxY() - getMinY();
    return (_bloodSugarRange.max - getMinY()) / dataRange;
  }
}
