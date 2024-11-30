import 'package:flutter/material.dart';
import 'package:laundry_management_mobile/constants/constant.dart';
import 'package:laundry_management_mobile/models/entry.dart';


class FilterModal {
  final List<Entry> entryList;
  final Function(List<Entry>) updateEntryList;

  FilterModal(this.entryList, this.updateEntryList);

  static Future<void> showAddModal(BuildContext context, List<Entry> entryList, Function(List<Entry>) updateEntryList) async {
    final TextEditingController textField2Controller = TextEditingController();

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          contentPadding: const EdgeInsets.all(30),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: textField2Controller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Date', // Changed label to 'Date'
                    hintText: 'Choisir la date', // Changed hint text to 'Entrez la date'
                  ),
                  onTap: () async {
                    FocusScope.of(context).requestFocus(FocusNode()); // Prevent keyboard from showing
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000), // Set the first date
                      lastDate: DateTime(2101), // Set the last date
                    );
                    if (pickedDate != null) {
                      textField2Controller.text = "${pickedDate.toLocal()}".split(' ')[0]; // Format date
                    }
                  },
                ),
              ],
            )
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                minimumSize: const Size(100, 50)
              ),
              child: const Text('Annuler'),
              onPressed: () {
                Navigator.of(context).pop(); // Close modal
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Constants.darkBlueColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                minimumSize: const Size(100, 50)
              ),
              child: const Text('Filtrer'),
              onPressed: () {
                List<Entry> filteredList = filterEntryList(entryList, textField2Controller.text); // Appeler la fonction de filtrage
                updateEntryList(filteredList); // Mettre à jour entryList dans le parent
                Navigator.of(context).pop(); // Close modal after filtering
              },
            ),
          ],
        );
      },
    );
  }

  // Fonction pour filtrer entryList en fonction de createdAt
  static List<Entry> filterEntryList(List<Entry> entryList, String date) {
    DateTime? filterDate = DateTime.tryParse(date); // Convertir la date en DateTime
    if (filterDate != null) {
      List<Entry> filteredList = entryList.where((entry) {
        DateTime entryDate = DateTime.parse(entry.createdAt).toLocal(); // Convertir Entry.createdAt en DateTime
        return entryDate.year == filterDate.year && 
               entryDate.month == filterDate.month && 
               entryDate.day == filterDate.day; // Comparer uniquement les dates
      }).toList();
      
      return filteredList; // Retourner la liste filtrée
    } else {
      debugPrint('Date invalide'); // Gérer les dates invalides
      return []; // Retourner une liste vide en cas de date invalide
    }
  }
}