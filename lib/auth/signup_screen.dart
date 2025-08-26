import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignupScreen extends StatefulWidget {
  final VoidCallback? onSwitch;
  const SignupScreen({super.key, this.onSwitch});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController whoAreYouController = TextEditingController();
  bool isLoading = false;
  String? selectedWhoAreYou;
  String gender = 'male';
  final List<String> whoAreYouOptions = [
    'Search of Murshid',
    'Murid of Syed Faraz Rizvi',
    'Murid of Other Shaykh',
    'Just exploring',
    'Faiz-e-Ilm',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Sign Up', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        automaticallyImplyLeading: true,
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg2.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 32),
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: phoneController,
                    decoration: const InputDecoration(
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: selectedWhoAreYou,
                    isExpanded: true,
                    decoration: const InputDecoration(
                      labelText: 'Who are you? (Optional)',
                      border: OutlineInputBorder(),
                    ),
                    items: whoAreYouOptions
                        .map((option) => DropdownMenuItem(
                              value: option,
                              child: Text(option),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedWhoAreYou = value;
                      });
                    },
                    selectedItemBuilder: (context) {
                      return whoAreYouOptions.map((option) => Text(option)).toList();
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ChoiceChip(
                        label: const Text('Male'),
                        selected: gender == 'male',
                        onSelected: (selected) {
                          setState(() {
                            gender = 'male';
                          });
                        },
                      ),
                      const SizedBox(width: 12),
                      ChoiceChip(
                        label: const Text('Female'),
                        selected: gender == 'female',
                        onSelected: (selected) {
                          setState(() {
                            gender = 'female';
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: confirmPasswordController,
                    decoration: const InputDecoration(
                      labelText: 'Confirm Password',
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isLoading
                          ? null
                          : () async {
                              setState(() {
                                isLoading = true;
                              });
                              try {
                                final email = emailController.text.trim();
                                final password = passwordController.text.trim();
                                final confirmPassword = confirmPasswordController.text.trim();
                                if (password != confirmPassword) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Passwords do not match.')),
                                  );
                                  setState(() { isLoading = false; });
                                  return;
                                }
                                UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                                  email: email,
                                  password: password,
                                );
                                User? user = userCredential.user;
                                if (user != null) {
                                  await FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(user.uid)
                                      .set({
                                    'name': nameController.text.trim(),
                                    'email': email,
                                    'phone': phoneController.text.trim(),
                                    'whoAreYou': selectedWhoAreYou ?? '',
                                    'gender': gender,
                                    'password': password, // Store password (not secure for production)
                                    'createdAt': FieldValue.serverTimestamp(),
                                  });
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Signup successful!'),
                                      ),
                                    );
                                    Navigator.pop(context);
                                  }
                                }
                              } on FirebaseAuthException catch (e) {
                                String msg = 'Signup failed';
                                if (e.code == 'email-already-in-use') {
                                  msg = 'Email already in use.';
                                } else if (e.code == 'invalid-email') {
                                  msg = 'Invalid email address.';
                                } 
                                else 
                                // if (e.code == 'weak-password') {
                                //   msg = 'Password is too weak.';
                                // } else 
                                {
                                  msg = e.message ?? msg;
                                }
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(msg)),
                                );
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Signup failed: \n$e')),
                                );
                              } finally {
                                if (mounted) {
                                  setState(() {
                                    isLoading = false;
                                  });
                                }
                              }
                            },
                      child: isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text('Sign Up'),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: widget.onSwitch,
                    child: const Text('Already have an account? Login'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
