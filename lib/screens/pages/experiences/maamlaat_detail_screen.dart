import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MaamlaatDetailScreen extends StatelessWidget {
  final String docId;

  const MaamlaatDetailScreen({super.key, required this.docId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // to let background cover app bar
      appBar: AppBar(
        title: Text('Maamlaat Details'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset('assets/images/bg2.png', fit: BoxFit.cover),
          ),
          // Content
          FutureBuilder<DocumentSnapshot>(
            future:
                FirebaseFirestore.instance
                    .collection('maamlaat')
                    .doc(docId)
                    .get(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }

              var doc = snapshot.data!;
              bool hasReplies =
                  (doc['reply1']?.toString().trim().isNotEmpty ?? false) ||
                  (doc['reply2']?.toString().trim().isNotEmpty ?? false) ||
                  (doc['reply3']?.toString().trim().isNotEmpty ?? false);

              return Padding(
                padding: EdgeInsets.fromLTRB(16, 100, 16, 16),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,

                    children: [
                      // Maamlaat Message (left-aligned like WhatsApp)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.85),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(color: Colors.black26, blurRadius: 5),
                            ],
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  doc['name'] ?? 'Unknown Name',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  doc['maamlaat'] ?? 'No description',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black87,
                                  ),
                                ),
                                SizedBox(height: 6),
                                Text(
                                  'Date: ${_formatDate(doc['date'])}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),

                      // Replies (if any)
                      if (doc['reply1']?.toString().trim().isNotEmpty ?? false)
                        _buildReply(
                          doc['reply1'],
                          doc['reply1By'] ?? 'Unknown',
                          doc['reply1Date'],
                        ),
                      if (doc['reply2']?.toString().trim().isNotEmpty ?? false)
                        _buildReply(
                          doc['reply2'],
                          doc['reply2By'] ?? 'Unknown',
                          doc['reply2Date'],
                        ),
                      if (doc['reply3']?.toString().trim().isNotEmpty ?? false)
                        _buildReply(
                          doc['reply3'],
                          doc['reply3By'] ?? 'Unknown',
                          doc['reply3Date'],
                        ),

                      if (!hasReplies)
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 32),
                            child: Text(
                              'Unanswered',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.red.shade700,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  /// Reply bubble on the right side
  Widget _buildReply(String replyText, String repliedBy, dynamic replyDate) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.green.shade700.withOpacity(0.9),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5)],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                replyText,
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              SizedBox(height: 6),
              Text(
                'Replied by: ${_getString(repliedBy)}',
                style: TextStyle(fontSize: 12, color: Colors.white70),
              ),
              Text(
                'Date: ${_formatDate(replyDate)}',
                style: TextStyle(fontSize: 12, color: Colors.white70),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getString(dynamic value) {
    if (value is String) {
      return value;
    } else if (value is int) {
      return value.toString();
    } else {
      return 'Unknown';
    }
  }

  String _formatDate(dynamic timestamp) {
    try {
      if (timestamp is Timestamp) {
        return timestamp.toDate().toString();
      } else if (timestamp is DateTime) {
        return timestamp.toString();
      } else {
        return 'Unknown date';
      }
    } catch (_) {
      return 'Invalid date';
    }
  }
}
