
import 'package:laundry_management_mobile/models/entry.dart';

class ClientSummary {
 double netBalance;
 double totalCard;
 double totalEncaisse;
 double totalNonEncaisse;
 List<Entry> entry;

  ClientSummary({required this.netBalance, required this.totalCard, required this.totalEncaisse, required this.totalNonEncaisse, required this.entry});

  factory ClientSummary.fromJson(Map<String, dynamic> json) {
    return ClientSummary(
      netBalance: json['net_balance'].toDouble(),
      totalCard: json['total_card'].toDouble(),
      totalEncaisse: json['total_encaisse'].toDouble(),
      totalNonEncaisse: json['total_non_encaisse'].toDouble(),
      entry: List<Entry>.from(json['latest_entries'].map((item) =>  
      Entry(
        entryId: item['id'],
        state: item['state'],
        typeOfWash: json['management_mode'] != null ? json['management_mode']['type_of_washing'] : '' ,
        totalAmount: item['total_amount'],
        createdAt: item['created_at']
      ) 
    ))
    );
  }
}