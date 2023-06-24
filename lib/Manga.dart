import 'package:cloud_firestore/cloud_firestore.dart';

class Manga {
  late String title;
  //late String image;
  late int likes;
  late String docId;
  late String author;
  late String url;
  late int date;
  Manga({required titleManga, required urlManga, required dateManga})
  {
    title = titleManga;
    url = urlManga;
    date = dateManga;
    likes = 0;
    docId = "123";
    author = "";
  }
  Manga.fromDoc(QueryDocumentSnapshot doc) {
    title = doc["title"];
    url = doc["pic"];
    author = doc["Author"];
    date = doc["year"];
    docId = doc.id;
  }
}