import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../data/Chapter.dart';

class MangaReaderPage extends StatefulWidget {
  final Chapter chapter;

  const MangaReaderPage({Key? key, required this.chapter}) : super(key: key);

  @override
  _MangaReaderPageState createState() => _MangaReaderPageState();
}

class _MangaReaderPageState extends State<MangaReaderPage> {
  String selectedLanguage = 'russian'; // Изначально выбран русский язык

  List<String> getSelectedUrls() {
    switch (selectedLanguage) {
      case 'english':
        return widget.chapter.urlsPageEnglish;
      case 'spanish':
        return widget.chapter.urlsPageSpanish;
      case 'russian':
        return widget.chapter.urlsPageRussian;
      case 'original':
      default:
        return widget.chapter.urlsPageOriginal;
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedUrls = getSelectedUrls();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.chapter.title),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: CarouselSlider(
                options: CarouselOptions(
                  height: double.infinity,
                  viewportFraction: 1.0,
                  enableInfiniteScroll: false,
                ),
                items: selectedUrls.map((url) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Image.network(
                        url,
                        fit: BoxFit.contain,
                      );
                    },
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: PopupMenuButton<String>(
        itemBuilder: (BuildContext context) {
          return [
            PopupMenuItem<String>(
              value: 'english',
              child: Text('English'),
            ),
            PopupMenuItem<String>(
              value: 'spanish',
              child: Text('Spanish'),
            ),
            PopupMenuItem<String>(
              value: 'russian',
              child: Text('Russian'),
            ),
            PopupMenuItem<String>(
              value: 'original',
              child: Text('Original'),
            ),
          ];
        },
        onSelected: (String value) {
          setState(() {
            selectedLanguage = value; // Обновляем выбранный язык
          });
        },
        child: Icon(Icons.translate),
      ),
    );
  }
}
