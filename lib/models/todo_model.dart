class ToDo {
  final String id;
  final String title;
  bool isCompleted;

  ToDo({required this.id, required this.title, this.isCompleted = false});

  ToDo copyWith({String? id, String? title, bool? isCompleted}) {
    return ToDo(
      id: id ?? this.id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
