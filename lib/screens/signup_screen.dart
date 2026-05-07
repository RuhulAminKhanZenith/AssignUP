import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';
import '../services/firestore_service.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final AuthService authService = AuthService();

  final FirestoreService firestoreService =
  FirestoreService();

  final _nameController = TextEditingController();

  final _emailController = TextEditingController();

  final _phoneController = TextEditingController();

  final _studentIdController = TextEditingController();

  final _passwordController = TextEditingController();

  final _confirmPasswordController =
  TextEditingController();

  bool _obscurePassword = true;

  bool _obscureConfirm = true;

  Future<void> signup() async {

    if (_passwordController.text.trim() !=
        _confirmPasswordController.text.trim()) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Passwords do not match'),
        ),
      );

      return;
    }

    try {

      UserCredential userCredential =
      await authService.signUp(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      await firestoreService.saveUserData(
        uid: userCredential.user!.uid,
        fullName: _nameController.text.trim(),
        email: _emailController.text.trim(),
        phone: _phoneController.text.trim(),
        studentId: _studentIdController.text.trim(),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Signup Successful'),
        ),
      );

      Navigator.pop(context);

    } on FirebaseAuthException catch (e) {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.message ?? 'Signup Failed',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF7C3AED),
              Color(0xFF6D28D9),
              Color(0xFF5B21B6),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [

                const SizedBox(height: 24),

                RichText(
                  text: const TextSpan(
                    children: [

                      TextSpan(
                        text: 'Assign',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFFEC4899),
                        ),
                      ),

                      TextSpan(
                        text: 'Up',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'Join Us Today',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 4),

                const Text(
                  'Create your Student Account',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white70,
                  ),
                ),

                const SizedBox(height: 24),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEDE9FE),
                    borderRadius: BorderRadius.circular(24),
                  ),

                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [

                      const Center(
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF7C3AED),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      _buildField(
                        icon: Icons.person_outline,
                        label: 'Full Name',
                        controller: _nameController,
                        hint: 'Enter your full name',
                      ),

                      const SizedBox(height: 14),

                      _buildField(
                        icon: Icons.email_outlined,
                        label: 'Email',
                        controller: _emailController,
                        hint: 'Enter your email',
                        keyboardType:
                        TextInputType.emailAddress,
                      ),

                      const SizedBox(height: 14),

                      _buildField(
                        icon: Icons.phone_outlined,
                        label: 'Phone Number',
                        controller: _phoneController,
                        hint: 'Enter your phone number',
                        keyboardType:
                        TextInputType.phone,
                      ),

                      const SizedBox(height: 14),

                      _buildField(
                        icon: Icons.badge_outlined,
                        label: 'Student ID',
                        controller: _studentIdController,
                        hint: 'Enter your student ID',
                      ),

                      const SizedBox(height: 14),

                      _buildField(
                        icon: Icons.lock_outline,
                        label: 'Password',
                        controller: _passwordController,
                        hint: 'Create a password',
                        obscure: _obscurePassword,

                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: AppColors.textGrey,
                            size: 18,
                          ),

                          onPressed: () {

                            setState(() {
                              _obscurePassword =
                              !_obscurePassword;
                            });
                          },
                        ),
                      ),

                      const SizedBox(height: 14),

                      _buildField(
                        icon: Icons.lock_outline,
                        label: 'Confirm Password',
                        controller:
                        _confirmPasswordController,
                        hint: 'Confirm your password',
                        obscure: _obscureConfirm,

                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureConfirm
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: AppColors.textGrey,
                            size: 18,
                          ),

                          onPressed: () {

                            setState(() {
                              _obscureConfirm =
                              !_obscureConfirm;
                            });
                          },
                        ),
                      ),

                      const SizedBox(height: 24),

                      SizedBox(
                        width: double.infinity,
                        height: 50,

                        child: ElevatedButton.icon(

                          onPressed: signup,

                          icon: const Icon(
                            Icons.person_add_rounded,
                            color: Colors.white,
                            size: 20,
                          ),

                          label: const Text(
                            'Sign Up',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),

                          style:
                          ElevatedButton.styleFrom(
                            backgroundColor:
                            const Color(0xFF7C3AED),

                            shape:
                            RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(14),
                            ),

                            elevation: 0,
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: [

                          const Text(
                            'Already have an account?  ',
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColors.textGrey,
                            ),
                          ),

                          GestureDetector(

                            onTap: () {
                              Navigator.pop(context);
                            },

                            child: const Text(
                              'Sign In',
                              style: TextStyle(
                                fontSize: 13,
                                color: Color(0xFF7C3AED),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildField({
    required IconData icon,
    required String label,
    required TextEditingController controller,
    required String hint,
    bool obscure = false,
    TextInputType? keyboardType,
    Widget? suffixIcon,
  }) {

    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,

      children: [

        Row(
          children: [

            Icon(
              icon,
              size: 16,
              color: AppColors.textGrey,
            ),

            const SizedBox(width: 6),

            Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppColors.textDark,
              ),
            ),
          ],
        ),

        const SizedBox(height: 6),

        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius:
            BorderRadius.circular(12),
          ),

          child: TextField(
            controller: controller,
            obscureText: obscure,
            keyboardType: keyboardType,

            decoration: InputDecoration(
              hintText: hint,

              hintStyle: const TextStyle(
                fontSize: 13,
                color: AppColors.textGrey,
              ),

              border: InputBorder.none,

              contentPadding:
              const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 13,
              ),

              suffixIcon: suffixIcon,
            ),

            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textDark,
            ),
          ),
        ),
      ],
    );
  }
}