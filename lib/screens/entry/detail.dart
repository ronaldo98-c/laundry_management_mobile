import 'package:flutter/material.dart';
import 'package:laundry_management_mobile/data/data.dart';
import 'package:laundry_management_mobile/models/entry.dart';
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
    Size size = MediaQuery.of(context).size;
    List<Entry> entries = getEntries();

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 50,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Constants.darkBlueColor.withOpacity(.15),
                    ),
                    child: Icon(
                      Icons.close,
                      color: Constants.darkBlueColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 100,
            left: 20,
            right: 20,
            child: Container(
              width: size.width * .8,
              height: size.height * .8,
              padding: const EdgeInsets.all(20),
              child: Stack(
                children: [
                  const Positioned(
                    top: 10,
                    left: 0,
                    child: SizedBox(
                      height: 350,
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 0,
                    child: SizedBox(
                      height: 200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          EntryFeature(
                            title: entries[widget.entryId].paymentStatus,
                            entryFeature: entries[widget.entryId].releaseDate,
                          ),
                          EntryFeature(
                            title: entries[widget.entryId].paymentStatus,
                            entryFeature: entries[widget.entryId].reference ,
                          ),
                          EntryFeature(
                            title: entries[widget.entryId].paymentStatus,
                            entryFeature: entries[widget.entryId].reference,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          /*Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.only(top: 80, left: 30, right: 30),
              height: size.height * .5,
              width: size.width,
              decoration: BoxDecoration(
                color: Constants.darkBlueColor.withOpacity(.4),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            entries[widget.entryId].state,
                            style: TextStyle(
                              color: Constants.darkBlueColor.withOpacity(.4),
                              fontWeight: FontWeight.bold,
                              fontSize: 30.0,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            r'$' + entries[widget.entryId].totalAmount.toString(),
                            style: TextStyle(
                              color: Constants.blackColor,
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            entries[widget.entryId].amountAdvance.toString(),
                            style: TextStyle(
                              fontSize: 30.0,
                              color: Constants.darkBlueColor.withOpacity(.4),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Expanded(
                    child: Text(
                      entries[widget.entryId].typeOfWash,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        height: 1.5,
                        fontSize: 18,
                        color: Constants.blackColor.withOpacity(.7),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),*/
        ],
      )
    );
  }
}

class EntryFeature extends StatelessWidget {
  final String entryFeature;
  final String title;
  const EntryFeature({
    super.key,
    required this.entryFeature,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Constants.blackColor,
          ),
        ),
        Text(
          entryFeature,
          style: TextStyle(
            color: Constants.darkBlueColor.withOpacity(.3),
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}
