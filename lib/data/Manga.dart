import 'package:cloud_firestore/cloud_firestore.dart';

import 'Chapter.dart';

class Manga {
  late String title;
  late bool liked;
  late bool saved;
  late String docId;
  late String url;
  late int date;
  late String author;
  late List<Chapter> chapters;

  Manga.fromDoc(QueryDocumentSnapshot doc, List<Chapter> chap) {
    title = doc["title"];
    url = doc["pic"];
    author = doc["Author"];
    date = doc["year"];
    docId = doc.id;
    chapters = chap;
    liked = doc["liked"];
    saved = doc["saved"];
    //chapters
  }

}
