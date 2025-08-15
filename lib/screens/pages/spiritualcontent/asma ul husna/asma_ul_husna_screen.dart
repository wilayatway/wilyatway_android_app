import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wilayat_way_apk/screens/pages/spiritualcontent/asma%20ul%20husna/asma.dart';

class AsmaUlHusnaScreen extends StatefulWidget {
  const AsmaUlHusnaScreen({super.key});

  @override
  _AsmaUlHusnaScreenState createState() => _AsmaUlHusnaScreenState();
}

class _AsmaUlHusnaScreenState extends State<AsmaUlHusnaScreen> {
  List<AsmaModel> asmaList = [];
  List<AsmaModel> filteredList = [];
  String selectedLang = 'roman';

  bool isSearching = false;
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadAsma();
  }

  Future<void> loadAsma() async {
    final String jsonString = await rootBundle.loadString(
      'assets/data/asma_e_husna.json',
    );
    final List<dynamic> jsonData = json.decode(jsonString);
    setState(() {
      asmaList = jsonData.map((e) => AsmaModel.fromJson(e)).toList();
      filteredList = asmaList;
    });
  }

  void startSearch() {
    setState(() {
      isSearching = true;
    });
  }

  void stopSearch() {
    setState(() {
      isSearching = false;
      searchController.clear();
      filteredList = asmaList;
    });
  }

  void onSearchTextChanged(String query) {
    final lowerQuery = query.toLowerCase();
    setState(() {
      filteredList =
          asmaList.where((item) {
            return item.arabic.toLowerCase().contains(lowerQuery) ||
                item.roman.toLowerCase().contains(lowerQuery) ||
                item.urduDesc.toLowerCase().contains(lowerQuery) ||
                item.englishDesc.toLowerCase().contains(lowerQuery);
          }).toList();
    });
  }

  String getDescription(AsmaModel item) {
    switch (selectedLang) {
      case 'english':
        return item.englishDesc;
      case 'urdu':
        return item.urduDesc;
      case 'roman':
      default:
        return item.romanDesc;
    }
  }

  Widget buildLangTab(String langKey, String label) {
    final bool isSelected = selectedLang == langKey;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedLang = langKey;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                color: Colors.green,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 16, 
              ),
            ),
            if (isSelected)
              Container(
                margin: EdgeInsets.only(top: 4),
                height: 2,
                width: 30,
                color: Colors.white,
              ),
          ],
        ),
      ),
    );
  }

  Widget buildSearchBar() {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: isSearching ? 50 : 0,
      curve: Curves.easeInOut,
      color: Colors.white.withOpacity(0.15),
      padding: EdgeInsets.symmetric(horizontal: 12),
      child:
          isSearching
              ? TextField(
                controller: searchController,
                autofocus: true,
                style: TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  hintText: "Search...",
                  hintStyle: TextStyle(color: Colors.white70),
                  border: InputBorder.none,
                  suffixIcon: IconButton(
                    icon: Icon(Icons.close, color: Colors.white),
                    onPressed: () {
                      if (searchController.text.isEmpty) {
                        stopSearch();
                      } else {
                        searchController.clear();
                        onSearchTextChanged('');
                      }
                    },
                  ),
                ),
                onChanged: onSearchTextChanged,
              )
              : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/images/bg2.png',
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.white.withOpacity(0.4),
            elevation: 0,
            centerTitle: true,
            title: Text("Asma-e-Husna"),
            actions: [
              if (!isSearching)
                IconButton(
                  icon: Icon(Icons.search, color: Colors.white),
                  onPressed: startSearch,
                ),
            ],
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(isSearching ? 50 : 0),
              child: buildSearchBar(),
            ),
          ),
          body:
              filteredList.isEmpty
                  ? Center(
                    child: Text(
                      "No results found",
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  )
                  : ListView.builder(
                    padding: EdgeInsets.all(12),
                    itemCount: filteredList.length,
                    itemBuilder: (context, index) {
                      final item = filteredList[index];
                      return AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        child: Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              // dividerColor: Colors.transparent,
                              unselectedWidgetColor: const Color.fromARGB(255, 255, 255, 255),
                              colorScheme: ColorScheme.dark(),
                            ),
                            child: ExpansionTile(
                              title: Center(
                                child: Text(
                                  item.arabic,
                                  style: TextStyle(
                                    fontSize: 28,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              subtitle: Center(
                                child: Text(
                                  item.roman,
                                  style: TextStyle(color: Colors.black45),
                                ),
                              ),
                              iconColor: const Color.fromARGB(255, 4, 122, 0),
                              collapsedIconColor: const Color.fromARGB(179, 255, 0, 0),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      // Language selection row
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          buildLangTab('roman', 'Roman'),
                                          buildLangTab('english', 'English'),
                                          buildLangTab('urdu', 'اردو'),
                                        ],
                                      ),
                                      SizedBox(height: 16),
                                      Text(
                                        getDescription(item),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 16,
                                          height: 1.5,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
        ),
      ],
    );
  }
}
