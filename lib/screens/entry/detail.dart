import 'package:flutter/material.dart';
import 'package:laundry_management_mobile/constants/constant.dart';
import 'package:laundry_management_mobile/controllers/api_controller.dart';
import 'package:laundry_management_mobile/models/entry.dart';
import 'package:laundry_management_mobile/screens/widgets/empty_list.dart';
import 'package:skeletonizer/skeletonizer.dart';


class EntryDetailScreen extends StatefulWidget {
  final dynamic entryId;
  const EntryDetailScreen({super.key, required this.entryId});

  @override
  State<EntryDetailScreen> createState() => _EntryDetailScreenState();
}

class _EntryDetailScreenState extends State<EntryDetailScreen> {
  late ApiController apiController;
  late Entry entry;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchEntry(widget.entryId);
  }

  //
  void fetchEntry(int entryId) {
    setState(() => isLoading = true);
    apiController.fetchData('entry/detail/$entryId').then((data) {
      setState(() {
        isLoading = false;
        entry = Entry.fromJson(data);
      });
    }).catchError((error) {
      setState(() => isLoading = false);
      debugPrint("Erreur lors de la récupération des données : ${error.toString()}");
    });
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
      body:  Skeletonizer(
        enabled: isLoading,
        child:Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Liste des vêtements', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10.0), // Réduit l'espace après le titre
              Flexible(
                child: entry.clothes != null && entry.clothes!.isNotEmpty 
                  ? ListView(
                      shrinkWrap: true, // Réduit l'espace occupé par ListView
                      children: entry.clothes!.map((item) => buildItem(item.category, 'x ${item.quantity}')).toList(),
                    )
                  : const EmptyList(wording: 'Aucun vêtement disponible'), // Message si la liste est vide
              ),
              const SizedBox(height: 16.0), // Réduit l'espace entre la liste et l'offre
              buildOfferSection(entry.discounPercentage),
              const Divider(),
              buildEntryBreakdown(entry),
            ],
          ),
        ),
      ) 
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

  Widget buildOfferSection(discounPercentage) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.pink[50],
        border: Border.all(color: Colors.pink),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          const Icon(Icons.local_offer, color: Colors.pink),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text('Une remise de $discounPercentage % a été appliqué sur le montant total!',
                style: const TextStyle(color: Colors.pink)),
          ),
        ],
      ),
    );
  }

  Widget buildEntryBreakdown(Entry entry) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Informations supplémentaires', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8.0),
        buildEntryRow('Reference', entry.reference.toString()),
        buildEntryRow('Total vêtement', entry.totalClotheNumber.toString()),
        buildEntryRow('Total kilo', '${entry.numberOfkilograms} Kilos'),
        buildEntryRow('Methode de paiement', entry.paymentMethod.toString()),
        buildEntryRow('Status de paiement', entry.paymentStatus.toString()),
        buildEntryRow('Avance', '${entry.amountAdvance} XFA'),
        const Divider(),
        buildEntryRow('Total', '${entry.totalAmount} XFA', isBold: true),
        buildEntryRow('Avance', '${entry.amountAdvance} XFA', isBold: true),
        buildEntryRow('Montant payé', '${entry.amountPaid} XFA', isBold: true)
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
