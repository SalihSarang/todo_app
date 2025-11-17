import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riverpod/app/features/user/business/user_details_provider.dart';
import 'package:todo_riverpod/app/features/user/data/repositories/pick_and_upload_img.dart';

class CircleAvatarWidget extends ConsumerWidget {
  const CircleAvatarWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedImage = ref.watch(pickedImageProvider);
    final userState = ref.watch(profileNotifierProvider);
    final user = userState.valueOrNull;

    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(53)),
        onTap: () async {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) =>
                const Center(child: CircularProgressIndicator()),
          );

          try {
            final imageUrl = await pickAndUploadImage(ref);

            if (imageUrl != null && context.mounted) {
              await ref
                  .read(profileNotifierProvider.notifier)
                  .updateImageURL(imageUrl);

              ref.read(pickedImageProvider.notifier).state = null;

              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Profile picture updated successfully'),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            } else if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Failed to upload image'),
                  duration: Duration(seconds: 2),
                ),
              );
            }
          } catch (e) {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Error: $e'),
                  duration: const Duration(seconds: 2),
                ),
              );
            }
          } finally {
            if (context.mounted) {
              Navigator.of(context).pop() // Close loading dialog
            }
          }
        },
        child: CircleAvatar(
          radius: 60,
          backgroundColor: Colors.indigo.shade50,
          backgroundImage: selectedImage != null
              ? FileImage(selectedImage)
              : (user?.imgURL != null ? NetworkImage(user!.imgURL!) : null),
          child: selectedImage == null && user?.imgURL == null
              ? Icon(Icons.person, size: 65, color: Colors.indigo.shade500)
              : null,
        ),
      ),
    );
  }
}
