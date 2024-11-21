import 'package:flutter/material.dart';
/*import 'package:laundry_management_mobile/data/data.dart';
import 'package:laundry_management_mobile/models/entry.dart'; */
import 'package:laundry_management_mobile/constants/constant.dart';


class EntryDetailScreen extends StatefulWidget {
  final int entryId;
  const EntryDetailScreen({super.key, required this.entryId});

  @override
  State<EntryDetailScreen> createState() => _EntryDetailScreenState();
}

class _EntryDetailScreenState extends State<EntryDetailScreen> {
  //Toggle Favorite button
  bool toggleIsFavorated(bool isFavorited) {
    return !isFavorited;
  }

  //Toggle add remove from cart
  bool toggleIsSelected(bool isSelected) {
    return !isSelected;
  }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.close,
            color: Constants.darkBlueColor,
          ),
        )
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Liste des vêtements', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10.0), // Réduit l'espace après le titre
            Flexible(
              child: ListView(
                shrinkWrap: true, // Réduit l'espace occupé par ListView
                children: [
                  buildItem('Polo ~ Bleu ~ M', 'x 1'),
                  buildItem('Pantalon ~ Noir ~ XL', 'x 2'),
                  buildItem('Tshirt ~ Bleu ~ M', 'x 4')
                ],
              ),
            ),
            const SizedBox(height: 16.0), // Réduit l'espace entre la liste et l'offre
            buildOfferSection(),
            const Divider(),
            buildEntryBreakdown(),
          ],
        ),
      ),
    );
  }


  Widget buildItem(String name, String quantity) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        width: 60,
        height: 60,
        color: Colors.grey[300], // Placeholder for image
      ),
      title: Text(name),
      subtitle: Text(quantity)
    );
  }

  Widget buildOfferSection() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.pink[50],
        border: Border.all(color: Colors.pink),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: const Row(
        children: [
          Icon(Icons.local_offer, color: Colors.pink),
          SizedBox(width: 8.0),
          Expanded(
            child: Text('Une remise de 10% a été appliqué sur le montant total!',
                style: TextStyle(color: Colors.pink)),
          ),
        ],
      ),
    );
  }

  Widget buildEntryBreakdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Informations supplémentaires', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8.0),
        buildEntryRow('Reference', 'lt0215633015'),
        buildEntryRow('Total vêtement', '10'),
        buildEntryRow('Total kilo', '2.5 kilos'),
        buildEntryRow('Methode de paiement', 'En cash'),
        buildEntryRow('Status de paiement', 'Soldé'),
        buildEntryRow('Avance', '0 Xfa'),
        buildEntryRow('Status de paiement', 'Soldé'),
        const Divider(),
        buildEntryRow('Total', '1500 xfa', isBold: true),
        buildEntryRow('Avec remise', '1000 xfa', isBold: true),
        buildEntryRow('Reste', '0 xfa', isBold: true),
      ],
    );
  }

  Widget buildEntryRow(String label, String amount, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
          Text(amount, style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }
}
