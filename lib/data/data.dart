import 'package:laundry_management_mobile/models/entry.dart';

Entry getDefaultEntry() {
  Entry entry = 
    Entry(
        entryId: 0,
        state: "",
        reference: "",
        typeOfWash: "",
        numberOfkilograms: 0,
        totalAmount:  0,
        amountReceived: 0,
        releaseDate: "",
        totalClotheNumber: 0,
        amountPaid: 0,
        discounPercentage: 0 ,
        amountAdvance: 0,
        paymentStatus: "0",
        refundStatus: "0",
        paymentMethod: "0",
        createdAt: ""
    ); 

  return entry;
}