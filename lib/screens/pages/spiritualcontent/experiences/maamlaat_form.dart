
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

void showMaamlaatForm(BuildContext context) {

  final nameController = TextEditingController();
  final maamlaatController = TextEditingController();
  bool isSubmitting = false;
  final user = FirebaseAuth.instance.currentUser;
  bool isUserLoggedIn = user != null;

  final now = DateTime.now();
  final formattedDate = DateFormat('dd MMM yyyy, hh:mm a').format(now);

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 60),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.85),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  padding: EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '🕊️ Apne Roohani Maamlaat Batayen',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '📅 $formattedDate',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[700],
                          ),
                        ),
                        SizedBox(height: 16),
                        isUserLoggedIn
                            ? FutureBuilder<DocumentSnapshot>(
                                future: FirebaseFirestore.instance.collection('users').doc(user.uid).get(),
                                builder: (context, snapshot) {
                                  String autoName = '';
                                  if (snapshot.hasData && snapshot.data!.exists && snapshot.data!.data() != null && (snapshot.data!.data() as Map<String, dynamic>)['name'] != null && ((snapshot.data!.data() as Map<String, dynamic>)['name'] as String).isNotEmpty) {
                                    autoName = (snapshot.data!.data() as Map<String, dynamic>)['name'];
                                  } else if (user.displayName != null && user.displayName!.isNotEmpty) {
                                    autoName = user.displayName!;
                                  } else if (user.email != null && user.email!.isNotEmpty) {
                                    autoName = user.email!;
                                  }
                                  nameController.text = autoName;
                                  return TextField(
                                    controller: nameController,
                                    decoration: InputDecoration(
                                      labelText: autoName,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    readOnly: true,
                                  );
                                },
                              )
                            : TextField(
                                controller: nameController,
                                decoration: InputDecoration(
                                  labelText: 'Name',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                        SizedBox(height: 16),
                        TextField(
                          controller: maamlaatController,
                          decoration: InputDecoration(
                            labelText: 'Maamlaat',
                            hintText: 'Apne roohani halat, waqeaat likhiye...',
                            alignLabelWithHint: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          maxLines: 10,
                          minLines: 6,
                          keyboardType: TextInputType.multiline,
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              child: Text('Cancel'),
                              onPressed: () => Navigator.pop(context),
                            ),
                            SizedBox(width: 12),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black87,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed:
                                  isSubmitting
                                      ? null
                                      : () async {
                                        final name = nameController.text.trim();
                                        final maamlaat =
                                            maamlaatController.text.trim();

                                        if (name.isEmpty || maamlaat.isEmpty) {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                "Name and Maamlaat cannot be empty",
                                              ),
                                              duration: Duration(seconds: 2),
                                            ),
                                          );
                                          return;
                                        }

                                        setState(() {
                                          isSubmitting = true;
                                        });

                                        try {
                                          String? emailToStore;
                                          final user = FirebaseAuth.instance.currentUser;
                                          if (user != null && user.email != null && user.email!.isNotEmpty) {
                                            emailToStore = user.email;
                                          }
                                          await FirebaseFirestore.instance
                                              .collection('maamlaat')
                                              .add({
                                                'date': Timestamp.now(),
                                                'name': name,
                                                'email': emailToStore ?? '',
                                                'maamlaat': maamlaat,
                                                'status': 'unanswered',
                                                'public': true,
                                                'reply1': '',
                                                'reply1By': '',
                                                'reply1Date': null,
                                                'reply2': '',
                                                'reply2By': '',
                                                'reply2Date': null,
                                                'reply3': '',
                                                'reply3By': '',
                                                'reply3Date': null,
                                              });

                                          if (context.mounted) {
                                            Navigator.pop(context);
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  "Maamlaat submitted successfully",
                                                ),
                                                duration: Duration(seconds: 3),
                                              ),
                                            );
                                          }
                                        } catch (e) {
                                          if (context.mounted) {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: Text("Error: $e"),
                                                duration: Duration(seconds: 3),
                                              ),
                                            );
                                          }
                                        } finally {
                                          setState(() {
                                            isSubmitting = false;
                                          });
                                        }
                                      },
                              child:
                                  isSubmitting
                                      ? SizedBox(
                                        width: 16,
                                        height: 16,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: Colors.white,
                                        ),
                                      )
                                      : Text('Submit'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
    },
  );
}
