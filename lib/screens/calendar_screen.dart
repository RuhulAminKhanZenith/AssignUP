import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final DateTime _currentMonth = DateTime(2026, 3);
  DateTime? _selectedDay;
  final String _today = '5'; // Highlighted date

  static const List<String> _weekDays = [
    'Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F4FF),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                      'Calendar',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF7C3AED),
                      ),
                    ),
                    Text(
                      'Observe your Assignments by Date & Month',
                      style: TextStyle(
                        fontSize: 12,
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
                child: Container(
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
                    children: [
                      // Month Header
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF3F4F6),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(Icons.calendar_month_outlined,
                                  size: 20, color: AppColors.textDark),
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              'March 2026',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textDark,
                              ),
                            ),
                            const Spacer(),
                            _navBtn(Icons.chevron_left),
                            const SizedBox(width: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: const Color(0xFFE5E7EB)),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Text(
                                'Today',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.textGrey,
                                ),
                              ),
                            ),
                            const SizedBox(width: 4),
                            _navBtn(Icons.chevron_right),
                          ],
                        ),
                      ),
                      // Weekday headers
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: _weekDays
                              .map((d) => SizedBox(
                            width: 36,
                            child: Text(
                              d,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textGrey,
                              ),
                            ),
                          ))
                              .toList(),
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Calendar Grid
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        child: _buildCalendarGrid(),
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'All Assignments of This Month',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textDark,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    _buildAssignmentItem(
                      title: 'Project: Make an Android App',
                      course: 'Software Engineering Sessional CSE3102',
                      date: 'March 5',
                      status: 'completed',
                    ),
                    const SizedBox(height: 10),
                    _buildAssignmentItem(
                      title: 'Design UI of an Android App',
                      course: 'Software Development II Sessional CSE3102',
                      date: 'March 12',
                      status: 'ongoing',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navBtn(IconData icon) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Icon(icon, size: 18, color: AppColors.textGrey),
    );
  }

  Widget _buildCalendarGrid() {
    // March 2026: starts on Sunday (0)
    final int startWeekday = 0; // Sunday
    final int daysInMonth = 31;
    final int prevDays = 28; // days in previous month

    final List<int?> days = [];
    for (int i = startWeekday - 1; i >= 0; i--) {
      days.add(-(prevDays - i)); // prev month days (negative = greyed)
    }
    for (int i = 1; i <= daysInMonth; i++) {
      days.add(i);
    }
    // Fill remaining
    while (days.length % 7 != 0) {
      days.add(null); // next month
    }

    return Column(
      children: List.generate((days.length / 7).ceil(), (rowIdx) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(7, (colIdx) {
            final idx = rowIdx * 7 + colIdx;
            if (idx >= days.length) return const SizedBox(width: 36);
            final d = days[idx];
            return _buildDayCell(d);
          }),
        );
      }),
    );
  }

  Widget _buildDayCell(int? day) {
    final bool isCurrentMonth = day != null && day > 0;
    final bool isTaskDay = day == 5 || day == 12;
    final bool isSelected = _selectedDay?.day == day;
    final displayText = isCurrentMonth ? '$day' : '';

    Color textColor = isCurrentMonth ? AppColors.textDark : AppColors.textGrey;
    if (isSelected) textColor = Colors.white;
    if (day == 5 && !isSelected) textColor = const Color(0xFFEC4899);

    return GestureDetector(
      onTap: () {
        if (isCurrentMonth) {
          setState(() => _selectedDay = DateTime(2026, 3, day!));
        }
      },
      child: Container(
        width: 36,
        height: 36,
        margin: const EdgeInsets.symmetric(vertical: 3),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF7C3AED) : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Text(
              displayText,
              style: TextStyle(
                fontSize: 13,
                fontWeight: isCurrentMonth ? FontWeight.w500 : FontWeight.w400,
                color: textColor,
              ),
            ),
            if (isTaskDay && !isSelected)
              Positioned(
                bottom: 4,
                child: Container(
                  width: 4,
                  height: 4,
                  decoration: const BoxDecoration(
                    color: Color(0xFF7C3AED),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildAssignmentItem({
    required String title,
    required String course,
    required String date,
    required String status,
  }) {
    final bool isDone = status == 'completed';
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEDE9FE),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    course,
                    style: const TextStyle(
                      fontSize: 10,
                      color: Color(0xFF7C3AED),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                date,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textGrey,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: isDone
                      ? const Color(0xFFBBF7D0)
                      : const Color(0xFFFED7AA),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: isDone
                        ? const Color(0xFF16A34A)
                        : const Color(0xFFD97706),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
