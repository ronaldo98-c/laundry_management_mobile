class Entry {
  int entryId;
  String state;
  String reference;
  String typeOfWash;
  int numberOfkilograms;
  double totalAmount;
  double amountReceived;
  String releaseDate;
  int totalClotheNumber;
  double amountPaid;
  double discounPercentage;
  double amountAdvance;
  String paymentStatus;
  String refundStatus;
  String paymentMethod;
  String createdAt;

  Entry(
     this.entryId, this.state, this.reference, this.typeOfWash, this.numberOfkilograms, this.totalAmount, this.amountReceived, this.releaseDate, this.totalClotheNumber, this.amountPaid, this.discounPercentage, this.amountAdvance, this.paymentStatus, this.refundStatus, this.paymentMethod, this.createdAt);
}