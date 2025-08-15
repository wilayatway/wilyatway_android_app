import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart'
    show PhotoViewComputedScale, PhotoViewHeroAttributes;
import 'package:photo_view/photo_view_gallery.dart';

class FullScreenGallery extends StatefulWidget {
  final List<String> images;
  final int initialIndex;

  const FullScreenGallery({
    super.key,
    required this.images,
    required this.initialIndex,
  });

  @override
  State<FullScreenGallery> createState() => _FullScreenGalleryState();
}

class _FullScreenGalleryState extends State<FullScreenGallery> {
  late PageController pageController;
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
    pageController = PageController(initialPage: currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset('assets/images/bg2.png', fit: BoxFit.cover),
          ),
          // Dark overlay
          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.5)),
          ),
          SafeArea(
            child: Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: PhotoViewGallery.builder(
                        pageController: pageController,
                        itemCount: widget.images.length,
                        builder: (context, index) {
                          return PhotoViewGalleryPageOptions(
                            imageProvider: CachedNetworkImageProvider(
                              widget.images[index],
                            ),
                            heroAttributes: PhotoViewHeroAttributes(
                              tag: widget.images[index],
                            ),
                            minScale: PhotoViewComputedScale.contained,
                            maxScale: PhotoViewComputedScale.covered * 3,
                          );
                        },
                        onPageChanged: (index) {
                          setState(() {
                            currentIndex = index;
                          });
                        },
                        backgroundDecoration: const BoxDecoration(
                          color:
                              Colors
                                  .transparent, // keep background image visible
                        ),
                        scrollPhysics: const BouncingScrollPhysics(),
                      ),
                    ),
                    SizedBox(
                      height: 70,
                      child: Container(
                        color: Colors.black.withOpacity(0.6),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.images.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                pageController.jumpToPage(index);
                              },
                              child: Container(
                                margin: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color:
                                        currentIndex == index
                                            ? Colors.white
                                            : Colors.transparent,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: CachedNetworkImage(
                                    imageUrl: widget.images[index],
                                    fit: BoxFit.cover,
                                    width: 60,
                                    height: 60,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: 10,
                  left: 10,
                  child: CircleAvatar(
                    backgroundColor: Colors.black54,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
