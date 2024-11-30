import 'package:laundry_management_mobile/models/clothe.dart';

class Entry {
  int entryId;
  String? state;
  String? reference;
  String typeOfWash;
  int? numberOfkilograms;
  double? totalAmount;
  double? amountReceived;
  String? releaseDate;
  int? totalClotheNumber;
  double? amountPaid;
  double? discounPercentage;
  double? amountAdvance;
  String? paymentStatus;
  String? refundStatus;
  String? paymentMethod;
  String createdAt;
  List<Clothe>? clothes;

  Entry({required this.entryId, this.state, this.reference, required this.typeOfWash, this.numberOfkilograms, this.totalAmount, this.amountReceived, this.releaseDate, this.totalClotheNumber, this.amountPaid, this.discounPercentage, this.amountAdvance, this.paymentStatus, this.refundStatus, this.paymentMethod, required this.createdAt, this.clothes});

  factory Entry.fromJson(Map<String, dynamic> json) {
    return Entry(
      entryId: json['id'],
      state: json['state'],
      reference: json['reference'],
      typeOfWash: json['management_mode']['type_of_washing'],
      numberOfkilograms: json['number_of_kilograms'],
      totalAmount: json['total_amount'],
      amountReceived: json['amount_received'],
      releaseDate: json['release_date'],
      totalClotheNumber: json['total_clothe_number'],
      amountPaid: json['amount_paid'],
      discounPercentage: json['discount_percentage'],
      amountAdvance: json['amount_advance'],
      paymentStatus: json['payment_status'],
      refundStatus: json['refund_status'],
      paymentMethod: json['payment_method'],
      createdAt: json['created_at'],
      clothes: List<Clothe>.from(json['entry_clothes'].map((item) =>  
        Clothe(
          clotheId: item['clothe_id'],
          category: item['category'],
          brand: item['brand'],
          size: item['size'],
          color: item['color'],
          quantity: item['quantity'],
          ironingPercentage: item['ironing_percentage'],
          createdAt: item['created_at']
        ) 
      ))
    );
  }
}