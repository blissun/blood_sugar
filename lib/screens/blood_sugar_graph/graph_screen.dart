import 'package:blood_sugar/screens/blood_sugar_graph/controller.dart';
import 'package:blood_sugar/screens/blood_sugar_graph/define.dart';
import 'package:blood_sugar/theme/colors/colors.dart';
import 'package:blood_sugar/theme/font/style.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GraphScreen extends StatefulWidget {
  const GraphScreen({super.key});

  @override
  State<GraphScreen> createState() => _GraphScreenState();
}

class _GraphScreenState extends State<GraphScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Blood Sugar Graph'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: AspectRatio(
              aspectRatio: 1,
              child: Obx(() {
                final controller = Get.put(ChartDataController());

                if (!controller.isLoaded.value) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return LineChart(
                  LineChartData(
                    maxX: 2000,
                    minY: 0,
                    maxY: GraphConstant.maxY + 50,
                    lineBarsData: [
                      LineChartBarData(
                        spots: controller.chartData,
                        barWidth: 4,
                        isCurved: true,
                        dotData: const FlDotData(
                          show: false,
                        ),
                        gradient: lineGraphGradient(controller),
                      ),
                    ],
                    borderData: FlBorderData(
                      show: false,
                    ),
                    titlesData: FlTitlesData(
                      show: true,
                      bottomTitles: const AxisTitles(),
                      topTitles: const AxisTitles(),
                      leftTitles: const AxisTitles(),
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: GraphConstant.rightTitleTextWidth,
                          interval: GraphConstant.horizontalInterval,
                          getTitlesWidget: _titlesWidget,
                        ),
                      ),
                    ),
                    gridData: _gridData(GraphConstant.horizontalInterval),
                    rangeAnnotations: _rangeAnnotations(),
                  ),
                );
              }),
            ),
          )
        ],
      ),
    );
  }

  LinearGradient lineGraphGradient(ChartDataController controller) {
    return LinearGradient(
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
      colors: const [
        GraphColors.red,
        GraphColors.red,
        GraphColors.aqua,
        GraphColors.aqua,
        GraphColors.yellow,
        GraphColors.yellow,
      ],
      stops: [
        0,
        controller.getAquaminY() * 0.9,
        (controller.getAquaminY() + 0.1).clamp(
          0,
          controller.getAquamaxY(),
        ),
        controller.getAquamaxY() * 0.9,
        controller.getAquamaxY() * 1.1,
        1,
      ],
    );
  }

  Widget _titlesWidget(value, meta) {
    if (value.toInt() == 0 || value.toInt() > GraphConstant.maxY) {
      return const SizedBox();
    }
    return Text(
      value.toInt().toString(),
      textAlign: TextAlign.right,
      style: GraphTheme.detail2,
    );
  }

  RangeAnnotations _rangeAnnotations() {
    return RangeAnnotations(
      horizontalRangeAnnotations: [
        HorizontalRangeAnnotation(
          y1: GraphConstant.minBloodSugarY,
          y2: GraphConstant.maxBloodSugarY,
          color: GraphColors.bandColor,
        ),
      ],
    );
  }

  FlGridData _gridData(double horizontalInterval) {
    return FlGridData(
      show: true,
      drawVerticalLine: false,
      horizontalInterval: horizontalInterval,
      getDrawingHorizontalLine: (value) {
        return const FlLine(
          color: GraphColors.horizontalGridColor,
          strokeWidth: 2,
        );
      },
    );
  }
}
