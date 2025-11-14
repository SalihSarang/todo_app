String? validateTodoTitle(String? title) {
  if (title == null || title.trim().isEmpty) return 'Title is required.';

  final trimmedTitle = title.trim();

  if (trimmedTitle.length < 3) return 'Title must be at least 3 characters.';

  if (trimmedTitle.length > 100) return 'Title cannot exceed 100 characters.';

  if (RegExp(r'[<>]').hasMatch(trimmedTitle)) {
    return 'Title cannot contain < or >.';
  }
  return null;
}

String? validateTodoDetails(String? details) {
  if (details == null || details.trim().isEmpty) return null;

  final trimmedDetails = details.trim();

  if (trimmedDetails.length > 500) {
    return 'Details cannot exceed 500 characters.';
  }

  if (RegExp(
    r'<script\b[^<]*(?:(?!<\/script>)<[^<]*)*<\/script>',
    caseSensitive: false,
  ).hasMatch(trimmedDetails)) {
    return 'Details cannot contain script tags.';
  }

  return null;
}
