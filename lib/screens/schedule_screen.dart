import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  DateTime _selectedDate = DateTime.now();
  final List<String> _weekDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'];

  final List<Map<String, dynamic>> _scheduleItems = [
    {
      'time': '08:30 AM',
      'activity': 'Arrival & Free Play',
      'icon': Icons.toys,
      'color': Colors.blue,
    },
    {
      'time': '09:00 AM',
      'activity': 'Morning Circle Time',
      'icon': Icons.circle,
      'color': Colors.orange,
    },
    {
      'time': '09:30 AM',
      'activity': 'Snack Time',
      'icon': Icons.restaurant,
      'color': Colors.green,
    },
    {
      'time': '10:00 AM',
      'activity': 'Learning Activities',
      'icon': Icons.school,
      'color': Colors.purple,
    },
    {
      'time': '11:00 AM',
      'activity': 'Outdoor Play',
      'icon': Icons.park,
      'color': Colors.teal,
    },
    {
      'time': '12:00 PM',
      'activity': 'Lunch Time',
      'icon': Icons.lunch_dining,
      'color': Colors.red,
    },
    {
      'time': '01:00 PM',
      'activity': 'Nap Time',
      'icon': Icons.bedtime,
      'color': Colors.indigo,
    },
    {
      'time': '02:30 PM',
      'activity': 'Art & Craft',
      'icon': Icons.palette,
      'color': Colors.pink,
    },
    {
      'time': '03:30 PM',
      'activity': 'Story Time',
      'icon': Icons.book,
      'color': Colors.amber,
    },
    {
      'time': '04:00 PM',
      'activity': 'Departure',
      'icon': Icons.directions_car,
      'color': Colors.brown,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Schedule'),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () async {
              final DateTime? picked = await showDatePicker(
                context: context,
                initialDate: _selectedDate,
                firstDate: DateTime.now().subtract(const Duration(days: 365)),
                lastDate: DateTime.now().add(const Duration(days: 365)),
              );
              if (picked != null && picked != _selectedDate) {
                setState(() {
                  _selectedDate = picked;
                });
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildWeekDaySelector(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _scheduleItems.length,
              itemBuilder: (context, index) {
                final item = _scheduleItems[index];
                return _buildScheduleItem(item, index);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Add new schedule item - Coming soon!'),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildWeekDaySelector() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(5, (index) {
          final date = DateTime.now().subtract(
            Duration(days: DateTime.now().weekday - (index + 1)),
          );
          final isSelected = DateUtils.isSameDay(date, _selectedDate);

          return InkWell(
            onTap: () {
              setState(() {
                _selectedDate = date;
              });
            },
            child: Container(
              width: 56,
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Text(
                    _weekDays[index],
                    style: TextStyle(
                      color: isSelected
                          ? Theme.of(context).colorScheme.onPrimary
                          : null,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    date.day.toString(),
                    style: TextStyle(
                      color: isSelected
                          ? Theme.of(context).colorScheme.onPrimary
                          : null,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildScheduleItem(Map<String, dynamic> item, int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            width: 80,
            alignment: Alignment.center,
            child: Text(
              item['time'],
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: item['color'].withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      item['icon'],
                      color: item['color'],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      item['activity'],
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
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
