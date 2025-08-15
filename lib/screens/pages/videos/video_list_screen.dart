import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'video_player_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VideoListScreen extends StatefulWidget {
  const VideoListScreen({super.key});

  @override
  _VideoListScreenState createState() => _VideoListScreenState();
}

class _VideoListScreenState extends State<VideoListScreen> {
  String selectedCategory = 'All';
  bool isGridView = false;
  bool showOnlyWatched = false;
  List<Map<String, dynamic>> allVideos = [];
  bool isLoading = true;
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    initPrefs();
  }

  Future<void> initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    isGridView = prefs.getBool('isGridView') ?? false;
    await fetchVideos();
  }

  Future<void> fetchVideos() async {
    try {
      final querySnapshot =
          await FirebaseFirestore.instance.collection('videos').get();

      final fetchedVideos =
          querySnapshot.docs.map((doc) {
            final data = doc.data();
            final docId = doc.id;
            final isWatched = prefs.getBool('watched_$docId') ?? false;

            return {
              'title': data['title'] ?? '',
              'shortDescription': data['shortDescription'] ?? '',
              'description': data['description'] ?? '',
              'url': data['url'] ?? '',
              'category': data['category'] ?? 'Uncategorized',
              'isWatched': isWatched,
              'docId': docId,
            };
          }).toList();

      setState(() {
        allVideos = fetchedVideos;
        isLoading = false;
      });
    } catch (e) {
      debugPrint('Error fetching videos: $e');
    }
  }

  List<Map<String, dynamic>> get filteredVideos {
    List<Map<String, dynamic>> videos = allVideos;
    if (selectedCategory != 'All') {
      videos =
          videos
              .where((video) => video['category'] == selectedCategory)
              .toList();
    }
    if (showOnlyWatched) {
      videos = videos.where((video) => video['isWatched']).toList();
    }
    return videos;
  }

  void _setCategory(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  void _markVideoAsWatched(String docId) async {
    await prefs.setBool('watched_$docId', true);
    setState(() {
      final index = allVideos.indexWhere((v) => v['docId'] == docId);
      if (index != -1) {
        allVideos[index]['isWatched'] = true;
      }
    });
  }

  void _toggleViewMode() async {
    setState(() {
      isGridView = !isGridView;
    });
    await prefs.setBool('isGridView', isGridView);
  }

  void _toggleWatchedFilter() {
    setState(() {
      showOnlyWatched = !showOnlyWatched;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'All Videos',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.white,
            shadows: [
              Shadow(
                color: Colors.black45,
                offset: Offset(0, 1),
                blurRadius: 4,
              ),
            ],
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder:
                  (child, animation) =>
                      RotationTransition(turns: animation, child: child),
              child: Icon(
                isGridView ? Icons.list : Icons.grid_view,
                key: ValueKey(isGridView),
              ),
            ),
            onPressed: _toggleViewMode,
          ),
          IconButton(
            icon: Icon(
              showOnlyWatched ? Icons.visibility : Icons.visibility_off,
              color: showOnlyWatched ? Colors.green : Colors.grey,
            ),
            onPressed: _toggleWatchedFilter,
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg2.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child:
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Wrap(
                          spacing: 10,
                          runSpacing: 6,
                          children: [
                            for (var category in [
                              'All',
                              'zikr'
                              'Tasawwuf',
                              'Auliya',
                              'Shariyath',
                              'Hadees',
                              'Hamd o Naat',
                            ])
                              ChoiceChip(
                                label: Text(
                                  category,
                                  style: TextStyle(
                                    color:
                                        selectedCategory == category
                                            ? Colors.white
                                            : Colors.black87,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                selected: selectedCategory == category,
                                onSelected: (_) => _setCategory(category),
                                selectedColor: Colors.deepPurple,
                                backgroundColor: Colors.white.withOpacity(0.8),
                                elevation: 2,
                                pressElevation: 4,
                              ),
                          ],
                        ),
                      ),
                      Expanded(
                        child:
                            isGridView
                                ? GridView.builder(
                                  padding: const EdgeInsets.all(5),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 1.0,
                                        mainAxisSpacing: 10,
                                        crossAxisSpacing: 5,
                                      ),
                                  itemCount: filteredVideos.length,
                                  itemBuilder: (ctx, i) {
                                    final video = filteredVideos[i];
                                    final videoId =
                                        YoutubePlayerController.convertUrlToId(
                                          video['url'],
                                        ) ??
                                        '';
                                    return GestureDetector(
                                      onTap: () {
                                        _markVideoAsWatched(video['docId']);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder:
                                                (_) => VideoPlayerScreen(
                                                  videoId: videoId,
                                                  title: video['title'],
                                                  shortDescription:
                                                      video['shortDescription'],
                                                  description:
                                                      video['description'],
                                                ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.9),
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black26,
                                              blurRadius: 6,
                                              offset: Offset(0, 4),
                                            ),
                                          ],
                                        ),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(
                                              0.9,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black26,
                                                blurRadius: 6,
                                                offset: Offset(0, 4),
                                              ),
                                            ],
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch ,
                                            children: [
                                              // Thumbnail Image
                                              ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.only(
                                                      topLeft: Radius.circular(
                                                        16,
                                                      ),
                                                      topRight: Radius.circular(
                                                        16,
                                                      ),
                                                    ),
                                                child: Image.network(
                                                  'https://img.youtube.com/vi/$videoId/0.jpg',
                                                  height: 90,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),

                                              // Text + Description + Icon
                                              Expanded(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                    8.0,
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      // Title
                                                      Text(
                                                        video['title'],
                                                        maxLines: 1,
                                                        overflow:
                                                            TextOverflow
                                                                .ellipsis,
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      const SizedBox(height: 4),

                                                      // Short Description
                                                      Text(
                                                        video['shortDescription'],
                                                        maxLines: 2,
                                                        overflow:
                                                            TextOverflow
                                                                .ellipsis,
                                                        style: const TextStyle(
                                                          fontSize: 13,
                                                        ),
                                                      ),

                                                      // Push icon to bottom
                                                      const Spacer(),

                                                      // Watched Icon
                                                      Align(
                                                        alignment:
                                                            Alignment
                                                                .centerRight,
                                                        child: Icon(
                                                          video['isWatched']
                                                              ? Icons.visibility
                                                              : Icons
                                                                  .visibility_off,
                                                          color:
                                                              video['isWatched']
                                                                  ? Colors.green
                                                                  : Colors.grey,
                                                          size: 18,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                )
                                : ListView.builder(
                                  itemCount: filteredVideos.length,
                                  itemBuilder: (ctx, i) {
                                    final video = filteredVideos[i];
                                    final videoId =
                                        YoutubePlayerController.convertUrlToId(
                                          video['url'],
                                        ) ??
                                        '';
                                    return GestureDetector(
                                      onTap: () {
                                        _markVideoAsWatched(video['docId']);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder:
                                                (_) => VideoPlayerScreen(
                                                  videoId: videoId,
                                                  title: video['title'],
                                                  shortDescription:
                                                      video['shortDescription'],
                                                  description:
                                                      video['description'],
                                                ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 7,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.9),
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(
                                                0.08,
                                              ),
                                              blurRadius: 8,
                                              offset: Offset(0, 4),
                                            ),
                                          ],
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: IntrinsicHeight(
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  child: Image.network(
                                                    'https://img.youtube.com/vi/$videoId/0.jpg',
                                                    width: 100,
                                                    height: 70,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        video['title'],
                                                        maxLines: 1,
                                                        overflow:
                                                            TextOverflow
                                                                .ellipsis,
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                      const SizedBox(height: 4),
                                                      Text(
                                                        video['shortDescription'],
                                                        maxLines: 2,
                                                        overflow:
                                                            TextOverflow
                                                                .ellipsis,
                                                        style: const TextStyle(
                                                          fontSize: 13,
                                                          color: Colors.black87,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(width: 8),
                                                Icon(
                                                  video['isWatched']
                                                      ? Icons.visibility
                                                      : Icons.visibility_off,
                                                  color:
                                                      video['isWatched']
                                                          ? Colors.green
                                                          : Colors.grey,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                      ),
                    ],
                  ),
        ),
      ),
    );
  }
}
