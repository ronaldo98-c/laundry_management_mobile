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

class _RootState extends State<Root> {
  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 4, // Nombre d'onglets
      initialIndex:
          0, // Index initial pour sélectionner le premier onglet (CarPage)
      child: Scaffold(
        body: TabBarView(
          children: [
            HomeScreen(), // Page pour l'onglet Voiture (affichée par défaut)
            EntryScreen(), // Page pour l'onglet Transit
            StatisticScreen(), //
            SettingScreen(), // Page pour l'onglet Vélo
          ],
        ),
        bottomNavigationBar: TabBar(
          tabs: [
            Tab(icon: Icon(Icons.home), text: "Accueil" ),
            Tab(icon: Icon(Icons.add_box), text: "Dépôts"),
            Tab(icon: Icon(Icons.bar_chart), text: "Statistiques"),
            Tab(icon: Icon(Icons.settings), text: "Paramètres")
          ],
          labelColor:
              Colors.blue, // Couleur de l'icône et du texte sélectionnés
          unselectedLabelColor:
              Colors.grey, // Couleur des icônes et du texte non sélectionnés
          indicatorSize: TabBarIndicatorSize.label, // Taille de l'indicateur
          indicatorColor: Colors.blue, // Couleur de l'indicateur
        ),
      ),
    );
  }
}
