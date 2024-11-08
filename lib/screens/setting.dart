import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry_management_mobile/blocs/app.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
            SizedBox(
              height: 10.h,
            ),
            Text(
              'Paramètres',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold
              ),
            ),
            Text(
              "Option de configuration de l'application",
              style: TextStyle(
                color: Colors.black,
                fontSize: 14.sp,
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            SizedBox(
              height: size.height * .7,
              width: size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const ProfileWidget(
                    icon: Icons.person,
                    title: 'Mon profil',
                    subTitle: 'Consultez votre profil'
                  ),
                  const ProfileWidget(
                    icon: Icons.language,
                    title: 'Langues',
                    subTitle: 'Français'
                  ),
                  const ProfileWidget(
                    icon: Icons.chat,
                    title: 'FAQs',
                    subTitle: 'Informations sur l\'application'
                  ),
                  const ProfileWidget(
                    icon: Icons.share,
                    title: 'Partager l \'application',
                    subTitle: 'Inviter vos amis'
                  ),
                  ProfileWidget(
                    icon: Icons.logout,
                    title: 'Se deconnecter',
                    subTitle: 'Terminer votre session',
                    onTap: () {
                      // Afficher la boîte de confirmation
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Confirmation'),
                            content: const Text('Êtes-vous sûr de vouloir vous déconnecter ?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(); // Fermer la boîte de dialogue
                                },
                                child: const Text('Annuler'),
                              ),
                              TextButton(
                                onPressed: () {
                                  BlocProvider.of<AppBloc>(context)
                                              .add(LoggedOut());
                                },
                                child: const Text('Se déconnecter'),
                              ),
                            ],
                          );
                        },
                      );
                    },
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
