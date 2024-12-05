import 'package:flutter/material.dart';
import 'package:frontend/chart_screen/component/line_chart.dart';
import 'package:frontend/chart_screen/component/pie_chart.dart';

class ManagerChart extends StatelessWidget {
  const ManagerChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Quản lí',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: "Popins",
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Biểu đồ đường
            Expanded(
              flex: 2, // Chiếm 2 phần của chiều cao màn hình
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: LineChartSample2(), // Line chart component
                ),
              ),
            ),
            const SizedBox(height: 8.0), // Khoảng cách giữa hai biểu đồ
            // Biểu đồ tròn
            Expanded(
              flex: 1, // Chiếm 1 phần của chiều cao màn hình
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PieChartSample1(), // Pie chart component
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
