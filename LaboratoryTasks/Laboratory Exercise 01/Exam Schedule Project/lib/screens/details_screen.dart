import 'package:flutter/material.dart';
import '../models/exam.dart';
import 'package:intl/intl.dart';

class DetailsScreen extends StatelessWidget {
  final Exam exam;
  const DetailsScreen({super.key, required this.exam});

  String timeRemaining() {
    final now = DateTime.now().toUtc();
    final examTime = exam.dateTime.isUtc ? exam.dateTime : exam.dateTime.toUtc();
    final diff = examTime.difference(now);
    final past = diff.isNegative;
    final abs = diff.abs();
    final days = abs.inDays;
    final hours = abs.inHours - days * 24;
    final mins = abs.inMinutes - abs.inHours * 60;
    final t = (days > 0)
        ? '$days дена, $hours часа'
        : (hours > 0)
        ? '$hours часа, $mins минути'
        : '$mins минути';
    return past ? 'Испитот помина пред $t' : 'Преостанува: $t';
  }

  @override
  Widget build(BuildContext context) {
    final localDate = exam.dateTime.toLocal();
    final dateFormat = DateFormat('dd.MM.yyyy', 'mk_MK');
    final timeFormat = DateFormat('HH:mm', 'mk_MK');

    return Scaffold(
      appBar: AppBar(title: Text(exam.subjectName.toUpperCase())),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(
              exam.subjectName,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.lightBlue),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      const Icon(Icons.calendar_today, color: Colors.white),
                      const SizedBox(width: 8),
                      Text('Датум: ${dateFormat.format(localDate)}'),
                    ]),
                    const SizedBox(height: 8),
                    Row(children: [
                      const Icon(Icons.access_time, color: Colors.white),
                      const SizedBox(width: 8),
                      Text('Време: ${timeFormat.format(localDate)}'),
                    ]),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.location_on, color: Colors.white),
                        const SizedBox(width: 8),
                        Expanded(child: Text('Простории: ${exam.classrooms.join(', ')}')),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: Text(
                        timeRemaining(),
                        style: const TextStyle(
                          color: Colors.lightBlue,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
