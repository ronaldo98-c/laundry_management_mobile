import 'package:flutter/material.dart';
import 'package:laundry_management_mobile/models/entry.dart';
import 'package:laundry_management_mobile/screens/entry/detail.dart';

class EntryItem extends StatelessWidget {
  const EntryItem({
    super.key,
    required this.index,
    required this.entries,
  });

  final int index;
  final List<Entry> entries;

  @override
  Widget build(BuildContext context) {
    //  Size size = MediaQuery.of(context).size;

    return GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  EntryDetailScreen(entryId: entries[index].entryId)));
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              Container(
                width: 50, // Largeur de la boîte
                height: 50, // Hauteur de la boîte
                decoration: BoxDecoration(
                  color: Colors.blue[
                      50], // Couleur de fond de la boîte (couleur violette très claire)
                  borderRadius: BorderRadius.circular(20), // Bordures arrondies
                ),
                child: const Icon(
                  Icons.local_laundry_service_sharp, // Icône représentant un moniteur
                  color: Colors.blue, // Couleur de l'icône
                  size: 25, // Taille de l'icône
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entries[index].state,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 16.0),
                    ),
                    Text(
                      entries[index].typeOfWash,
                      style: const TextStyle(
                          fontWeight: FontWeight.w300,
                          color: Colors.black,
                          fontSize: 14),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    entries[index].totalAmount.toString() + r' XFA',
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0),
                  ),
                  Text(
                    entries[index].createdAt,
                    style: const TextStyle(color: Colors.grey, fontSize: 14.0),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
