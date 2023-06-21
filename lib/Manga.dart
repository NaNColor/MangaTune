//import 'package:cloud_firestore/cloud_firestore.dart';

class Manga {
  late String title;
  //late String image;
  late int likes;
  late String docId;
  late String url;
  late String date;
  Manga({required titleManga, required urlManga, required dateManga})
  {
    title = titleManga;
    url = urlManga;
    date = dateManga;
    likes = 0;
    docId = "123";
  }
  // Manga.fromDoc(QueryDocumentSnapshot doc) {
  //   title = doc["title"];
  //   image = doc["image"];
  //   views = doc["views"];
  //   docId = doc.id;
  // }
}