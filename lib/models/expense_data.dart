
class ExpensesData {
  double totalEntries;
  double totalKilos;
  final List<double> weeklyTotals;
  final List<double> yearlyTotals;

  ExpensesData({required this.totalEntries, required this.totalKilos, required this.weeklyTotals, required this.yearlyTotals});

  factory ExpensesData.fromJson(Map<String, dynamic> json) {
    return ExpensesData(
      totalEntries: json['total_entries'],
      totalKilos: json['total_kilos'],
      weeklyTotals: List<double>.from(json['total_kilos'].map((item) => item.toDouble())),
      yearlyTotals: List<double>.from(json['yearly_totals'].map((item) => item.toDouble())),
    );
  }
}