import 'package:flutter/material.dart';
import 'package:laundry_management_mobile/screens/home.dart';
import 'package:laundry_management_mobile/screens/setting.dart';
import 'package:laundry_management_mobile/screens/entry/list.dart';
import 'package:laundry_management_mobile/screens/statistic/statistic.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: _tabController, // Associer le contrôleur au TabBarView
        children: [
          HomeScreen(tabController: _tabController), // Passer le contrôleur
          const EntryScreen(),
          const StatisticScreen(),
          const SettingScreen(),
        ],
      ),
      bottomNavigationBar: TabBar(
        controller: _tabController, // Associer le contrôleur au TabBar
        tabs: const [
          Tab(icon: Icon(Icons.home), text: "Accueil"),
          Tab(icon: Icon(Icons.add_box), text: "Dépôts"),
          Tab(icon: Icon(Icons.bar_chart), text: "Statistiques"),
          Tab(icon: Icon(Icons.settings), text: "Paramètres"),
        ],
        labelColor: Colors.blue,
        unselectedLabelColor: Colors.grey,
        indicatorSize: TabBarIndicatorSize.label,
        indicatorColor: Colors.blue,
      ),
    );
  }
}
