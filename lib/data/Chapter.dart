import 'package:cloud_firestore/cloud_firestore.dart';
class Chapter {
  late String title;
  late List<String> urlsPageRussian;
  late List<String> urlsPageEnglish;
  late List<String> urlsPageSpanish;
  late List<String> urlsPageOriginal;
  late String description;

  Chapter({
    required this.title,
    required this.urlsPageRussian,
    required this.urlsPageEnglish,
    required this.description,
  })
  {urlsPageOriginal = urlsPageEnglish;
  urlsPageSpanish = [];}
  Chapter.fromDoc(QueryDocumentSnapshot doc){
    title = doc["Title"];
    description = doc.id;
    urlsPageRussian = List<String>.from(doc["PageRussian"]);
    urlsPageEnglish = List<String>.from(doc["PageEnglish"]);
    urlsPageSpanish = List<String>.from(doc["PageSpanish"]);
    urlsPageOriginal = List<String>.from(doc["PageOriginal"]);
  }
}