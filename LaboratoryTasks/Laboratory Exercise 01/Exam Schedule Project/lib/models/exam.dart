class Exam {
  final String subjectName;
  final DateTime dateTime;
  final List<String> classrooms;


  Exam({
    required this.subjectName,
    required this.dateTime,
    required this.classrooms,
  });

  bool get isPassed => dateTime.isBefore(DateTime.now());
}