import 'package:flutter/material.dart';
import 'package:training_app/data/app_preferences.dart';

class PreferencesScreen extends StatefulWidget {
  const PreferencesScreen({Key? key}) : super(key: key);

  @override
  State<PreferencesScreen> createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<PreferencesScreen> {
  int displayAge = 0;
  String displayName = '';
  AppPreferences appPreferences = AppPreferences();
  TextEditingController userInput = TextEditingController();

  @override
  void initState() {
    appPreferences.init().then((value) {
      setState(() {
        displayAge = appPreferences.getUserAge();
        displayName = appPreferences.getUserName();
        userInput.text = displayName;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
              '${displayName == '' ? 'No name registered' : displayName} ${displayAge == 0 ? 'No age registered' : displayAge}'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PreferenceScreenButton(
                  text: 'Decrease Age', onTap: () => decreaseAge()),
              PreferenceScreenButton(
                  text: 'Increase Age', onTap: () => increaseAge()),
              PreferenceScreenButton(
                  text: 'Delete Age', onTap: () => deleteAge())
            ],
          ),
          Container(
              width: 300,
              height: 50,
              child: TextFormField(
                  controller: userInput,
                  style: const TextStyle(
                    fontSize: 24,
                    color: Colors.blue,
                    fontWeight: FontWeight.w600,
                  ),
                  onFieldSubmitted: (newValue) => setName(newValue))),
        ],
      ),
    ));
  }

  setAge(int age) {
    setState(() {
      displayAge = age;
      appPreferences.setUserAge(age);
    });
  }

  increaseAge() {
    setState(() => displayAge++);
    appPreferences.setUserAge(displayAge);
  }

  decreaseAge() {
    displayAge = displayAge < 1 ? 1 : displayAge;
    setState(() => displayAge--);
    appPreferences.setUserAge(displayAge);
  }

  deleteAge() {
    setState(() => displayAge = 0);
    appPreferences.removeUserAge();
  }

  setName(String name) {
    setState(() {
      displayName = name;
      appPreferences.setUserName(name);
    });
  }

  deleteName() {
    appPreferences.removeUserName();
  }
}

class PreferenceScreenButton extends StatefulWidget {
  const PreferenceScreenButton(
      {super.key, required this.text, required this.onTap});
  final String text;
  final VoidCallback onTap;

  @override
  State<PreferenceScreenButton> createState() => _PreferenceScreenButtonState();
}

class _PreferenceScreenButtonState extends State<PreferenceScreenButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GestureDetector(
          onTap: widget.onTap,
          child: Container(
            width: 100,
            height: 100,
            color: Colors.amber,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Text(widget.text,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                    )),
              ),
            ),
          )),
    );
  }
}
