import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry_management_mobile/data_manager.dart';
import 'package:laundry_management_mobile/date_fetcher.dart';
import 'package:laundry_management_mobile/models/entry.dart';
import 'package:laundry_management_mobile/controllers/api_controller.dart';
import 'package:laundry_management_mobile/screens/widgets/empty_list.dart';
import 'package:laundry_management_mobile/screens/widgets/entry_item.dart';
import 'package:laundry_management_mobile/screens/widgets/filter_modal.dart';
import 'package:laundry_management_mobile/screens/widgets/squeleton_list.dart';


class EntryScreen extends StatefulWidget {
  const EntryScreen({super.key});

  @override
  State<EntryScreen> createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  late ApiController apiController;
  late DataManager<Entry> dataManager;
  late DataFetcher<Entry> dataFetcher;

  List<Entry> entryList = [];
  bool isLoadingEntries = false;

  @override
  void initState() {
    super.initState();
    apiController = ApiController();
    dataManager = DataManager<Entry>(apiController,
        'entry/list/pageNumber/NULL/specificDate/NULL/startDate/NULL/endDate/NULL/status/NULL');
    dataFetcher = DataFetcher<Entry>();

    fetchEntries();
  }

  // Récupérer les groupes
  void fetchEntries() {
    setState(() => isLoadingEntries = true);
    dataFetcher.fetchAndSetData(
        fetchData: () => dataManager.fetchData((json) => Entry.fromJson(json)), // Exemple de parsing
        onSetData: (data) => setState(() => entryList = data),
        onComplete: () => setState(() => isLoadingEntries = false),
        context: context);
  }

  //
  void updateEntryList(List<Entry> data) {
    setState(() => entryList = data);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text(
                      'Tout vos dépôts',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      '10 au total',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        // Utilisez Expanded pour le TextField
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Entrez la réference du dépôt...',
                            prefixIcon:
                                const Icon(Icons.search, color: Colors.grey),
                            filled: true,
                            fillColor: Colors.grey[200], // Correction ici
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.r),
                                borderSide: BorderSide.none),
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Container(
                        width: 45.w,
                        height: 35.h,
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(15.r)),
                        child: IconButton(
                          onPressed: () {
                            FilterModal.showAddModal(context, entryList, updateEntryList);
                          },
                          icon: const Icon(Icons.filter_list),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Skeletonizer(
                          // Added Skeletonizer
                          enabled: isLoadingEntries,
                          child: SizedBox(
                            height: entryList.isNotEmpty ? size.height * 0.75 : null,
                            child: isLoadingEntries // Check if spentList is empty
                                ? const SqueletonList() // Show EmptyList if no items
                                : entryList.isNotEmpty
                                    ? ListView.builder(
                                        itemCount: entryList.length,
                                        scrollDirection: Axis.vertical,
                                        physics: const BouncingScrollPhysics(),
                                        itemBuilder: (BuildContext context, int index) {
                                          return EntryItem(index: index, entries: entryList);
                                        },
                                      )
                                    : const EmptyList(wording: "Aucun dépôt")),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
