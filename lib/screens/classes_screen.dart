import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ClassModel {
  final String name;
  final String code;
  final String teacher;
  final String schedule;
  final String room;
  final int assignmentCount;

  const ClassModel({
    required this.name,
    required this.code,
    required this.teacher,
    required this.schedule,
    required this.room,
    required this.assignmentCount,
  });
}

class ClassesScreen extends StatefulWidget {
  const ClassesScreen({super.key});

  @override
  State<ClassesScreen> createState() => _ClassesScreenState();
}

class _ClassesScreenState extends State<ClassesScreen> {
  final List<ClassModel> _classes = const [
    ClassModel(
      name: 'Software Engineering Sessional',
      code: 'CSE3102',
      teacher: 'Sunayana Ghosh, Alifa Shanzidah Manarat',
      schedule: 'Thu (Even) 11:30 AM - 02:20 PM',
      room: 'Room 302',
      assignmentCount: 0,
    ),
    ClassModel(
      name: 'Software Development II Sessional',
      code: 'CSE3100',
      teacher: 'Munira Akter Mou, Md. Osama',
      schedule: 'Thu (Odd) 11:30 AM - 02:20 PM',
      room: 'Room 302',
      assignmentCount: 0,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F4FF),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.menu_book_rounded,
                        color: Colors.white, size: 24),
                  ),
                  const SizedBox(width: 10),
                  RichText(
                    text: const TextSpan(children: [
                      TextSpan(
                        text: 'Assign',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFFEC4899),
                        ),
                      ),
                      TextSpan(
                        text: 'Up',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF7C3AED),
                        ),
                      ),
                    ]),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'My Classes',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF7C3AED),
                        ),
                      ),
                      Text(
                        'Manage Your Courses',
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFFEC4899),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => _showAddClassDialog(context),
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF7C3AED), Color(0xFFEC4899)],
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.add, color: Colors.white, size: 26),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _classes.length,
                itemBuilder: (ctx, i) => _buildClassCard(_classes[i]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClassCard(ClassModel cls) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cls.name,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textDark,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        cls.code,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF7C3AED),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        cls.teacher,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textGrey,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF7C3AED), Color(0xFFEC4899)],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.menu_book_outlined,
                      color: Colors.white, size: 22),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFEC4899), Color(0xFF7C3AED)],
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Row(
                  children: [
                    const Icon(Icons.access_time_rounded,
                        color: Colors.white, size: 14),
                    const SizedBox(width: 6),
                    Text(
                      cls.schedule,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                const Icon(Icons.location_on_outlined,
                    color: AppColors.textGrey, size: 14),
                const SizedBox(width: 4),
                Text(
                  cls.room,
                  style: const TextStyle(
                      fontSize: 12, color: AppColors.textGrey),
                ),
              ],
            ),
          ),
          const Divider(height: 1, thickness: 1, color: Color(0xFFF3F4F6)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEDE9FE),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.assignment_outlined,
                      color: Color(0xFF7C3AED), size: 16),
                ),
                const SizedBox(width: 8),
                Text(
                  '${cls.assignmentCount} Assignment',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textGrey,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.edit_outlined,
                      color: AppColors.textGrey, size: 18),
                  constraints: const BoxConstraints(),
                  padding: const EdgeInsets.all(4),
                ),
                const SizedBox(width: 4),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.delete_outline,
                      color: Color(0xFFEF4444), size: 18),
                  constraints: const BoxConstraints(),
                  padding: const EdgeInsets.all(4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showAddClassDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 24,
          right: 24,
          top: 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Add New Class',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFF7C3AED),
              ),
            ),
            const SizedBox(height: 16),
            _dialogField('Course Name'),
            const SizedBox(height: 12),
            _dialogField('Course Code'),
            const SizedBox(height: 12),
            _dialogField('Teacher(s)'),
            const SizedBox(height: 12),
            _dialogField('Schedule'),
            const SizedBox(height: 12),
            _dialogField('Room'),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7C3AED),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Add Class',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _dialogField(String label) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: AppColors.textGrey, fontSize: 13),
        filled: true,
        fillColor: const Color(0xFFF5F0FF),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      ),
    );
  }
}
