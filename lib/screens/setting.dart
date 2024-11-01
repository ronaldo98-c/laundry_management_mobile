import 'package:flutter/material.dart';
import 'package:laundry_management_mobile/screens/widgets/profile_widget.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16),
        height: size.height,
        width: size.width,
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             const SizedBox(
              height: 10,
            ),
            const Text(
              'Paramètres',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              ),
            ),
            const Text(
              "Option de configuration de l'application",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: size.height * .7,
              width: size.width,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ProfileWidget(
                    icon: Icons.person,
                    title: 'Mon profil',
                    subTitle: 'Consultez votre profil'
                  ),
                  ProfileWidget(
                    icon: Icons.language,
                    title: 'Langues',
                    subTitle: 'Français'
                  ),
                  ProfileWidget(
                    icon: Icons.chat,
                    title: 'FAQs',
                    subTitle: 'Informations sur l\'application'
                  ),
                  ProfileWidget(
                    icon: Icons.share,
                    title: 'Partager l \'application',
                    subTitle: 'Inviter vos amis'
                  ),
                  ProfileWidget(
                    icon: Icons.logout,
                    title: 'Se deconnecter',
                    subTitle: 'Terminer votre session'
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
