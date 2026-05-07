import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../services/auth_service.dart';
import '../theme/app_theme.dart';
import 'login_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() =>
      _SettingsScreenState();
}

class _SettingsScreenState
    extends State<SettingsScreen> {

  final AuthService authService =
  AuthService();

  bool notificationsEnabled = true;

  Future<void> logout() async {

    await authService.signOut();

    if (!mounted) return;

    Navigator.pushAndRemoveUntil(

      context,

      MaterialPageRoute(
        builder: (_) =>
        const LoginScreen(),
      ),

          (route) => false,
    );
  }

  Future<void> changePassword() async {

    try {

      await FirebaseAuth.instance
          .sendPasswordResetEmail(

        email:
        FirebaseAuth.instance
            .currentUser!
            .email!,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(

          content: Text(
            'Password reset email sent',
          ),
        ),
      );

    } catch (e) {

      ScaffoldMessenger.of(context)
          .showSnackBar(

        SnackBar(
          content: Text(
            'Error: $e',
          ),
        ),
      );
    }
  }

  void showAboutApp() {

    showAboutDialog(

      context: context,

      applicationName: 'AssignUp',

      applicationVersion: '1.0.0',

      applicationIcon: const Icon(
        Icons.menu_book_rounded,
        color: Color(0xFF7C3AED),
        size: 36,
      ),

      children: const [

        SizedBox(height: 10),

        Text(
          'AssignUp is a smart class & assignment tracker app designed for students.',
        ),
      ],
    );
  }

  void showPrivacyPolicy() {

    showDialog(

      context: context,

      builder: (_) {

        return AlertDialog(

          title: const Text(
            'Privacy Policy',
          ),

          content: const SingleChildScrollView(

            child: Text(

              'AssignUp securely stores your academic information using Firebase services. Your personal data is never shared with third parties.',
            ),
          ),

          actions: [

            TextButton(

              onPressed: () {
                Navigator.pop(context);
              },

              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
      const Color(0xFFF8F4FF),

      appBar: AppBar(

        backgroundColor:
        const Color(0xFFF8F4FF),

        elevation: 0,

        title: const Text(

          'Settings',

          style: TextStyle(
            color: AppColors.textDark,
            fontWeight: FontWeight.w700,
          ),
        ),

        iconTheme: const IconThemeData(
          color: AppColors.textDark,
        ),
      ),

      body: Padding(

        padding:
        const EdgeInsets.all(20),

        child: Column(

          children: [

            // NOTIFICATION
            _buildTile(

              icon:
              Icons.notifications_outlined,

              title: 'Notifications',

              trailing: Switch(

                value:
                notificationsEnabled,

                activeColor:
                const Color(0xFF7C3AED),

                onChanged: (value) {

                  setState(() {

                    notificationsEnabled =
                        value;
                  });
                },
              ),
            ),

            const SizedBox(height: 14),

            // CHANGE PASSWORD
            _buildTile(

              icon:
              Icons.lock_outline,

              title: 'Change Password',

              onTap: changePassword,
            ),

            const SizedBox(height: 14),

            // ABOUT APP
            _buildTile(

              icon:
              Icons.info_outline,

              title: 'About App',

              onTap: showAboutApp,
            ),

            const SizedBox(height: 14),

            // PRIVACY POLICY
            _buildTile(

              icon:
              Icons.privacy_tip_outlined,

              title: 'Privacy Policy',

              onTap: showPrivacyPolicy,
            ),

            const Spacer(),

            // LOGOUT BUTTON
            SizedBox(

              width: double.infinity,
              height: 56,

              child: ElevatedButton.icon(

                onPressed: logout,

                icon: const Icon(
                  Icons.logout_rounded,
                  color: Colors.white,
                ),

                label: const Text(

                  'Log Out',

                  style: TextStyle(
                    fontSize: 16,
                    fontWeight:
                    FontWeight.w600,
                    color: Colors.white,
                  ),
                ),

                style:
                ElevatedButton.styleFrom(

                  backgroundColor:
                  const Color(0xFFEF4444),

                  shape:
                  RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(
                        16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTile({

    required IconData icon,
    required String title,

    Widget? trailing,

    VoidCallback? onTap,

  }) {

    return Material(

      color: Colors.white,

      borderRadius:
      BorderRadius.circular(18),

      child: InkWell(

        borderRadius:
        BorderRadius.circular(18),

        onTap: onTap,

        child: Padding(

          padding:
          const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 18,
          ),

          child: Row(

            children: [

              Container(

                width: 42,
                height: 42,

                decoration: BoxDecoration(
                  color:
                  const Color(0xFFE9D5FF),

                  borderRadius:
                  BorderRadius.circular(
                      12),
                ),

                child: Icon(
                  icon,
                  color:
                  const Color(0xFF7C3AED),
                ),
              ),

              const SizedBox(width: 14),

              Expanded(

                child: Text(

                  title,

                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight:
                    FontWeight.w600,
                    color:
                    AppColors.textDark,
                  ),
                ),
              ),

              trailing ??

                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color:
                    AppColors.textGrey,
                  ),
            ],
          ),
        ),
      ),
    );
  }
}