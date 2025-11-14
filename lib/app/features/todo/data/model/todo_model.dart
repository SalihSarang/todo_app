class TodoModel {
  final String id;
  final String title;
  final String details;
  final bool isCompleted;
  final DateTime? date;
  final String? time;

  TodoModel({
    required this.id,
    required this.title,
    required this.details,
    required this.isCompleted,
    this.date,
    this.time,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      details: json['details'] ?? '',
      isCompleted: json['isCompleted'] ?? false,
      date: json['date'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['date'] as int)
          : null,
      time: json['time'] as String?,
    );
  }
  TodoModel copyWith({bool? isCompleted}) {
    return TodoModel(
      id: id,
      title: title,
      details: details,
      isCompleted: isCompleted ?? this.isCompleted,
      date: date,
      time: time,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'details': details,
      'isCompleted': isCompleted,
      if (date != null) 'date': date!.millisecondsSinceEpoch,
      if (time != null) 'time': time,
    };
  }
}
