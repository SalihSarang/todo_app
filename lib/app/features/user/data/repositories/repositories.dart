import 'dart:developer';

import 'package:cloudinary_public/cloudinary_public.dart';

final cloudnary = CloudinaryPublic('dqhheoute', 'profile_pic', cache: false);

Future<String?> uploadImage(String filePath) async {
  try {
    final response = await cloudnary.uploadFile(
      CloudinaryFile.fromFile(
        filePath,
        resourceType: CloudinaryResourceType.Image,
      ),
    );

    return response.secureUrl;
  } catch (e) {
    log(e.toString());
    return null;
  }
}
