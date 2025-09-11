import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riverpod/business/todo_provider.dart';
import 'package:todo_riverpod/data/model/todo_model.dart';
import 'package:todo_riverpod/presentation/widgets/add_todo_widgets/text_field.dart';
import 'package:todo_riverpod/utils/form_validation.dart';
import 'package:todo_riverpod/utils/unique_id.dart';
import 'package:todo_riverpod/utils/validate_form.dart';

class TodoAddForm extends ConsumerWidget {
  TodoAddForm({super.key});

  final _titleCtrl = TextEditingController();
  final _detailsCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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

          SizedBox(height: 15),

          CustomTextFormField(
            controller: _detailsCtrl,
            label: 'Details',
            hint: 'Details',
            maxLines: 5,
            validator: (v) => validateTodoDetails(v),
          ),

          SizedBox(height: 20),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              if (validateForm(_formKey)) {
                final todo = TodoModel(
                  id: generateUniqueId(),
                  title: _titleCtrl.text,
                  details: _detailsCtrl.text,
                  isCompleted: false,
                );
                ref.read(todoStateProvider.notifier).addTodo(todo);
                Navigator.pop(context);
              }
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }
}
