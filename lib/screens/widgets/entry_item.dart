import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry_management_mobile/models/entry.dart';
import 'package:laundry_management_mobile/screens/entry/detail.dart';

class EntryItem extends StatelessWidget {
  const EntryItem({
    super.key,
    required this.index,
    required this.entries
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
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: Row(
            children: [
              Container(
                width: 50.w, // Largeur de la boîte
                height: 40.h, // Hauteur de la boîte
                decoration: BoxDecoration(
                  color: Colors.blue[50], // Couleur de fond de la boîte (couleur violette très claire)
                  borderRadius: BorderRadius.circular(25.r), // Bordures arrondies
                ),
                child: Icon(
                  Icons.local_laundry_service_sharp, // Icône représentant un moniteur
                  color: Colors.blue, // Couleur de l'icône
                  size: 25.sp // Taille de l'icône
                )
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entries[index].state,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 14.sp)
                    ),
                    Text(
                      entries[index].typeOfWash.length > 22
                          ? '${entries[index].typeOfWash.substring(0, 22)}...' // Limite à 20 caractères
                          : entries[index].typeOfWash,
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: Colors.black,
                          fontSize: 12.sp),// Ajoute des points de suspension
                    )
                  ],
                )
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    entries[index].totalAmount.toString() + r' XFA',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 13.sp)
                  ),
                  Text(
                    entries[index].createdAt,
                    style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
