class Note {
  final int? id;
  final String title;
  final String content;
  final DateTime create_at;
  final DateTime update_at;
  final bool isCompleted;

  const Note({
    this.id,
    this.isCompleted = false,
    required this.title,
    required this.content,
    required this.create_at,
    required this.update_at,
  });

  Map<String, dynamic> toMap() => {
    'title': title,
    'content': content,
    'create_at': create_at.toIso8601String(),
    'update_at': update_at.toIso8601String(),
    'isCompleted': isCompleted ? 1 : 0,
  };

  factory Note.fromMap(Map<String, dynamic> map) {
    final int? isCompletedInt = map['isCompleted'] as int?;
    return Note(
      id: map['id'] as int?,
      title: map['title'],
      content: map['content'],
      isCompleted: isCompletedInt == 1,
      create_at: DateTime.parse(map['create_at']),
      update_at: DateTime.parse(map['update_at']),
    );
  }
}
