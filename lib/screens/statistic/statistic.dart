import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry_management_mobile/constants/constant.dart';
import 'package:laundry_management_mobile/models/expense_data.dart';
import 'package:laundry_management_mobile/controllers/api_controller.dart';
import 'package:laundry_management_mobile/screens/statistic/bar_chart.dart';
import 'package:laundry_management_mobile/screens/statistic/expense_income.dart';

class StatisticScreen extends StatefulWidget {
  const StatisticScreen({super.key});

  @override
  State<StatisticScreen> createState() => _StatisticScreenState();
}

class _StatisticScreenState extends State<StatisticScreen> {
  late ApiController apiController;

  bool isLoading = false;
  String? selectedValue =  DateTime.now().year.toString();
  ExpensesData expensesData = ExpensesData(
      totalEntries: 0, totalKilos: 0, weeklyTotals: [], yearlyTotals: []);

  final List<String> itemList = List<String>.generate(8, (index) {
    return (DateTime.now().year - index).toString();
  });

  @override
  void initState() {
    super.initState();
    apiController = ApiController();
    fetchExpenseData(selectedValue);
  }

  //
  void fetchExpenseData(year) {
    setState(() => isLoading = true);
    apiController.fetchData('statistic/entries/metrics/$year').then((data) {
      setState(() {
        isLoading = false;
        expensesData = ExpensesData.fromJson(data);
      });
    }).catchError((error) {
      setState(() => isLoading = false);
      debugPrint(
          "Erreur lors de la récupération des données : ${error.toString()}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10.h),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              'Statistics',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold),
            ),
            DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedValue,
                dropdownColor: Colors.white,
                items:
                    itemList.map<DropdownMenuItem<String>>((value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedValue = newValue;
                  });
                  fetchExpenseData(newValue);
                },
              ),
            ),
          ]),
          SizedBox(height: 10.h),
          ExpenseIncomeData(
              totalEntries: expensesData.totalEntries,
              totalKilos: expensesData.totalKilos),
          SizedBox(height: 10.h),
          BarChartSample(
            title: 'Entrée hebdomadaire',
            isLoading: isLoading,
            data: expensesData.weeklyTotals,
            period: Constants.days,
          ),
          BarChartSample(
            title: 'Entrée annuelle',
            isLoading: isLoading,
            data: expensesData.yearlyTotals,
            period: Constants.months,
          ),
        ],
      ),
    )));
  }
}
