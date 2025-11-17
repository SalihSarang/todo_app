import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo_riverpod/app/features/user/data/repositories/repositories.dart';
import 'package:todo_riverpod/app/features/user/utils/image_pickcer/image_pickcer.dart';

Future<String?> pickAndUploadImage(WidgetRef ref) async {
  final XFile? file = await pickImage(ref);
  if (file == null) return null;

  final url = await uploadImage(file.path);
  return url;
}
