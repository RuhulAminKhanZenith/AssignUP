import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../theme/app_theme.dart';
import 'signup_screen.dart';
import '../main_navigation.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final AuthService authService = AuthService();

  final TextEditingController emailController =
  TextEditingController();

  final TextEditingController passwordController =
  TextEditingController();

  bool obscurePassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> login() async {

    try {

      await authService.signIn(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login Successful'),
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const MainNavigation(),
        ),
      );

    } on FirebaseAuthException catch (e) {

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.message ?? 'Login Failed',
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
          gradient: AppColors.splashGradient,
        ),

        child: SafeArea(

          child: SingleChildScrollView(

            child: Padding(

              padding: const EdgeInsets.symmetric(
                horizontal: 24,
              ),

              child: Column(

                children: [

                  const SizedBox(height: 32),

                  // Logo
                  Container(

                    width: 72,
                    height: 72,

                    decoration: BoxDecoration(

                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF3B82F6),
                          Color(0xFF1D4ED8),
                        ],
                      ),

                      borderRadius:
                      BorderRadius.circular(20),
                    ),

                    child: const Icon(
                      Icons.menu_book_rounded,
                      color: Colors.white,
                      size: 38,
                    ),
                  ),

                  const SizedBox(height: 12),

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

                  const SizedBox(height: 6),

                  const Text(

                    'Smart Class &\nAssignment Tracker',

                    textAlign: TextAlign.center,

                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      height: 1.3,
                    ),
                  ),

                  const SizedBox(height: 6),

                  const Text(

                    'Manage your studies efficiently',

                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFFFBBF24),
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 28),

                  // Login Card
                  Container(

                    width: double.infinity,

                    padding: const EdgeInsets.all(24),

                    decoration: BoxDecoration(
                      color: const Color(0xFFEDE9FE),
                      borderRadius:
                      BorderRadius.circular(24),
                    ),

                    child: Column(

                      crossAxisAlignment:
                      CrossAxisAlignment.start,

                      children: [

                        const Center(
                          child: Text(
                            'Welcome Back!',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF7C3AED),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Email Field
                        _buildLabel(
                          Icons.email_outlined,
                          'Email',
                        ),

                        const SizedBox(height: 6),

                        _buildTextField(
                          controller: emailController,
                          hint: 'Enter your email',
                          keyboardType:
                          TextInputType.emailAddress,
                        ),

                        const SizedBox(height: 16),

                        // Password Field
                        _buildLabel(
                          Icons.lock_outline,
                          'Password',
                        ),

                        const SizedBox(height: 6),

                        _buildTextField(

                          controller: passwordController,

                          hint: 'Enter your password',

                          obscure: obscurePassword,

                          suffixIcon: IconButton(

                            icon: Icon(

                              obscurePassword
                                  ? Icons
                                  .visibility_off_outlined
                                  : Icons
                                  .visibility_outlined,

                              color: AppColors.textGrey,
                              size: 20,
                            ),

                            onPressed: () {

                              setState(() {

                                obscurePassword =
                                !obscurePassword;
                              });
                            },
                          ),
                        ),

                        const SizedBox(height: 8),

                        Align(

                          alignment: Alignment.centerRight,

                          child: TextButton(

                            onPressed: () {},

                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size.zero,
                              tapTargetSize:
                              MaterialTapTargetSize
                                  .shrinkWrap,
                            ),

                            child: const Text(

                              'Forgot Password?',

                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF7C3AED),
                                fontWeight:
                                FontWeight.w500,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Sign In Button
                        SizedBox(

                          width: double.infinity,
                          height: 50,

                          child: ElevatedButton.icon(

                            onPressed: login,

                            icon: const Icon(
                              Icons.login_rounded,
                              color: Colors.white,
                              size: 20,
                            ),

                            label: const Text(

                              'Sign in',

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
                              const Color(0xFF7C3AED),

                              shape:
                              RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(
                                    14),
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

                              "Don't have an account?  ",

                              style: TextStyle(
                                fontSize: 13,
                                color: AppColors.textGrey,
                              ),
                            ),

                            GestureDetector(

                              onTap: () {

                                Navigator.push(

                                  context,

                                  MaterialPageRoute(
                                    builder: (_) =>
                                    const SignUpScreen(),
                                  ),
                                );
                              },

                              child: const Text(

                                'Sign up',

                                style: TextStyle(
                                  fontSize: 13,
                                  color:
                                  Color(0xFF7C3AED),
                                  fontWeight:
                                  FontWeight.w600,
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
      ),
    );
  }

  Widget _buildLabel(
      IconData icon,
      String label,
      ) {

    return Row(

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
    );
  }

  Widget _buildTextField({

    required TextEditingController controller,

    required String hint,

    bool obscure = false,

    TextInputType? keyboardType,

    Widget? suffixIcon,

  }) {

    return Container(

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
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
            vertical: 14,
          ),

          suffixIcon: suffixIcon,
        ),

        style: const TextStyle(
          fontSize: 14,
          color: AppColors.textDark,
        ),
      ),
    );
  }
}