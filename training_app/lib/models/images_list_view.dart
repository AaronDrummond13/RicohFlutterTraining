import 'package:flutter/material.dart';
import 'package:training_app/data/sembast_db.dart';

import '../screens/images_selection_screen.dart';
import 'images.dart';

class ImagesListView extends StatefulWidget {
  const ImagesListView({super.key});

  @override
  State<ImagesListView> createState() => _ImagesListViewState();
}

class _ImagesListViewState extends State<ImagesListView> {
  late SembastDB sembastDB = SembastDB();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getImages(),
        builder: (context, snapshot) {
          var images = snapshot.data ?? [];
          return ListView.builder(
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => showDialog(
                    context: context,
                    builder: (context) {
                      return ImagesSelectionScreen(
                          images: snapshot.data[index], isNew: false);
                    }).then((value) {
                  setState(() {});
                }),
                child: Container(
                  child: Text(images[index].name),
                ),
              );
            },
            itemCount: images.length,
          );
        });
  }

  Future getImages() async {
    return await sembastDB.getImages();
  }
}
