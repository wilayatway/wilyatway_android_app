import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wilayat_way_apk/screens/pages/spiritualcontent/experiences/maamlaat_detail_screen.dart'
    show MaamlaatDetailScreen;
import 'package:wilayat_way_apk/screens/pages/spiritualcontent/experiences/maamlaat_form.dart'
    show showMaamlaatForm;

class MaamlaatListScreen extends StatefulWidget {
  const MaamlaatListScreen({super.key});

  @override
  _MaamlaatListScreenState createState() => _MaamlaatListScreenState();
}

class _MaamlaatListScreenState extends State<MaamlaatListScreen> {
  String filter = 'all';
  String sort = 'newest';
  String searchQuery = '';
  final filters = ['all', 'answered', 'unanswered'];
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Maamlaat'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/images/bg2.png', fit: BoxFit.cover),
          ),
          Column(
            children: [
              SizedBox(height: kToolbarHeight + 20),

              // Search Bar
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value.toLowerCase();
                    });
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.9),
                    hintText: 'Search by name or details...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),

              // Filters and Sort
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: _buildDropdown(
                        icon: Icons.filter_alt,
                        value: filter,
                        items: filters,
                        onChanged: (val) => setState(() => filter = val!),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: _buildDropdown(
                        icon: Icons.sort,
                        value: sort,
                        items: ['newest', 'oldest'],
                        onChanged: (val) => setState(() => sort = val!),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),

              // Maamlaat List
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream:
                      FirebaseFirestore.instance
                          .collection('maamlaat')
                          .orderBy('date', descending: sort == 'newest')
                          .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }

                    final docs = snapshot.data?.docs ?? [];
                    final filteredDocs =
                        docs.where((doc) {
                          final statusMatches =
                              filter == 'all' ||
                              (doc['status']?.toString().toLowerCase() ?? '') ==
                                  filter.toLowerCase();

                          final name =
                              (doc['name'] ?? '').toString().toLowerCase();
                          final maamlaat =
                              (doc['maamlaat'] ?? '').toString().toLowerCase();
                          final searchMatches =
                              name.contains(searchQuery) ||
                              maamlaat.contains(searchQuery);

                          return statusMatches && searchMatches;
                        }).toList();

                    if (filteredDocs.isEmpty) {
                      return Center(
                        child: Text('No Maamlaat matched the filter.'),
                      );
                    }

                    return ListView.builder(
                      padding: EdgeInsets.all(16),
                      itemCount: filteredDocs.length,
                      itemBuilder: (context, index) {
                        final doc = filteredDocs[index];
                        final name = doc['name'] ?? 'No Name';
                        final maamlaat = doc['maamlaat'] ?? 'No Details';

                        return Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          margin: EdgeInsets.only(bottom: 16),
                          child: ListTile(
                            contentPadding: EdgeInsets.all(16),
                            title: Text(
                              name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            subtitle: Text(
                              maamlaat.length > 100
                                  ? maamlaat.substring(0, 100) + '...'
                                  : maamlaat,
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) =>
                                          MaamlaatDetailScreen(docId: doc.id),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),

      // FAB to Add New Maamlaat
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showMaamlaatForm(context),
        icon: Icon(Icons.edit_note_rounded, size: 26, color: Colors.amber),
        backgroundColor: Colors.teal,
        label: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Apne roohani mamlaat batayen',
              style: TextStyle(fontSize: 14, color: Colors.black87),
            ),
            Text(
              'Share your spiritual experiences here',
              style: TextStyle(
                fontSize: 13,
                color: Color.fromARGB(255, 32, 32, 32),
              ),
            ),
          ],
        ),
        extendedPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  Widget _buildDropdown({
    required IconData icon,
    required String value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButton<String>(
        value: value,
        isExpanded: true,
        underline: SizedBox(),
        icon: Icon(icon, color: Colors.deepPurple),
        items:
            items
                .map(
                  (val) => DropdownMenuItem(
                    value: val,
                    child: Text(
                      val[0].toUpperCase() + val.substring(1),
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                )
                .toList(),
        onChanged: onChanged,
      ),
    );
  }

  void _showMaamlaatForm(BuildContext context) {
    if (!mounted) return;
    showMaamlaatForm(context);
  }
}
