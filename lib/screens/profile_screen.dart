import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../services/auth_service.dart';
import '../services/firestore_service.dart';
import '../theme/app_theme.dart';
import 'login_screen.dart';
import 'edit_profile_screen.dart';
import 'settings_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() =>
      _ProfileScreenState();
}

class _ProfileScreenState
    extends State<ProfileScreen> {

  final AuthService authService =
  AuthService();

  final FirestoreService firestoreService =
  FirestoreService();

  final User? currentUser =
      FirebaseAuth.instance.currentUser;

  Future<void> logout() async {

    await authService.signOut();

    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => const LoginScreen(),
      ),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(

      future: firestoreService.getUserData(
        currentUser!.uid,
      ),

      builder: (context, snapshot) {

        if (snapshot.connectionState ==
            ConnectionState.waiting) {

          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (!snapshot.hasData ||
            snapshot.data!.data() == null) {

          return const Scaffold(
            body: Center(
              child: Text('No User Data'),
            ),
          );
        }

        Map<String, dynamic> userData =
        snapshot.data!.data()!;

        return Scaffold(

          backgroundColor:
          const Color(0xFFF8F4FF),

          body: SafeArea(

            child: SingleChildScrollView(

              child: Column(

                children: [

                  const SizedBox(height: 16),

                  // TOP PROFILE CARD
                  Padding(

                    padding:
                    const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),

                    child: Container(

                      width: double.infinity,

                      padding:
                      const EdgeInsets.all(20),

                      decoration: BoxDecoration(
                        color:
                        const Color(0xFFEDE9FE),
                        borderRadius:
                        BorderRadius.circular(26),
                      ),

                      child: Column(

                        children: [

                          Row(

                            mainAxisAlignment:
                            MainAxisAlignment.end,

                            children: [

                              IconButton(

                                onPressed: () {

                                  Navigator.push(

                                    context,

                                    MaterialPageRoute(

                                      builder: (_) =>
                                      const SettingsScreen(),
                                    ),
                                  );
                                },

                                icon: const Icon(
                                  Icons.settings_outlined,
                                  color: AppColors.textGrey,
                                ),
                              ),
                            ],
                          ),

                          // Avatar
                          Container(

                            width: 92,
                            height: 92,

                            decoration: BoxDecoration(

                              borderRadius:
                              BorderRadius.circular(26),

                              gradient:
                              const LinearGradient(
                                colors: [
                                  Color(0xFFFBBF24),
                                  Color(0xFFF59E0B),
                                ],
                              ),

                              boxShadow: [

                                BoxShadow(
                                  color: Colors.black
                                      .withValues(
                                      alpha: 0.08),
                                  blurRadius: 12,
                                  offset:
                                  const Offset(0, 4),
                                ),
                              ],
                            ),

                            child: const Icon(
                              Icons.face_rounded,
                              color: Colors.white,
                              size: 52,
                            ),
                          ),

                          const SizedBox(height: 18),

                          Text(

                            userData['fullName'] ?? '',

                            textAlign: TextAlign.center,

                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight:
                              FontWeight.w700,
                              color:
                              AppColors.textDark,
                            ),
                          ),

                          const SizedBox(height: 4),

                          Text(

                            userData['email'] ?? '',

                            style: const TextStyle(
                              fontSize: 13,
                              color:
                              AppColors.textGrey,
                            ),
                          ),

                          const SizedBox(height: 14),

                          Wrap(

                            spacing: 8,
                            runSpacing: 8,
                            alignment:
                            WrapAlignment.center,

                            children: [

                              _buildTag(
                                'Bangladesh Army University of Science & Technology',
                                const Color(0xFFC4B5FD),
                                const Color(0xFF7C3AED),
                              ),

                              _buildTag(
                                'Computer Science & Engineering',
                                const Color(0xFFBFDBFE),
                                const Color(0xFF2563EB),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // PERSONAL INFO CARD
                  Padding(

                    padding:
                    const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),

                    child: Container(

                      width: double.infinity,

                      padding:
                      const EdgeInsets.all(22),

                      decoration: BoxDecoration(
                        color:
                        const Color(0xFFEDE9FE),
                        borderRadius:
                        BorderRadius.circular(26),
                      ),

                      child: Column(

                        crossAxisAlignment:
                        CrossAxisAlignment.start,

                        children: [

                          Row(

                            children: [

                              const Text(

                                'Personal Information',

                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight:
                                  FontWeight.w700,
                                  color: Color(
                                      0xFF7C3AED),
                                ),
                              ),

                              const Spacer(),

                              OutlinedButton.icon(

                                onPressed: () {

                                  Navigator.push(

                                    context,

                                    MaterialPageRoute(

                                      builder: (_) =>
                                          EditProfileScreen(
                                            userData: userData,
                                          ),
                                    ),
                                  );
                                },

                                icon: const Icon(
                                  Icons.edit_outlined,
                                  size: 14,
                                  color:
                                  Color(0xFF7C3AED),
                                ),

                                label: const Text(

                                  'Edit',

                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight:
                                    FontWeight.w600,
                                    color: Color(
                                        0xFF7C3AED),
                                  ),
                                ),

                                style:
                                OutlinedButton
                                    .styleFrom(

                                  side:
                                  const BorderSide(
                                    color: Color(
                                        0xFF7C3AED),
                                  ),

                                  shape:
                                  RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius
                                        .circular(
                                        12),
                                  ),

                                  padding:
                                  const EdgeInsets
                                      .symmetric(
                                    horizontal: 14,
                                    vertical: 10,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 22),

                          _buildInfoTile(
                            icon:
                            Icons.person_outline,
                            title: 'Full name',
                            value:
                            userData['fullName']
                                ?? '',
                          ),

                          _divider(),

                          _buildInfoTile(
                            icon:
                            Icons.email_outlined,
                            title: 'Email',
                            value:
                            userData['email']
                                ?? '',
                          ),

                          _divider(),

                          _buildInfoTile(
                            icon:
                            Icons.badge_outlined,
                            title: 'Student ID',
                            value:
                            userData['studentId']
                                ?? '',
                          ),

                          _divider(),

                          _buildInfoTile(
                            icon:
                            Icons.phone_outlined,
                            title:
                            'Phone Number',
                            value:
                            userData['phone']
                                ?? '',
                          ),

                          _divider(),

                          _buildInfoTile(
                            icon:
                            Icons.star_outline,
                            title:
                            'Major Subject',
                            value:
                            'Computer Science & Engineering',
                          ),

                          _divider(),

                          _buildInfoTile(
                            icon: Icons
                                .account_balance_outlined,
                            title: 'University',
                            value:
                            'Bangladesh Army University of Science & Technology',
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 22),

                  // LOGOUT BUTTON
                  Padding(

                    padding:
                    const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),

                    child: SizedBox(

                      width: double.infinity,
                      height: 56,

                      child: ElevatedButton.icon(

                        onPressed: logout,

                        icon: const Icon(
                          Icons
                              .power_settings_new_rounded,
                          color: Colors.white,
                          size: 22,
                        ),

                        label: const Text(

                          'Log Out',

                          style: TextStyle(
                            fontSize: 17,
                            fontWeight:
                            FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),

                        style:
                        ElevatedButton.styleFrom(
                          backgroundColor:
                          const Color(0xFFEF4444),

                          elevation: 0,

                          shape:
                          RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(
                                16),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 26),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTag(
      String text,
      Color bg,
      Color fg,
      ) {

    return Container(

      padding:
      const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),

      decoration: BoxDecoration(
        color: bg,
        borderRadius:
        BorderRadius.circular(20),
      ),

      child: Text(

        text,

        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: fg,
        ),
      ),
    );
  }

  Widget _buildInfoTile({

    required IconData icon,
    required String title,
    required String value,

  }) {

    return Padding(

      padding:
      const EdgeInsets.symmetric(
        vertical: 12,
      ),

      child: Row(

        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [

          Icon(
            icon,
            size: 20,
            color: const Color(0xFF7C3AED),
          ),

          const SizedBox(width: 14),

          Expanded(

            child: Column(

              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [

                Text(

                  title,

                  style: const TextStyle(
                    fontSize: 12,
                    color:
                    AppColors.textGrey,
                  ),
                ),

                const SizedBox(height: 4),

                Text(

                  value,

                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight:
                    FontWeight.w500,
                    color:
                    AppColors.textDark,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() {

    return const Divider(
      thickness: 1,
      height: 1,
      color: Color(0xFFD8B4FE),
    );
  }
}