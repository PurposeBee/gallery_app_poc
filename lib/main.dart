import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gallery_poc/controllers/gallery_controller.dart';
import 'package:gallery_poc/screens/Home/index.dart';
import 'package:provider/provider.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(const GalleryPOC());
}

class GalleryPOC extends StatelessWidget {
  const GalleryPOC({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Gallery POC',
        home: ChangeNotifierProvider<GalleryController>(
            create: (context) => GalleryController(), child: const Home()));
  }
}
