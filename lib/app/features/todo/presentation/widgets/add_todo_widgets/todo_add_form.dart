import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riverpod/app/features/todo/business/todo_provider.dart';
import 'package:todo_riverpod/app/features/todo/data/model/todo_model.dart';
import 'package:todo_riverpod/app/utils/widgets/text_field.dart';
import 'package:todo_riverpod/app/features/todo/presentation/widgets/add_todo_widgets/date_picker_widget.dart';
import 'package:todo_riverpod/app/features/todo/presentation/widgets/add_todo_widgets/time_picker_widget.dart';
import 'package:todo_riverpod/app/features/todo/utils/form_validation.dart';
import 'package:todo_riverpod/app/features/todo/utils/unique_id.dart';
import 'package:todo_riverpod/app/features/todo/utils/validate_form.dart';

class TodoAddForm extends ConsumerWidget {
  TodoAddForm({super.key});

  final _titleCtrl = TextEditingController();
  final _detailsCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = ref.watch(selectedDateProvider);
    final selectedTime = ref.watch(selectedTimeProvider);

    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextFormField(
            controller: _titleCtrl,
            label: 'Title',
            hint: 'Title',
            validator: (v) => validateTodoTitle(v),
          ),

          const SizedBox(height: 15),

          CustomTextFormField(
            controller: _detailsCtrl,
            label: 'Details',
            hint: 'Details',
            maxLines: 5,
            validator: (v) => validateTodoDetails(v),
          ),

          const SizedBox(height: 15),

          DatePickerWidget(
            label: 'Date',
            selectedDate: selectedDate,
            onDateSelected: (date) {
              ref.read(selectedDateProvider.notifier).state = date;

              final currentSelectedTime = ref.read(selectedTimeProvider);
              if (currentSelectedTime != null) {
                final now = DateTime.now();
                final dateOnly = DateTime(date.year, date.month, date.day);
                final todayOnly = DateTime(now.year, now.month, now.day);

                if (dateOnly.isAtSameMomentAs(todayOnly)) {
                  final selectedDateTime = DateTime(
                    now.year,
                    now.month,
                    now.day,
                    currentSelectedTime.hour,
                    currentSelectedTime.minute,
                  );

                  if (selectedDateTime.isBefore(now)) {
                    ref.read(selectedTimeProvider.notifier).state = null;
                  }
                }
              }
            },
          ),

          const SizedBox(height: 15),

          TimePickerWidget(
            label: 'Time',
            selectedTime: selectedTime,
            selectedDate: selectedDate,
            onTimeSelected: (time) {
              ref.read(selectedTimeProvider.notifier).state = time;
            },
          ),

          const SizedBox(height: 20),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
            ),
            onPressed: () async {
              if (validateForm(_formKey)) {
                final selectedTime = ref.read(selectedTimeProvider);

                // Validate that if today's date is selected, time must be in the future
                if (selectedDate != null && selectedTime != null) {
                  final now = DateTime.now();
                  final selectedDateOnly = DateTime(
                    selectedDate.year,
                    selectedDate.month,
                    selectedDate.day,
                  );
                  final todayOnly = DateTime(now.year, now.month, now.day);

                  if (selectedDateOnly.isAtSameMomentAs(todayOnly)) {
                    final selectedDateTime = DateTime(
                      now.year,
                      now.month,
                      now.day,
                      selectedTime.hour,
                      selectedTime.minute,
                    );

                    if (selectedDateTime.isBefore(now)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Please select a future time for today',
                          ),
                          duration: Duration(seconds: 2),
                        ),
                      );
                      return;
                    }
                  }
                }

                final timeString = selectedTime != null
                    ? '${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}'
                    : null;

                final todo = TodoModel(
                  id: generateUniqueId(),
                  title: _titleCtrl.text,
                  details: _detailsCtrl.text,
                  isCompleted: false,
                  date: selectedDate,
                  time: timeString,
                );
                await ref.read(todoStateProvider.notifier).addTodo(todo);
                // Reset date and time after saving
                ref.read(selectedDateProvider.notifier).state = null;
                ref.read(selectedTimeProvider.notifier).state = null;

                FirebaseAnalytics.instance.logEvent(
                  name: 'todo_created',
                  parameters: {
                    'source': 'fab_button',
                    'has_date': (selectedDate != null).toString(),
                    'has_time': (selectedTime != null).toString(),
                    'title_length': _titleCtrl.text.length,
                  },
                );

                Navigator.pop(context);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
