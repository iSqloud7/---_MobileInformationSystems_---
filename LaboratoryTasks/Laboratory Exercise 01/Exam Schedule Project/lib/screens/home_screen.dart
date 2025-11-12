import 'package:flutter/material.dart';
import '../models/exam.dart';
import '../widgets/exam_card.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  List<Exam> get exams => [
    Exam(subjectName: 'Дискретна математика', dateTime: DateTime(2026, 1, 15, 10, 0), classrooms: ['138', '215']),
    Exam(subjectName: 'Напредно програмирање', dateTime: DateTime(2025, 11, 8, 9, 0), classrooms: ['200аб']),
    Exam(subjectName: 'Алгоритми и податочни структури', dateTime: DateTime(2025, 11, 9, 14, 0), classrooms: ['2', '12', '13']),
    Exam(subjectName: 'Оперативни системи', dateTime: DateTime(2026, 1, 21, 8, 30), classrooms: ['138', '215', '200в']),
    Exam(subjectName: 'Бази на податоци', dateTime: DateTime(2025, 11, 30, 10, 0), classrooms: ['200аб', '200в', '215']),
    Exam(subjectName: 'Мобилни информациски системи', dateTime: DateTime(2025, 12, 15, 16, 0), classrooms: ['12', '13']),
    Exam(subjectName: 'Интернет технологии', dateTime: DateTime(2026, 2, 1, 11, 0), classrooms: ['215']),
    Exam(subjectName: 'Веб програмирање', dateTime: DateTime(2025, 11, 28, 10, 30), classrooms: ['138','3']),
    Exam(subjectName: 'Интегрирани системи', dateTime: DateTime(2026, 1, 4, 11, 0), classrooms: ['2','3','12','13']),
    Exam(subjectName: 'Вовед во науката за податоци', dateTime: DateTime(2026, 1, 21, 12, 0), classrooms: ['215','200аб']),
    Exam(subjectName: 'Структурно програмирање', dateTime: DateTime(2025, 11, 17, 9, 0), classrooms: ['105', '108']),
    Exam(subjectName: 'Веб базирани системи', dateTime: DateTime(2025, 12, 3, 13, 30), classrooms: ['200в', '215']),
    Exam(subjectName: 'Напреден веб дизајн', dateTime: DateTime(2025, 12, 20, 15, 0), classrooms: ['12', '13']),
    Exam(subjectName: 'Веб дизајн', dateTime: DateTime(2025, 11, 22, 10, 0), classrooms: ['138']),
    Exam(subjectName: 'Програмирање на видео игри', dateTime: DateTime(2026, 1, 10, 14, 0), classrooms: ['3', '215']),
  ];

  @override
  Widget build(BuildContext context) {
    final sortedExams = [...exams]..sort((a, b) => a.dateTime.compareTo(b.dateTime));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Распоред за испити - [223260]'),
      ),
      body: ListView.builder(
        itemCount: sortedExams.length,
        itemBuilder: (context, index) => ExamCard(exam: sortedExams[index]),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(12),
        color: Colors.black,
        child: Text(
          'Вкупно испити: ${sortedExams.length}',
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.redAccent,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
