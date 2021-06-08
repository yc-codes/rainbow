import 'package:flutter/material.dart';

class ImageScreen extends StatefulWidget {
  const ImageScreen({Key? key}) : super(key: key);

  @override
  _ImageScreenState createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  String _imageUrl =
      "https://i.picsum.photos/id/1072/800/800.jpg?hmac=SEliElmTkRkR4Hy9Leoe-_fnW1XyyyHAViKvfwgtjc0";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints(),
        color: Colors.grey[100],
        alignment: Alignment.center,
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Image.network(_imageUrl),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: OutlinedButton(
                onPressed: () {},
                child: Text(
                  'Generate',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText1!.color,
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
