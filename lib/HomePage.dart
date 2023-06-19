//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'Manga.dart';
class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  List<Manga> imageList = [];

  @override
  Widget build(BuildContext context) {
    //CollectionReference gallery = FirebaseFirestore.instance.collection('gallery');
    return Scaffold(
      appBar: AppBar(
        title: Text("Gallery"),
      ),
      body: FutureBuilder<List<Manga>>(
        //body: FutureBuilder<DocumentSnapshot>(
        /// Initialize FlutterFire:
        future: getImage(),
        builder: (BuildContext context, snapshot) {
          /// if Error
          if (snapshot.hasError) {
            //print(checkIfDocExists());
            return Text('${snapshot.error}');
          }

          /// On completion
          // if (snapshot.connectionState == ConnectionState.done) {
          //   imageList = snapshot.data!;
          //   return buildGrid(imageList);
          // }

          /// On Loading
          return Center(
              child: CircularProgressIndicator(
                strokeWidth: 3,
              ));
        },
      ),
    );
  }

  Future<List<Manga>> getImage() async {
    List<Manga> images = [];

    // await FirebaseFirestore.instance
    //     .collection('gallery')
    //     .get()
    //     .then((QuerySnapshot querySnapshot) {
    //   querySnapshot.docs.forEach((QueryDocumentSnapshot doc) {
    //     images.add(Manga.fromDoc(doc));
    //   });
    // });
    return images;
  }
}
//   Widget buildGrid(List<Manga> imageList) {
//     return RefreshIndicator(
//       onRefresh: () async{
//         imageList=[];
//         await getImage();
//         setState(() {});
//         return Future.value();
//       },
//       child: GridView.builder(
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             childAspectRatio: 0.70,
//           ),
//           itemCount: imageList.length,
//           itemBuilder: (BuildContext context, int index) {
//             return InkWell(
//               onTap: () {
//                 Navigator.push(context, MangaRouter.getRoute(imageList[index]));
//               },
//               child: Card(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Image.network(
//                       imageList[index].image,
//                       fit: BoxFit.cover,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Text(
//                         imageList[index].title,
//                         style: TextStyle(fontSize: 24),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Row(
//                         children: [
//                           Icon(Icons.remove_red_eye),
//                           SizedBox(
//                             width: 8,
//                           ),
//                           Text('${imageList[index].views}'),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           }),
//     );
//   }
// }
//
// class GalleryRouter extends StatelessWidget {
//   final Manga gallery;
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