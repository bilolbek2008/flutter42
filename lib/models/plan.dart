class Plan {
  String title;
  bool isCompleted;

  Plan({required this.title, this.isCompleted = false});

  void toggleComplete() {
    isCompleted = !isCompleted;
  }

  void updateTitle(String newTitle) {
    title = newTitle;
  }
}
