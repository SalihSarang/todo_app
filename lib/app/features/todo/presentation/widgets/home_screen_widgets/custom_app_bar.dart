import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riverpod/app/features/user_auth/business/user_providre.dart';

class CustomAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback onProfileTap;

  const CustomAppBar({
    super.key,
    required this.title,
    required this.onProfileTap,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userProvider);

    return AppBar(
      title: Text(title),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: IconButton(
            onPressed: onProfileTap,
            icon: userAsync.when(
              data: (user) {
                if (user?.imgURL != null && user!.imgURL!.isNotEmpty) {
                  return CircleAvatar(
                    backgroundImage: NetworkImage(user.imgURL!),
                    backgroundColor: Colors.grey[300],
                    onBackgroundImageError: (_, __) {},
                  );
                }
                return CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Text(
                    user?.name.isNotEmpty == true
                        ? user!.name[0].toUpperCase()
                        : 'U',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
              loading: () => const CircleAvatar(
                backgroundColor: Colors.grey,
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                ),
              ),
              error: (_, __) => const CircleAvatar(
                backgroundColor: Colors.red,
                child: Icon(Icons.person, color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
