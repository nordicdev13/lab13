class TaskModel {
  final int? id;
  final String text;
  final String date;

  TaskModel({
    this.id,
    required this.text,
    required this.date,
  });

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'] as int,
      text: map['text'] as String,
      date: map['date'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'date': date,
    };
  }
}