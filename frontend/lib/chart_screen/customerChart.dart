import 'package:flutter/material.dart';
import 'package:frontend/chart_screen/component/pie_chart.dart';
import 'package:frontend/chart_screen/component/line_chart.dart';

class CustomerChart extends StatelessWidget {
  const CustomerChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Thống kê',
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
          onPressed: () {/*
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => NewOrderScreen()),
            );*/
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          const SizedBox(
            height: 28,
          ),
          const PieChartSample1(),
          const SizedBox(
            height: 28,
          ),
          const LineChartSample2(),
        ],
      ),
    );
  }
}