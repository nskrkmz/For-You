import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ManagerIlkEkran extends StatefulWidget {
  @override
  _ManagerIlkEkranState createState() => _ManagerIlkEkranState();
}

class _ManagerIlkEkranState extends State<ManagerIlkEkran> {
  static const cutOffYValue = 0.0;
  static const yearTextStyle = TextStyle(fontSize: 12, color: Colors.black);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(15),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              width: 200,
              height: 350,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.purple, width: 3),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Container(
                padding: EdgeInsets.fromLTRB(0, 20, 20, 0),
                child: SizedBox(
                  width: 360,
                  height: 250,
                  child: LineChart(
                    LineChartData(
                      lineTouchData: LineTouchData(enabled: false),
                      lineBarsData: [
                        LineChartBarData(
                          spots: [
                            // (x,y) düzlemi olarak noktalar belirleniyor
                            FlSpot(0, 0),
                            FlSpot(1, 2),
                            FlSpot(2, 3),
                            FlSpot(3, 4),
                            FlSpot(4, 3),
                          ],
                          isCurved: true,
                          barWidth: 3,
                          colors: [Colors.black],
                          belowBarData: BarAreaData(
                            show: true,
                            colors: [Colors.deepOrange.withOpacity(0.9)],
                            cutOffY: cutOffYValue,
                            applyCutOffY: true,
                          ),
                          aboveBarData: BarAreaData(
                            show: true,
                            colors: [Colors.lightGreen.withOpacity(0.9)],
                            cutOffY: 0.0,
                            applyCutOffY: true,
                          ),
                          dotData: FlDotData(
                            show: false,
                          ),
                        ),
                      ],
                      minY: 0,
                      titlesData: FlTitlesData(
                        bottomTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 5,
                            getTitles: (value){
                              switch (value.toInt()){
                                case 0:
                                  return '2016';
                                  break;
                                case 1:
                                  return '2017';
                                  break;
                                case 2:
                                  return '2018';
                                  break;
                                case 3:
                                  return '2019';
                                  break;
                                case 4:
                                  return '2020';
                                  break;
                                default:
                                  return '';
                              }
                            }
                        ),
                        leftTitles: SideTitles(
                          showTitles: true,
                          getTitles: (value) {
                            return '\$${value + 100}';
                          },
                        ),
                      ),
                      axisTitleData: FlAxisTitleData(
                          leftTitle: AxisTitle(
                              showTitle: true, titleText: 'Value', margin: 10),
                          bottomTitle: AxisTitle(
                              showTitle: true, margin: 10, titleText: 'Year', textStyle: yearTextStyle, textAlign: TextAlign.center)),
                      gridData: FlGridData(
                        show: true,
                        checkToShowHorizontalLine: (double value) {
                          return value == 1 || value == 2 || value == 3 || value == 4;
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            Container(
              width: 200,
              height: 215,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.indigo, width: 3),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }


}
