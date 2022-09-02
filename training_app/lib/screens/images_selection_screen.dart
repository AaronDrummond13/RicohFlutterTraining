import 'package:flutter/material.dart';
import 'package:training_app/data/sembast_db.dart';
import 'package:training_app/models/images.dart';

class ImagesSelectionScreen extends StatefulWidget {
  final Images images;
  final bool isNew;
  const ImagesSelectionScreen(
      {super.key, required this.images, required this.isNew});

  @override
  State<ImagesSelectionScreen> createState() => _ImagesSelectionScreenState();
}

class _ImagesSelectionScreenState extends State<ImagesSelectionScreen> {
  final TextEditingController txtName = TextEditingController();
  final TextEditingController txtImages = TextEditingController();
  final SembastDB sembastDB = SembastDB();

  @override
  Widget build(BuildContext context) {
    String title = widget.isNew ? 'add images' : 'edit images';
    txtName.text = widget.images.name;
    txtImages.text = widget.images.images;
    return AlertDialog(
      title: Text(title),
      content: Column(
        children: [
          TextField(controller: txtName),
          TextField(controller: txtImages)
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            widget.images.name = txtName.text;
            widget.images.images = txtImages.text;
            widget.isNew
                ? sembastDB.addImages(widget.images)
                : sembastDB.updateImages(widget.images);
            Navigator.of(context).pop();
          },
          child: const Text(
            'Save',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }
}
