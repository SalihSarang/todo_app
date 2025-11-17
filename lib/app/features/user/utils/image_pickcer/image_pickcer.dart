import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo_riverpod/app/features/user/business/user_details_provider.dart';

Future<XFile?> pickImage(WidgetRef ref) async {
  final picker = ImagePicker();
  final picked = await picker.pickImage(source: ImageSource.gallery);

  if (picked == null) return null;

  ref.read(pickedImageProvider.notifier).state = File(picked.path);
  return picked;
}
