import 'package:flutter/material.dart';
import 'package:laundry_management_mobile/data/data.dart';
//import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry_management_mobile/models/entry.dart';
import 'package:laundry_management_mobile/constants/constant.dart';
import 'package:laundry_management_mobile/screens/widgets/entry_item.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  const HomeScreen({super.key});

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
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSearchField(),
              const SizedBox(height: 8),
              const Banner(),
              const SizedBox(height: 8),
              _buildGridView(),
              const SizedBox(height: 16),
              _buildEntriesHeader(),
              const SizedBox(height: 16),
              _buildEntriesList(),
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
    return const Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(
              'https://static.vecteezy.com/system/resources/thumbnails/005/545/335/small/user-sign-icon-person-symbol-human-avatar-isolated-on-white-backogrund-vector.jpg'),
          radius: 20,
        ),
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Content de te revoir,', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300, color: Colors.black)),
            Text('Ronaldo Gantchi', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
          ],
        ),
      ],
    );
  }

  Row _buildActionIcons() {
    return Row(
      children: [
        IconButton(icon: const Icon(Icons.dark_mode_outlined, color: Colors.black), onPressed: () {}),
        IconButton(
          icon: const Stack(
            children: [
              Icon(Icons.notifications, color: Colors.black),
              Positioned(right: 0, child: CircleAvatar(radius: 4, backgroundColor: Colors.red)),
            ],
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  Padding _buildSearchField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Entrer la réference de votre dépôt...',
          prefixIcon: Icon(Icons.search, color: Constants.darkGreyColor),
          filled: true,
          fillColor: Constants.greyColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  SizedBox _buildGridView() {
    return SizedBox(
      height: 370,
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        children: const [
          BalanceCard(wording: "Balance nette", balance: 20, icon: Icons.balance),
          BalanceCard(wording: "Total carte", balance: 100, icon: Icons.credit_card),
          BalanceCard(wording: "Encaissé", balance: 500, icon: Icons.money),
          BalanceCard(wording: "Non encaissé", balance: 200, icon: Icons.monitor_heart_outlined),
        ],
      ),
    );
  }

  Row _buildEntriesHeader() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Derniers dépôts", style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold)),
        Text("Voir plus", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300, color: Colors.black)),
      ],
    );
  }

  SizedBox _buildEntriesList() {
    return SizedBox(
      height: 300,
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
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 60,  // Largeur de la boîte
            height: 60,  // Hauteur de la boîte
            decoration: BoxDecoration(
              color: Colors.blue[50],  // Couleur de fond de la boîte (couleur violette très claire)
              borderRadius: BorderRadius.circular(20),  // Bordures arrondies
            ),
            child: Icon(
              icon,  // Icône représentant un moniteur
              color: Colors.blue,  // Couleur de l'icône
              size: 40,  // Taille de l'icône
            ),
          ),
          const SizedBox(height: 10),
          Text(
            wording,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
          ),
          const SizedBox(height: 5),
          Text(
            '${balance.toStringAsFixed(2)} XFA',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
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
      height: 180,
      decoration: BoxDecoration(
        color: Constants.darkBlueColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          // Contenu texte
          const Positioned(
            left: 20,
            top: 30,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Obtenez 5% de remise',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Jour très spécial!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Bénéficiez d\'une réduction',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          // Image à droite
          Positioned(
            right: 10,
            bottom: 20,
            child: Image.network(
              'assets/images/black-girl.png', // Remplacer par l'URL de ton image
              width: 150,
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
