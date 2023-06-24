import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../data/Chapter.dart';

class MangaReaderPage extends StatelessWidget {
  final Chapter chapter;

  const MangaReaderPage({Key? key, required this.chapter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(chapter.title),
      ),
      body: Container(
        child: CarouselSlider(
          options: CarouselOptions(
            height: double.infinity,
            viewportFraction: 1.0,
            enableInfiniteScroll: false,
          ),
          items: chapter.urlsPage.map((url) {
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
    );
  }
}
