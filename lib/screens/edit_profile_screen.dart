import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

import '../services/firestore_service.dart';
import '../services/storage_service.dart';
import '../theme/app_theme.dart';

class EditProfileScreen extends StatefulWidget {

  final Map<String, dynamic> userData;

  const EditProfileScreen({
    super.key,
    required this.userData,
  });

  @override
  State<EditProfileScreen> createState() =>
      _EditProfileScreenState();
}

class _EditProfileScreenState
    extends State<EditProfileScreen> {

  final FirestoreService firestoreService =
  FirestoreService();

  final StorageService storageService =
  StorageService();

  final User? currentUser =
      FirebaseAuth.instance.currentUser;

  late TextEditingController fullNameController;
  late TextEditingController nicknameController;
  late TextEditingController phoneController;
  late TextEditingController studentIdController;
  late TextEditingController departmentController;
  late TextEditingController universityController;

  File? selectedImage;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    fullNameController =
        TextEditingController(
          text: widget.userData['fullName'],
        );

    nicknameController =
        TextEditingController(
          text: widget.userData['nickname'],
        );

    phoneController =
        TextEditingController(
          text: widget.userData['phone'],
        );

    studentIdController =
        TextEditingController(
          text: widget.userData['studentId'],
        );

    departmentController =
        TextEditingController(
          text: widget.userData['department'],
        );

    universityController =
        TextEditingController(
          text: widget.userData['university'],
        );
  }

  Future<void> pickImage() async {
    final picked =
    await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (picked != null) {
      setState(() {
        selectedImage = File(picked.path);
      });
    }
  }

  Future<void> removeProfileImage() async {
    await firestoreService.updateProfileImage(
      uid: currentUser!.uid,
      imageUrl: '',
    );

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Profile picture removed',
        ),
      ),
    );

    Navigator.pop(context);
  }

  Future<void> saveProfile() async {

    try {

      setState(() {
        isLoading = true;
      });

      String imageUrl =
          widget.userData['profileImage'] ?? '';

      // Upload Image
      if (selectedImage != null) {

        imageUrl =
        await storageService.uploadProfileImage(
          file: selectedImage!,
          uid: currentUser!.uid,
        );

        await firestoreService.updateProfileImage(
          uid: currentUser!.uid,
          imageUrl: imageUrl,
        );
      }

      // Update Firestore
      await firestoreService.updateProfile(

        uid: currentUser!.uid,

        fullName:
        fullNameController.text.trim(),

        nickname:
        nicknameController.text.trim(),

        phone:
        phoneController.text.trim(),

        studentId:
        studentIdController.text.trim(),

        department:
        departmentController.text.trim(),

        university:
        universityController.text.trim(),
      );

      if (!mounted) return;

      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Profile Updated Successfully',
          ),
        ),
      );

      Navigator.pop(context);

    } catch (e) {

      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Update Failed: $e',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    String profileImage =
        widget.userData['profileImage'] ?? '';

    return Scaffold(

      backgroundColor:
      const Color(0xFFF8F4FF),

      appBar: AppBar(

        title: const Text('Edit Profile'),

        backgroundColor:
        const Color(0xFFF8F4FF),

        elevation: 0,

        foregroundColor:
        AppColors.textDark,
      ),

      body: SingleChildScrollView(

        padding:
        const EdgeInsets.all(20),

        child: Column(

          children: [

            // PROFILE IMAGE
            Stack(

              children: [

                CircleAvatar(

                  radius: 55,

                  backgroundColor:
                  const Color(0xFFE9D5FF),

                  backgroundImage:
                  selectedImage != null
                      ? FileImage(selectedImage!)
                      : profileImage.isNotEmpty
                      ? NetworkImage(profileImage)
                  as ImageProvider
                      : null,

                  child:
                  selectedImage == null &&
                      profileImage.isEmpty

                      ? const Icon(
                    Icons.person,
                    size: 55,
                    color: Color(0xFF7C3AED),
                  )

                      : null,
                ),

                Positioned(

                  bottom: 0,
                  right: 0,

                  child: GestureDetector(

                    onTap: pickImage,

                    child: Container(

                      padding:
                      const EdgeInsets.all(8),

                      decoration:
                      const BoxDecoration(
                        color: Color(0xFF7C3AED),
                        shape: BoxShape.circle,
                      ),

                      child: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            TextButton.icon(

              onPressed: removeProfileImage,

              icon: const Icon(
                Icons.delete_outline,
                color: Colors.red,
              ),

              label: const Text(
                'Remove Profile Picture',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),

            const SizedBox(height: 20),

            _buildField(
              controller:
              fullNameController,
              label: 'Full Name',
            ),

            _buildField(
              controller:
              nicknameController,
              label: 'Nickname',
            ),

            _buildField(
              controller:
              studentIdController,
              label: 'Student ID',
            ),

            _buildField(
              controller:
              phoneController,
              label: 'Phone Number',
            ),

            _buildField(
              controller:
              departmentController,
              label: 'Department',
            ),

            _buildField(
              controller:
              universityController,
              label: 'University',
            ),

            const SizedBox(height: 30),

            SizedBox(

              width: double.infinity,
              height: 54,

              child: ElevatedButton(

                onPressed:
                isLoading
                    ? null
                    : saveProfile,

                style:
                ElevatedButton.styleFrom(

                  backgroundColor:
                  const Color(0xFF7C3AED),

                  shape:
                  RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(16),
                  ),
                ),

                child: isLoading

                    ? const CircularProgressIndicator(
                  color: Colors.white,
                )

                    : const Text(

                  'Save Changes',

                  style: TextStyle(
                    fontSize: 16,
                    fontWeight:
                    FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildField({

    required TextEditingController controller,
    required String label,

  }) {
    return Padding(

      padding: const EdgeInsets.only(
        bottom: 18,
      ),

      child: Column(

        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [

          Padding(

            padding: const EdgeInsets.only(
              left: 4,
              bottom: 8,
            ),

            child: Text(

              label,

              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Color(0xFF6B7280),
              ),
            ),
          ),

          TextField(

            controller: controller,

            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: AppColors.textDark,
            ),

            decoration: InputDecoration(

              hintText: 'Enter $label',

              hintStyle: const TextStyle(
                color: Color(0xFF9CA3AF),
                fontSize: 14,
              ),

              filled: true,

              fillColor: Colors.white,

              contentPadding:
              const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),

              border: OutlineInputBorder(

                borderRadius:
                BorderRadius.circular(16),

                borderSide: BorderSide.none,
              ),

              enabledBorder: OutlineInputBorder(

                borderRadius:
                BorderRadius.circular(16),

                borderSide: BorderSide.none,
              ),

              focusedBorder: OutlineInputBorder(

                borderRadius:
                BorderRadius.circular(16),

                borderSide: const BorderSide(
                  color: Color(0xFF7C3AED),
                  width: 1.4,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}