import 'package:flutter/material.dart';
import 'package:wilayat_way_apk/models/Task.dart';

class TaskDetailScreen extends StatefulWidget {
  final Task task;
  const TaskDetailScreen({super.key, required this.task});

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  String selectedLang = 'roman_urdu';

  @override
  Widget build(BuildContext context) {
    final task = widget.task;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(task.heading, style: const TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg2.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
         child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height - kToolbarHeight,
              ),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: ToggleButtons(
                        isSelected: [
                          selectedLang == 'english',
                          selectedLang == 'urdu',
                          selectedLang == 'roman_urdu',
                        ],
                        onPressed: (index) {
                          setState(() {
                            selectedLang =
                                ['english', 'urdu', 'roman_urdu'][index];
                          });
                        },
                        borderRadius: BorderRadius.circular(12),
                        selectedColor: Colors.white,
                        fillColor: const Color.fromARGB(255, 80, 78, 84),
                        color: const Color.fromARGB(255, 0, 0, 0),
                        children: const [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Text('English'),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Text('Urdu'),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Text('Roman Urdu'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      task.description[selectedLang] ?? '',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily:
                            selectedLang == 'english'
                                ? 'Roboto'
                                : 'UthmanArabic',
                        height: 1.6,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 24),
                    if (task.imageUrl.isNotEmpty)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          task.imageUrl,
                          width: double.infinity,
                          fit: BoxFit.contain,
                          errorBuilder:
                              (context, error, stackTrace) => const Text(
                                'Image failed to load.',
                                style: TextStyle(color: Colors.red),
                              ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
