import '../generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry_management_mobile/blocs/app.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry_management_mobile/constants/constant.dart';
import 'package:laundry_management_mobile/screens/entry/detail.dart';
import 'package:laundry_management_mobile/models/client_summary.dart';
import 'package:laundry_management_mobile/screens/widgets/entry_item.dart';
import 'package:laundry_management_mobile/controllers/api_controller.dart';
import 'package:laundry_management_mobile/screens/widgets/empty_list.dart';
import 'package:laundry_management_mobile/controllers/profil_controller.dart';
import 'package:laundry_management_mobile/screens/widgets/squeleton_list.dart';

class HomeScreen extends StatefulWidget {
  final TabController tabController;

  const HomeScreen({super.key, required this.tabController});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String? user = "...";
  late ApiController apiController;

  bool isLoading = false;
  late ClientSummary clientSummary = ClientSummary(
      netBalance: 0,
      totalCard: 0,
      totalEncaisse: 0,
      totalNonEncaisse: 0,
      entry: []);

  @override
  void initState() {
    super.initState();
    _loadUserData();
    fetchClientSummary();
  }

  //
  void fetchClientSummary() {
    setState(() => isLoading = true);
    apiController.fetchData('spent').then((data) {
      setState(() {
        isLoading = false;
        clientSummary = ClientSummary.fromJson(data);
      });
    }).catchError((error) {
      setState(() => isLoading = false);
      debugPrint(
          "Erreur lors de la récupération des données : ${error.toString()}");
    });
  }

  Future<void> _loadUserData() async {
    final loadedUser = await ProfilController().getUserData();
    setState(() {
      user = loadedUser; // Fin du chargement
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSearchField(),
              SizedBox(height: 8.h),
              const Banner(),
              SizedBox(height: 8.h),
              _buildGridView(),
              SizedBox(height: 10.h),
              _buildEntriesHeader(),
              SizedBox(height: 10.h),
              _buildEntriesList()
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildUserInfo(),
          _buildActionIcons(),
        ],
      ),
    );
  }

  Row _buildUserInfo() {
    return Row(
      children: [
        CircleAvatar(
            backgroundImage: const NetworkImage(
                'https://static.vecteezy.com/system/resources/thumbnails/005/545/335/small/user-sign-icon-person-symbol-human-avatar-isolated-on-white-backogrund-vector.jpg'),
            radius: 20.r),
        SizedBox(width: 10.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(S.of(context).hello,
                style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w300,
                    color: Colors.black)),
            Text("Mr, $user",
                style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
          ],
        ),
      ],
    );
  }

  Row _buildActionIcons() {
    return Row(
      children: [
        IconButton(
          icon: const Stack(
            children: [
              Icon( Icons.logout_outlined, color: Colors.black)
            ],
          ),
          onPressed: () {
            BlocProvider.of<AppBloc>(context).add(LoggedOut());
          },
        ),
      ],
    );
  }

  Padding _buildSearchField() {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: TextField(
        onSubmitted: (value) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EntryDetailScreen(entryId: value),
            ),
          );
        },
        decoration: InputDecoration(
          hintText: 'Entrer la réference de votre dépôt...',
          prefixIcon: Icon(Icons.search, color: Constants.darkGreyColor),
          filled: true,
          fillColor: Constants.greyColor,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.r),
              borderSide: BorderSide.none),
        ),
      ),
    );
  }

  Column _buildGridView() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: SizedBox(
              height: 140.h,
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                children: [
                  BalanceCard(
                      wording: "Balance nette",
                      balance: clientSummary.netBalance,
                      icon: Icons.balance,
                      isLoading: isLoading),
                  BalanceCard(
                      wording: "Total carte",
                      balance: clientSummary.totalCard,
                      icon: Icons.credit_card,
                      isLoading: isLoading),
                ],
              ),
            ))
          ],
        ),
        Row(
          children: [
            Expanded(
                child: SizedBox(
              height: 140.h,
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                children: [
                  BalanceCard(
                      wording: "Encaissé",
                      balance: clientSummary.totalEncaisse,
                      icon: Icons.money,
                      isLoading: isLoading),
                  BalanceCard(
                      wording: "Non encaissé",
                      balance: clientSummary.totalNonEncaisse,
                      icon: Icons.monitor_heart_outlined,
                      isLoading: isLoading),
                ],
              ),
            ))
          ],
        ),
      ],
    );
  }

  Padding _buildEntriesHeader() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Derniers dépôts",
                style: TextStyle(
                    fontSize: 20.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
            GestureDetector(
              onTap: () {
                widget.tabController.animateTo(1);
              },
              child: Text("Voir plus",
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w300,
                      color: Colors.black)),
            ),
          ],
        ));
  }

  Skeletonizer _buildEntriesList() {
    return Skeletonizer(
        enabled: isLoading,
        child: SizedBox(
            height: clientSummary.entry.isNotEmpty ? 300 : null,
            child: isLoading
              ? const SqueletonList()
              : clientSummary.entry.isNotEmpty
                  ? ListView.builder(
                      padding: const EdgeInsets.all(8.0),
                      itemCount: clientSummary.entry.length,
                      itemBuilder: (context, index) {
                        return EntryItem(
                            index: index, entries: clientSummary.entry);
                      },
                    )
                  : const EmptyList(wording: "Aucune dépense")));
  }
}

class BalanceCard extends StatelessWidget {
  final String wording;
  final double balance;
  final IconData icon;
  final bool isLoading;

  const BalanceCard(
      {required this.wording,
      required this.balance,
      required this.icon,
      required this.isLoading,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
        enabled: isLoading,
        child: Card(
          color: Constants.greyColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
          // elevation: 5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 60.w, // Largeur de la boîte
                height: 50.h, // Hauteur de la boîte
                decoration: BoxDecoration(
                  color: Colors.blue[50], // Couleur de fond de la boîte (couleur violette très claire)
                  borderRadius: BorderRadius.circular(35.r), // Bordures arrondies
                ),
                child: Icon(icon, // Icône représentant un moniteur
                    color: Colors.blue, // Couleur de l'icône
                    size: 35.sp // Taille de l'icône
                    ),
              ),
              SizedBox(height: 10.h),
              Text(
                wording,
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w300),
              ),
              SizedBox(height: 5.h),
              Text(
                balance.toStringAsFixed(2),
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ],
          ),
        ),
      );
  }
}

class Banner extends StatelessWidget {
  const Banner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110.h,
      decoration: BoxDecoration(
          color: Constants.darkBlueColor,
          borderRadius: BorderRadius.circular(20.r)),
      child: Stack(
        children: [
          // Contenu texte
          Positioned(
            left: 10.w, // Updated to use responsive width
            top: 10.h, // Updated to use responsive height
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Obtenez 5% de remise',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp, // Responsive font size
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10.h), // Responsive height
                Text(
                  'Jour très spécial!',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp // Responsive font size
                      ),
                ),
                SizedBox(height: 5.h), // Responsive height
                Text(
                  'Bénéficiez d\'une réduction',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp // Responsive font size
                      ),
                ),
              ],
            ),
          ),
          // Image à droite
          Positioned(
            right: 5.w, // Updated to use responsive width
            bottom: 10.h, // Updated to use responsive height
            child: Image.network(
                'assets/images/black-girl.png', // Remplacer par l'URL de ton image
                width: 110.w, // Responsive width
                height: 100.h, // Responsive height
                fit: BoxFit.cover),
          ),
        ],
      ),
    );
  }
}
