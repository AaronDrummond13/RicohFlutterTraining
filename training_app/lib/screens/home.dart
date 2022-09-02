import 'package:flutter/material.dart';
import 'package:training_app/data/app_preferences.dart';
import 'package:training_app/screens/preferences_screen.dart';
import 'images_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userName = '';
  AppPreferences appPreferences = AppPreferences();
  @override
  void initState() {
    getSettings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getSettings(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return Scaffold(
            appBar: AppBar(
              title: const Text('TrainingApp'),
            ),
            drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  const DrawerHeader(
                    decoration: BoxDecoration(),
                    child: Text('TrainingApp Menu',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 28,
                        )),
                  ),
                  ListTile(
                    title: const Text(
                      'Preferences',
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PreferencesScreen()));
                    },
                  ),
                  ListTile(
                    title: const Text(
                      'Images',
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ImagesScreen()));
                    },
                  ),
                ],
              ),
            ),
            body: Container());
      },
    );
  }

  Future getSettings() async {
    appPreferences = AppPreferences();
    appPreferences.init().then((value) {
      setState(() {
        userName = appPreferences.getUserName();
      });
    });
  }
}
