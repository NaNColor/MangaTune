import 'package:flutter/material.dart';
import '../data/Chapter.dart';

class MangaReaderPage extends StatelessWidget {
  final Chapter chapter;

  const MangaReaderPage({Key? key, required this.chapter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Реализация экрана чтения манги
    return Scaffold(
      appBar: AppBar(
        title: Text(chapter.title),
      ),
      body: Center(
        child: Text('Reading ${chapter.title}'),
      ),
    );
  }
}