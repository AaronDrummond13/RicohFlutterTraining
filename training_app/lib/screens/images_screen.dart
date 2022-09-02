import 'package:flutter/material.dart';
import 'package:training_app/data/app_preferences.dart';
import 'package:training_app/data/sembast_db.dart';
import 'package:training_app/models/images.dart';
import 'package:training_app/models/images_list_view.dart';
import 'package:training_app/screens/images_selection_screen.dart';

class ImagesScreen extends StatefulWidget {
  const ImagesScreen({super.key});

  @override
  State<ImagesScreen> createState() => _ImagesScreenState();
}

class _ImagesScreenState extends State<ImagesScreen> {
  late Images images;
  late SembastDB db;
  String userName = '';
  AppPreferences appPreferences = AppPreferences();

  @override
  void initState() {
    appPreferences.init().then((value) {
      setState(() {
        userName = appPreferences.getUserName();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ImagesListView(key: UniqueKey()),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return ImagesSelectionScreen(
                    images: Images('', ''), isNew: true);
              }).then((value) {
            setState(() {});
          });
        },
      ),
    );
  }
}
