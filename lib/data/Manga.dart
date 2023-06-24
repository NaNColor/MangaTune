import 'package:cloud_firestore/cloud_firestore.dart';

import 'Chapter.dart';

class Manga {
  late String title;
  late int likes;
  late String docId;
  late String url;
  late int date;
  late String author;
  late List<Chapter> chapters;
  Manga({
    required this.title,
    required this.url,
    required this.date,
    required this.author,
    required this.chapters
  }) {
    likes = 0;
    docId = "123";
  }

  Manga.fromDoc(QueryDocumentSnapshot doc, List<Chapter> chap) {
    title = doc["title"];
    url = doc["pic"];
    author = doc["Author"];
    date = doc["year"];
    docId = doc.id;
    chapters = chap;
    //chapters
  }

}
