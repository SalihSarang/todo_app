String generateUniqueId() {
  final timestamp = DateTime.now().millisecondsSinceEpoch;

  return '$timestamp';
}
