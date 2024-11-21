import '../generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:laundry_management_mobile/data/data.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry_management_mobile/models/entry.dart';
import 'package:laundry_management_mobile/constants/constant.dart';
import 'package:laundry_management_mobile/screens/widgets/entry_item.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  final TabController tabController;

  const HomeScreen({super.key, required this.tabController});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Entry> lastEntries = [];

  @override
  void initState() {
    super.initState();
    lastEntries = getEntries().take(4).toList();
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
    return  Row(
      children: [
        CircleAvatar(
          backgroundImage: const NetworkImage(
              'https://static.vecteezy.com/system/resources/thumbnails/005/545/335/small/user-sign-icon-person-symbol-human-avatar-isolated-on-white-backogrund-vector.jpg'),
          radius: 20.r
        ),
        SizedBox(width: 10.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(S.of(context).hello, style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w300, color: Colors.black)),
            Text('Ronaldo Gantchi', style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold, color: Colors.black)),
          ],
        ),
      ],
    );
  }

  Row _buildActionIcons() {
    return Row(
      children: [
        IconButton(
          icon: Stack(
            children: [
              const Icon(Icons.notifications, color: Colors.black),
              Positioned(right: 0, child: CircleAvatar(radius: 4.r, backgroundColor: Colors.red)),
            ],
          ),
          onPressed: () {}
        ),
      ],
    );
  }

  Padding _buildSearchField() {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Entrer la réference de votre dépôt...',
          prefixIcon: Icon(Icons.search, color: Constants.darkGreyColor),
          filled: true,
          fillColor: Constants.greyColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: BorderSide.none
          ),
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
                  children: const [
                    BalanceCard(wording: "Balance nette", balance: 20, icon: Icons.balance),
                    BalanceCard(wording: "Total carte", balance: 100, icon: Icons.credit_card),
                  ],
                ),
              )
            ) 
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
                  children: const [
                    BalanceCard(wording: "Encaissé", balance: 500, icon: Icons.money),
                    BalanceCard(wording: "Non encaissé", balance: 200, icon: Icons.monitor_heart_outlined),
                  ],
                ),
              )
            )
          ],
        ),
      ],
    );
  } 

  Padding _buildEntriesHeader() {
    return  Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child:Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Derniers dépôts", style: TextStyle(fontSize: 20.sp, color: Colors.black, fontWeight: FontWeight.bold)),
          GestureDetector(
            onTap: () {
              widget. tabController.animateTo(1);
            },
            child: Text("Voir plus", style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w300, color: Colors.black)),
          ),
        ],
      )
    ) ;
  }

  SizedBox _buildEntriesList() {
    return SizedBox(
      height: 300.h,
      child: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: lastEntries.length,
        itemBuilder: (context, index) {
          return EntryItem(index: index, entries: lastEntries);
        },
      ),
    );
  }
}

class BalanceCard extends StatelessWidget {
  final String wording;
  final double balance;
  final IconData icon;

  const BalanceCard({required this.wording, required this.balance, required this.icon, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Constants.greyColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r)
      ),
     // elevation: 5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 60.w,  // Largeur de la boîte
            height: 50.h,  // Hauteur de la boîte
            decoration: BoxDecoration(
              color: Colors.blue[50],  // Couleur de fond de la boîte (couleur violette très claire)
              borderRadius: BorderRadius.circular(35.r),  // Bordures arrondies
            ),
            child: Icon(
              icon,  // Icône représentant un moniteur
              color: Colors.blue,  // Couleur de l'icône
              size: 35.sp  // Taille de l'icône
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
              color: Colors.black
            ),
          ),
        ],
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
        borderRadius: BorderRadius.circular(20.r)
      ),
      child: Stack(
        children: [
          // Contenu texte
          Positioned(
            left: 10.w, // Updated to use responsive width
            top: 10.h,  // Updated to use responsive height
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Obtenez 5% de remise',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp, // Responsive font size
                    fontWeight: FontWeight.bold
                  ),
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
              fit: BoxFit.cover
            ),
          ),
        ],
      ),
    );
  }
}
