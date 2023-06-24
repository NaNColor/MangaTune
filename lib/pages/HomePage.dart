// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mangatune/pages/MangaPage.dart';
import '../data/Chapter.dart';
import '../data/Manga.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  List<Manga> mangaList = [];

  @override
  Widget build(BuildContext context) {
    //CollectionReference gallery = FirebaseFirestore.instance.collection('gallery');
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
    List<Chapter> testChapters = [];
    List<String> testUrlsPage = [];

    testUrlsPage.add(
        "https://img33.imgslib.link//manga/kimetsu-no-yaiba/chapters/1-1/001_tOP9.png");
    testUrlsPage.add(
        "https://img33.imgslib.link//manga/kimetsu-no-yaiba/chapters/1-1/002_kTPv.png");
    testUrlsPage.add(
        "https://img33.imgslib.link//manga/kimetsu-no-yaiba/chapters/1-1/003_9Lq6.png");
    testUrlsPage.add(
        "https://img33.imgslib.link//manga/kimetsu-no-yaiba/chapters/1-1/004_12P7.png");
    testUrlsPage.add(
        "https://img33.imgslib.link//manga/kimetsu-no-yaiba/chapters/1-1/005_k8We.png");
    testUrlsPage.add(
        "https://img33.imgslib.link//manga/kimetsu-no-yaiba/chapters/1-1/006_BMLS.png");
    testUrlsPage.add(
        "https://img33.imgslib.link//manga/kimetsu-no-yaiba/chapters/1-1/007_eet9.png");
    testUrlsPage.add(
        "https://img33.imgslib.link//manga/kimetsu-no-yaiba/chapters/1-1/008_J1H2.png");
    testUrlsPage.add(
        "https://img33.imgslib.link//manga/kimetsu-no-yaiba/chapters/1-1/008_J1H2.png");
    testUrlsPage.add(
        "https://img33.imgslib.link//manga/kimetsu-no-yaiba/chapters/1-1/007_eet9.png");

    testChapters.add(Chapter(
      title: "Chapter 1",
      description: "Description Chapter",
      urlsPage: testUrlsPage,
    ));

    testChapters.add(Chapter(
      title: "Chapter 2",
      description: "Description Chapter",
      urlsPage: testUrlsPage,
    ));

    testChapters.add(Chapter(
      title: "Chapter 3",
      description: "Description Chapter",
      urlsPage: testUrlsPage,
    ));

    testChapters.add(Chapter(
      title: "Chapter 4",
      description: "Description Chapter",
      urlsPage: testUrlsPage,
    ));

    testChapters.add(Chapter(
      title: "Chapter 5",
      description: "Description Chapter",
      urlsPage: testUrlsPage,
    ));

    mangas.add(Manga(
      url:
          "https://cdn.myanimelist.net/r/167x242/images/manga/1/12193.webp?s=a233ddc40dc03f65009dd65ae3acacbb",
      title: "Manga from interesting source 1",
      date: "2004",
      author: "name author",
      chapters: testChapters,
    ));
    mangas.add(Manga(
      url:
          "https://cdn.myanimelist.net/r/167x242/images/manga/2/49363.webp?s=d032b3cef8bb51e329f699c4ccfa6f8f",
      title: "Manga from interesting source 2",
      date: "2006",
      author: "name author",
      chapters: testChapters,
    ));
    mangas.add(Manga(
      url:
          "https://cdn.myanimelist.net/r/167x242/images/manga/2/178011.webp?s=d425cc275bcb844380469d59935a4014",
      title: "Manga from not interesting source 1",
      date: "2009",
      author: "name author",
      chapters: testChapters,
    ));
    // await FirebaseFirestore.instance
    //     .collection('gallery')
    //     .get()
    //     .then((QuerySnapshot querySnapshot) {
    //   querySnapshot.docs.forEach((QueryDocumentSnapshot doc) {
    //     images.add(Manga.fromDoc(doc));
    //   });
    // });
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
                            mangaList[index].date,
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
                            Icon(Icons.star),
                            Text("Save"),
                            SizedBox(width: 24),
                            Icon(Icons.favorite),
                            Text("Like"),
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
