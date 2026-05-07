import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

enum TaskStatus { all, continuous, pending, completed }

class TaskModel {
  final String title;
  final String subtitle;
  final String courseCode;
  final String priority;
  final String status;
  final String dueDate;
  bool isCompleted;

  TaskModel({
    required this.title,
    required this.subtitle,
    required this.courseCode,
    required this.priority,
    required this.status,
    required this.dueDate,
    this.isCompleted = false,
  });
}

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  TaskStatus _selectedFilter = TaskStatus.all;

  final List<TaskModel> _tasks = [
    TaskModel(
      title: 'Project: Make an Android App',
      subtitle: 'Project proposal',
      courseCode: 'Software Engineering Sessional CSE3102',
      priority: 'high',
      status: 'completed',
      dueDate: 'March 5, 2026',
      isCompleted: true,
    ),
    TaskModel(
      title: 'Design UI of an Android App',
      subtitle: '',
      courseCode: 'Software Development II Sessional CSE3102',
      priority: 'high',
      status: 'ongoing',
      dueDate: 'March 12, 2026',
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
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tasks & Assignments',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF7C3AED),
                    ),
                  ),
                  Text(
                    'Track and manage your coursework',
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFFEC4899),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add, color: Colors.white),
                  label: const Text(
                    'Add your Tasks',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7C3AED),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 14),
            // Filter Tabs
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  _buildFilterChip('All (02)', TaskStatus.all),
                  const SizedBox(width: 8),
                  _buildFilterChip('Continuous (01)', TaskStatus.continuous),
                  const SizedBox(width: 8),
                  _buildFilterChip('Pending (00)', TaskStatus.pending),
                  const SizedBox(width: 8),
                  _buildFilterChip('Completed (01)', TaskStatus.completed),
                ],
              ),
            ),
            const SizedBox(height: 14),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _tasks.length,
                itemBuilder: (ctx, i) => _buildTaskCard(_tasks[i], i),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, TaskStatus status) {
    final bool isSelected = _selectedFilter == status;
    return GestureDetector(
      onTap: () => setState(() => _selectedFilter = status),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF7C3AED) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF7C3AED)
                : const Color(0xFFE5E7EB),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: isSelected ? Colors.white : AppColors.textGrey,
          ),
        ),
      ),
    );
  }

  Widget _buildTaskCard(TaskModel task, int index) {
    final bool isCompleted = task.isCompleted;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textDark,
                        decoration:
                        isCompleted ? TextDecoration.lineThrough : null,
                      ),
                    ),
                    if (task.subtitle.isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Text(
                        task.subtitle,
                        style: const TextStyle(
                            fontSize: 12, color: AppColors.textGrey),
                      ),
                    ],
                  ],
                ),
              ),
              Row(
                children: [
                  // Toggle
                  GestureDetector(
                    onTap: () => setState(() => task.isCompleted = !task.isCompleted),
                    child: Container(
                      width: 36,
                      height: 20,
                      decoration: BoxDecoration(
                        color: isCompleted
                            ? const Color(0xFF7C3AED)
                            : const Color(0xFFE5E7EB),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: AnimatedAlign(
                        duration: const Duration(milliseconds: 200),
                        alignment: isCompleted
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          width: 16,
                          height: 16,
                          margin: const EdgeInsets.symmetric(horizontal: 2),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.edit_outlined,
                      color: AppColors.textGrey, size: 18),
                  const SizedBox(width: 8),
                  const Icon(Icons.delete_outline,
                      color: Color(0xFFEF4444), size: 18),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFEDE9FE),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              task.courseCode,
              style: const TextStyle(
                fontSize: 11,
                color: Color(0xFF7C3AED),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              _buildBadge(
                task.priority,
                task.priority == 'high'
                    ? const Color(0xFFEF4444)
                    : const Color(0xFFF59E0B),
                Colors.white,
              ),
              const SizedBox(width: 8),
              _buildBadge(
                task.status,
                task.status == 'completed'
                    ? const Color(0xFFBBF7D0)
                    : const Color(0xFFFED7AA),
                task.status == 'completed'
                    ? const Color(0xFF16A34A)
                    : const Color(0xFFD97706),
              ),
              const Spacer(),
              const Icon(Icons.calendar_today_outlined,
                  size: 12, color: AppColors.textGrey),
              const SizedBox(width: 4),
              Text(
                task.dueDate,
                style: const TextStyle(
                    fontSize: 11, color: AppColors.textGrey),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(String label, Color bg, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }
}
