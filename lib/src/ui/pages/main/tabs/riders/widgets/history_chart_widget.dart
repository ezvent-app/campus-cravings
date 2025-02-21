import 'package:campus_cravings/src/src.dart';
import 'package:fl_chart/fl_chart.dart';

class HistoryChartWidget extends StatelessWidget {
  const HistoryChartWidget({super.key, required this.size});

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.dividerColor),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(-1, 1),
            color: AppColors.dividerColor,
            blurRadius: 1,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(13),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total Revenue",
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium!.copyWith(color: AppColors.black),
                    ),
                    Text(
                      "\$20",
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: size.width * .29,
                  height: size.height * .06,
                  child: DropdownButtonFormField<String>(
                    padding: EdgeInsets.zero,
                    icon: Icon(Icons.keyboard_arrow_down, size: 20),
                    value: 'Daily',
                    style: Theme.of(context).textTheme.bodyMedium!,
                    items:
                        ['Daily', 'Weekly', 'Monthly']
                            .map(
                              (String value) => DropdownMenuItem(
                                value: value,
                                child: Text(
                                  value,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ),
                            )
                            .toList(),
                    onChanged: (value) {},
                  ),
                ),
              ],
            ),
            height(16),
            // Chart
            SizedBox(
              height: 150,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          switch (value.toInt()) {
                            case 0:
                              return Padding(
                                padding: const EdgeInsets.only(
                                  top: 15,
                                  left: 20,
                                  right: 10,
                                ),
                                child: Text(
                                  "10AM",
                                  style: Theme.of(context).textTheme.bodySmall!
                                      .copyWith(color: AppColors.email),
                                ),
                              );
                            case 2:
                              return Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: Text(
                                  "11AM",
                                  style: Theme.of(context).textTheme.bodySmall!
                                      .copyWith(color: AppColors.email),
                                ),
                              );
                            case 4:
                              return Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: Text(
                                  "12PM",
                                  style: Theme.of(context).textTheme.bodySmall!
                                      .copyWith(color: AppColors.email),
                                ),
                              );
                            case 6:
                              return Padding(
                                padding: const EdgeInsets.only(
                                  top: 15,
                                  right: 10,
                                ),
                                child: Text(
                                  "01PM",
                                  style: Theme.of(context).textTheme.bodySmall!
                                      .copyWith(color: AppColors.email),
                                ),
                              );
                            case 8:
                              return Padding(
                                padding: const EdgeInsets.only(
                                  top: 15,
                                  right: 10,
                                ),
                                child: Text(
                                  "02PM",
                                  style: Theme.of(context).textTheme.bodySmall!
                                      .copyWith(color: AppColors.email),
                                ),
                              );
                            case 10:
                              return Padding(
                                padding: const EdgeInsets.only(
                                  top: 15,
                                  right: 10,
                                ),
                                child: Text(
                                  "03PM",
                                  style: Theme.of(context).textTheme.bodySmall!
                                      .copyWith(color: AppColors.email),
                                ),
                              );
                            case 12:
                              return Padding(
                                padding: const EdgeInsets.only(
                                  top: 15,
                                  right: 20,
                                  left: 10,
                                ),
                                child: Text(
                                  "04PM",
                                  style: Theme.of(context).textTheme.bodySmall!
                                      .copyWith(color: AppColors.email),
                                ),
                              );
                          }
                          return Container();
                        },
                        reservedSize: 30,
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: [
                        FlSpot(0, 3),
                        FlSpot(2, 5),
                        FlSpot(4, 2),
                        FlSpot(6, 7),
                        FlSpot(8, 6),
                        FlSpot(10, 8),
                        FlSpot(12, 6),
                      ],
                      isCurved: true,
                      color: Colors.blue,
                      barWidth: 2.5,
                      isStrokeCapRound: true,
                      belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                          colors: [
                            Colors.blue.withValues(alpha: 0.4),
                            Colors.blue.withValues(alpha: 0.1),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, barData, index) {
                          return FlDotCirclePainter(
                            radius: 4,
                            color: Colors.white,
                            strokeWidth: 2,
                            strokeColor: Colors.blue,
                          );
                        },
                      ),
                    ),
                  ],
                  lineTouchData: LineTouchData(
                    touchTooltipData: LineTouchTooltipData(
                      getTooltipItems: (List<LineBarSpot> touchedSpots) {
                        return touchedSpots.map((touchedSpot) {
                          return LineTooltipItem(
                            "\$${touchedSpot.y.toInt()}",
                            Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: AppColors.white,
                            ),
                          );
                        }).toList();
                      },
                    ),
                    touchCallback:
                        (
                          FlTouchEvent event,
                          LineTouchResponse? touchResponse,
                        ) {},
                    handleBuiltInTouches: true,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
