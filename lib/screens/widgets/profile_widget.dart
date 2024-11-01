import 'package:flutter/material.dart';
import 'package:laundry_management_mobile/constants/constant.dart';

class ProfileWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subTitle;

  const ProfileWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.subTitle
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: [
          Container(
              width: 50,  // Largeur de la boîte
              height: 50,  // Hauteur de la boîte
              decoration: BoxDecoration(
                color: Colors.blue[50],  // Couleur de fond de la boîte (couleur violette très claire)
                borderRadius: BorderRadius.circular(20),  // Bordures arrondies
              ),
              child: Icon(
                icon,  // Icône représentant un moniteur
                color: Colors.blue,  // Couleur de l'icône
                size: 25,  // Taille de l'icône
              ),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Constants.blackColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  subTitle,
                  style: const TextStyle(
                    fontWeight: FontWeight.w300, 
                    color: Colors.black,
                    fontSize: 14
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios,
            color: Colors.blue,
            size: 16,
          )
        ],
      ),
    );
  }
}
