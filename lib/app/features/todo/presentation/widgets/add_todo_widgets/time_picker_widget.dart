import 'package:flutter/material.dart';

class TimePickerWidget extends StatelessWidget {
  final String label;
  final TimeOfDay? selectedTime;
  final Function(TimeOfDay) onTimeSelected;
  final IconData? icon;
  final DateTime? selectedDate;

  const TimePickerWidget({
    super.key,
    required this.label,
    required this.selectedTime,
    required this.onTimeSelected,
    this.icon,
    this.selectedDate,
  });

  Future<void> _selectTime(BuildContext context) async {
    final now = DateTime.now();
    final currentTime = TimeOfDay.fromDateTime(now);

    // If today's date is selected, use current time as minimum
    // Otherwise, allow any time
    TimeOfDay initialTime;
    if (selectedTime != null) {
      initialTime = selectedTime!;
    } else if (selectedDate != null) {
      final selectedDateOnly = DateTime(
        selectedDate!.year,
        selectedDate!.month,
        selectedDate!.day,
      );
      final todayOnly = DateTime(now.year, now.month, now.day);

      // If selected date is today, use current time, otherwise use 12:00 AM
      if (selectedDateOnly.isAtSameMomentAs(todayOnly)) {
        initialTime = currentTime;
      } else {
        initialTime = const TimeOfDay(hour: 0, minute: 0);
      }
    } else {
      initialTime = currentTime;
    }

    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.black,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedTime) {
      // Validate that if today's date is selected, time must be in the future
      if (selectedDate != null) {
        final selectedDateOnly = DateTime(
          selectedDate!.year,
          selectedDate!.month,
          selectedDate!.day,
        );
        final todayOnly = DateTime(now.year, now.month, now.day);

        if (selectedDateOnly.isAtSameMomentAs(todayOnly)) {
          final pickedDateTime = DateTime(
            now.year,
            now.month,
            now.day,
            picked.hour,
            picked.minute,
          );

          if (pickedDateTime.isBefore(now)) {
            // Show error message
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Please select a future time'),
                duration: Duration(seconds: 2),
              ),
            );
            return;
          }
        }
      }

      onTimeSelected(picked);
    }
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _selectTime(context),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          hintText: 'Select time',
          hintStyle: TextStyle(color: Colors.grey[500]),
          floatingLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          prefixIcon: icon != null ? Icon(icon) : const Icon(Icons.access_time),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 0, 0, 0),
              width: 2,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 12,
          ),
        ),
        child: Text(
          selectedTime != null
              ? _formatTime(selectedTime!)
              : 'No time selected',
          style: TextStyle(
            color: selectedTime != null ? Colors.black : Colors.grey[500],
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
