import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mangatune/pages/MangaPage.dart';
import 'package:mangatune/data/Chapter.dart';
import 'package:mangatune/data/Manga.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  List<Manga> mangaList = [];

  @override
  Widget build(BuildContext context) {
    //CollectionReference Mangas = FirebaseFirestore.instance.collection('Mangas');
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.black),
          onPressed:
              () {}, // => Navigator.push(MaterialPageRoute(builder: (BuildContext context) => SomePage()));,
        ),
        backgroundColor: Colors.white,
        title: Text("MangaTune", style: TextStyle(color: Colors.black)),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(Icons.alarm, color: Colors.black, size: 36.0),
              onPressed: () {}),
          IconButton(
              icon: Icon(Icons.login, color: Colors.black, size: 36.0),
              onPressed: () {}),
        ],
      ),
      body: FutureBuilder<List<Manga>>(
        //body: FutureBuilder<DocumentSnapshot>(
        /// Initialize FlutterFire:
        future: getMangas(),
        builder: (BuildContext context, snapshot) {
          /// if Error
          if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          /// On completion
          if (snapshot.connectionState == ConnectionState.done) {
            mangaList = snapshot.data!;
            return buildGrid(mangaList);
          }

          /// On Loading
          return Center(
              child: CircularProgressIndicator(
            strokeWidth: 3,
          ));
        },
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        //changer icons decoration
        child: SizedBox(
          height: 64,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.home, size: 36.0),
                //round with blue color and black border
                color: Colors.blue,
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.search, size: 36.0),
                //color: Colors.black,
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.star, size: 36.0), //star icon
                //color: Colors.black,
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.account_box, size: 36.0),
                // round figure with black border
                //color: Colors.black,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<List<Manga>> getMangas() async {
    List<Manga> mangas = [];

    //int incrementation = 1;
    await FirebaseFirestore.instance.collection('Mangas').get().then((result) {
      for (QueryDocumentSnapshot manga in result.docs) {
        List<Chapter> chapters = [];
        //incrementation = 1;
        manga.reference.collection('Chapters').get().then(
          (QuerySnapshot querySnapshot) {
            querySnapshot.docs.forEach(
              (QueryDocumentSnapshot docChapter) {
                chapters.add(Chapter.fromDoc(docChapter));
              },
            );
          },
        );

        mangas.add(Manga.fromDoc(manga, chapters));
        //chapters = [];
      }
      //querySnapshot.docs.forEach((QueryDocumentSnapshot docManga) {        });
    });
    return mangas;
  }

  Widget buildGrid(List<Manga> mangaList) {
    return RefreshIndicator(
      onRefresh: () async {
        mangaList = [];
        await getMangas();
        setState(() {});
        return Future.value();
      },
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: 2.0,
          ),
          itemCount: mangaList.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MangaPage(manga: mangaList[index])),
                );
              },
              child: Card(
                child: Row(children: [
                  Image.network(mangaList[index].url,
                      width: 128, height: 128, fit: BoxFit.scaleDown), //fill
                  SizedBox(
                    width: 248,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 24),
                          Text(
                            mangaList[index].date.toString(),
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Arial',
                            ),
                          ),
                          //date
                          SizedBox(height: 16),
                          Text(
                            mangaList[index].title,
                            overflow: TextOverflow.fade,
                            maxLines: 2,
                            style: TextStyle(
                              fontSize: 24,
                              fontFamily: 'Arial',
                            ),
                          ),
                          //title
                          SizedBox(height: 16),
                          Row(children: [
                            //star
                            //Icon(Icons.star),
                            SavedState(
                                mangaList[index].docId, mangaList[index].saved),
                            SizedBox(width: 24),
                            LikedState(
                                mangaList[index].docId, mangaList[index].liked),
                            //like
                          ]),
                        ]),
                  ),
                ]),
              ),
            );
          }),
    );
  }

  Widget SavedState(String docID, bool state) {
    return InkWell(
      onTap: () {
        updateViews(docID, "saved");
        //setState(() {});
      },
      child: !state
          ? Row(children: [
              Icon(Icons.star_border_rounded),
              Text("Save"),
            ])
          : Row(children: [
              Icon(
                Icons.star_rounded,
                color: Colors.amberAccent,
              ),
              Text("Save"),
            ]),
    );
  }

  Widget LikedState(String docID, bool state) {
    return InkWell(
      onTap: () {
        updateViews(docID, "liked");
        //setState(() {});
      },
      child: state
          ? Row(children: [
              Icon(Icons.favorite, color: Colors.redAccent),
              Text("Like"),
            ])
          : Row(children: [
              Icon(Icons.favorite_border),
              Text("Save"),
            ]),
    );
  }

  void updateViews(String docID, String field) {
    // FirebaseFirestore.instance
    //     .collection('Mangas')
    //     .doc(docID)
    //     .update({field: FieldValue})
    //     .then((value) => print("Gallery Updated"))
    //     .catchError((error) => print("Failed to update gallery: $error"));
    final sfDocRef = FirebaseFirestore.instance.collection('Mangas').doc(docID);
    FirebaseFirestore.instance.runTransaction((transaction) async {
      final snapshot = await transaction.get(sfDocRef);
      final newField = !snapshot.get(field);
      transaction.update(sfDocRef, {field: newField});
    }).then(
      (value) => setState(() {}),
      onError: (e) => print("Error updating document $e"),
    );
  }
}
// class GalleryRouter extends StatelessWidget {
//   final Manga manga;
//
//   GalleryRouter(this.gallery, {Key? key}) : super(key: key);
//
//   static PageRouteBuilder getRoute(Manga manga) {
//     return PageRouteBuilder(
//         transitionsBuilder: (_, animation, secondAnimation, child) {
//           return FadeTransition(
//             opacity: animation,
//             child: RotationTransition(
//               turns: Tween<double>(begin: 0.5, end: 1.0).animate(animation),
//               child: child,
//             ),
//           );
//         }, pageBuilder: (_, __, ___) {
//       return new GalleryRouter(manga);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     updateViews();
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         title: Text(gallery.title),
//       ),
//       body: Center(child: Image.network(gallery.image)),
//     );
//   }
//
//   void updateViews() {
//     FirebaseFirestore.instance
//         .collection('gallery')
//         .doc(gallery.docId)
//         .update({'views': FieldValue.increment(1)})
//         .then((value) => print("Gallery Updated"))
//         .catchError((error) => print("Failed to update gallery: $error"));
//   }
// }
