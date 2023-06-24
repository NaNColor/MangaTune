import 'package:flutter/material.dart';
import 'package:mangatune/data/Manga.dart';
import 'MangaReaderPage.dart';

class MangaPage extends StatelessWidget {
  final Manga manga;

  const MangaPage({Key? key, required this.manga}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(manga.title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(
                  manga.url,
                  width: 128,
                  height: 128,
                  fit: BoxFit.scaleDown,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        manga.title,
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'By: ${manga.author}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Chapters:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: manga.chapters.length,
              itemBuilder: (BuildContext context, int index) {
                final chapter = manga.chapters[index];
                return ListTile(
                  title: Text(chapter.title),
                  subtitle: Text(chapter.description),
                  onTap: () {
                    // Переход на новый экран для чтения манги
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MangaReaderPage(chapter: chapter),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
