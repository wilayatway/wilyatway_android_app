import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:flutter/services.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String videoId;
  final String title;
  final String shortDescription;
  final String description;

  const VideoPlayerScreen({
    super.key,
    required this.videoId,
    required this.title,
    required this.shortDescription,
    required this.description,
  });

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen>
    with TickerProviderStateMixin {
  late YoutubePlayerController _controller;
  final List<Map<String, String>> discussions = [
    {'name': 'Ahmed', 'message': 'SubhanAllah! Very informative 💫'},
    {'name': 'Fatima', 'message': 'BarakAllah! JazakAllah khair 🙏'},
    {'name': 'Zaid', 'message': 'Beautiful explanation of Tasawwuf.'},
  ];

  final TextEditingController nameController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController.fromVideoId(
      videoId: widget.videoId,
      autoPlay: true,
      params: const YoutubePlayerParams(
        showControls: true,
        enableJavaScript: true,
        showFullscreenButton: true,
        playsInline: true,
      ),
    );

    _tabController = TabController(length: 2, vsync: this);
  }

  void _addDiscussion() {
    final name = nameController.text.trim();
    final msg = messageController.text.trim();
    if (name.isEmpty || msg.isEmpty) return;

    setState(() {
      discussions.add({'name': name, 'message': msg});
      nameController.clear();
      messageController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerScaffold(
      controller: _controller,
      aspectRatio: 16 / 9,
      builder: (context, player) {
        return Scaffold(
          appBar: AppBar(title: const Text('Video Player')),
          body: Column(
            children: [
              player,
              TabBar(
                controller: _tabController,
                labelColor: Colors.deepPurple,
                unselectedLabelColor: Colors.grey,
                indicatorColor: Colors.deepPurple,
                tabs: const [Tab(text: 'Description'), Tab(text: 'Discussion')],
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    // Description Tab
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.title,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              widget.shortDescription,
                              style: const TextStyle(
                                fontStyle: FontStyle.italic,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              widget.description,
                              style: const TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Discussion Tab
                    Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.all(12),
                            itemCount: discussions.length,
                            itemBuilder: (ctx, i) {
                              final msg = discussions[i];
                              return Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "${msg['name']}: ",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 14,
                                        ),
                                      ),
                                      TextSpan(
                                        text: msg['message'],
                                        style: const TextStyle(
                                          color: Colors.black87,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                          color: const Color.fromARGB(255, 255, 255, 255),
                          child: Column(
                            children: [
                              TextField(
                                controller: nameController,
                                decoration: const InputDecoration(
                                  hintText: 'Your Name',
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 8,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      controller: messageController,
                                      decoration: const InputDecoration(
                                        hintText: 'Enter your message...',
                                        border: OutlineInputBorder(),
                                        contentPadding: EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 8,
                                        ),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.send,
                                      color: Color.fromARGB(255, 1, 168, 45),
                                    ),
                                    onPressed: _addDiscussion,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.close();
    _tabController.dispose();
    nameController.dispose();
    messageController.dispose();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }
}
