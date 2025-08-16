import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MurshidGalleryPage extends StatefulWidget {
  const MurshidGalleryPage({super.key});

  @override
  State<MurshidGalleryPage> createState() => _MurshidGalleryPageState();
}

class _MurshidGalleryPageState extends State<MurshidGalleryPage> {
  bool showAlbums = true;

  Future<List<Map<String, dynamic>>> fetchImages() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('gallery').get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background image
        Image.asset(
          'assets/images/bg2.png',
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text('Murshid Gallery'),
            backgroundColor: Colors.black.withOpacity(0.3),
            elevation: 0,
          ),
          body: FutureBuilder<List<Map<String, dynamic>>>(
            future: fetchImages(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final allImages = snapshot.data!;
              final categories =
                  allImages
                      .map((e) => e['category'] as String)
                      .toSet()
                      .toList();

              return Column(
                children: [
                  // Add space so toggle is below AppBar
                  // SizedBox(
                  //   height: kToolbarHeight + MediaQuery.of(context).padding.top,
                  // ),

                  // Samsung-style toggle
                  Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      // color: Colors.white.withOpacity(0.25),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => showAlbums = true),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color:
                                    showAlbums
                                        ? Colors.white.withOpacity(0.9)
                                        : Colors.transparent,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              alignment: Alignment.center,
                              child: const Text(
                                "Albums",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => showAlbums = false),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color:
                                    !showAlbums
                                        ? Colors.white.withOpacity(0.9)
                                        : Colors.transparent,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              alignment: Alignment.center,
                              child: const Text(
                                "Pictures",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Main content
                  Expanded(
                    child:
                        showAlbums
                            ? buildAlbumsView(categories, allImages)
                            : buildPicturesView(allImages),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget buildAlbumsView(
    List<String> categories,
    List<Map<String, dynamic>> allImages,
  ) {
    return GridView.builder(
      padding: const EdgeInsets.all(12), // More padding for breathing space
      itemCount: categories.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // 2 folders per row
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        final category = categories[index];
        final firstImage =
            allImages.firstWhere((img) => img['category'] == category)['url']
                as String;

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (_) => AlbumDetailPage(
                      category: category,
                      images:
                          allImages
                              .where((img) => img['category'] == category)
                              .toList(),
                    ),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), // Rounded corners
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 6,
                  offset: const Offset(2, 2),
                ),
              ],
            ),
            clipBehavior: Clip.hardEdge, // Ensure image follows border radius
            child: Stack(
              fit: StackFit.expand,
              children: [
                CachedNetworkImage(
                  imageUrl: firstImage,
                  fit: BoxFit.cover,
                  placeholder:
                      (context, url) =>
                          Container(color: Colors.grey.withOpacity(0.3)),
                ),
                Container(
                  color: Colors.black.withOpacity(0.35),
                  alignment: Alignment.bottomCenter,
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    category,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildPicturesView(List<Map<String, dynamic>> images) {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: images.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // 3 per row for normal pictures
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
      ),
      itemBuilder: (context, index) {
        final img = images[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (_) => FullScreenImageViewer(
                      images: images,
                      initialIndex: index,
                    ),
              ),
            );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: img['url'],
              fit: BoxFit.cover,
              placeholder:
                  (context, url) =>
                      Container(color: Colors.grey.withOpacity(0.3)),
            ),
          ),
        );
      },
    );
  }
}

class AlbumDetailPage extends StatelessWidget {
  final String category;
  final List<Map<String, dynamic>> images;

  const AlbumDetailPage({
    super.key,
    required this.category,
    required this.images,
  });

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
            title: Text(category),
            backgroundColor: Colors.black.withOpacity(0.3),
          ),
          body: GridView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: images.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
            ),
            itemBuilder: (context, index) {
              final img = images[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (_) => FullScreenImageViewer(
                            images: images,
                            initialIndex: index,
                          ),
                    ),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    imageUrl: img['url'],
                    fit: BoxFit.cover,
                    placeholder:
                        (context, url) =>
                            Container(color: Colors.grey.withOpacity(0.3)),
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

class FullScreenImageViewer extends StatefulWidget {
  final List<Map<String, dynamic>> images;
  final int initialIndex;

  const FullScreenImageViewer({
    super.key,
    required this.images,
    required this.initialIndex,
  });

  @override
  State<FullScreenImageViewer> createState() => _FullScreenImageViewerState();
}

class _FullScreenImageViewerState extends State<FullScreenImageViewer> {
  late PageController _pageController;
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background image
        Positioned.fill(
          child: Image.asset('assets/images/bg2.png', fit: BoxFit.cover),
        ),

        // Dark overlay for readability
        Positioned.fill(child: Container(color: Colors.black.withOpacity(0.5))),

        // Fullscreen images
        PageView.builder(
          controller: _pageController,
          itemCount: widget.images.length,
          onPageChanged: (index) => setState(() => currentIndex = index),
          itemBuilder: (context, index) {
            final img = widget.images[index];
            return Center(
              child: CachedNetworkImage(
                imageUrl: img['url'],
                fit: BoxFit.contain,
              ),
            );
          },
        ),

        // Back button
        Positioned(
          top: MediaQuery.of(context).padding.top + 10,
          left: 10,
          child: CircleAvatar(
            backgroundColor: Colors.black.withOpacity(0.5),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),

        // Samsung-style bottom thumbnails
        Positioned(
          bottom: 10,
          left: 0,
          right: 0,
          child: SizedBox(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.images.length,
              itemBuilder: (context, index) {
                final img = widget.images[index];
                return GestureDetector(
                  onTap: () {
                    _pageController.jumpToPage(index);
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color:
                            index == currentIndex
                                ? Colors.blue
                                : Colors.transparent,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: CachedNetworkImage(
                        imageUrl: img['url'],
                        width: 60, // made bigger so user can see better
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
