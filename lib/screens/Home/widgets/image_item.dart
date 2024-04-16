import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gallery_poc/models/image.dart';
import 'package:gallery_poc/screens/ImageView/index.dart';
import 'package:gallery_poc/utils/shorten_number.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ImageItem extends StatelessWidget {
  final HitImage image;
  const ImageItem({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    final imageWidget = Image.network(image.largeImageUrl,
        height: 110,
        width: 150,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) => SizedBox(
            height: 110,
            width: 150,
            child: loadingProgress == null &&
                    (loadingProgress?.cumulativeBytesLoaded ==
                        (loadingProgress?.expectedTotalBytes ??
                            loadingProgress?.cumulativeBytesLoaded))
                ? child
                : Center(
                    child: LoadingAnimationWidget.waveDots(
                        color: Colors.purple, size: 20))),
        errorBuilder: (context, error, stackTrace) => SizedBox(
            height: 110,
            width: 150,
            child: Center(
                child: Icon(Icons.image_not_supported,
                    color: Colors.purple[200]))));
    return Hero(
        tag: image.id,
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[Colors.purple[50]!, Colors.blue[50]!])),
            margin: const EdgeInsets.all(10),
            child: TextButton(
                style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(8),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6))),
                onPressed: () {
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                          transitionDuration: const Duration(milliseconds: 550),
                          pageBuilder: (_, __, ___) => ImageView(
                              heroTag: image.id,
                              imageData: imageWidget.image,
                              image: image)));
                },
                child: Column(children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: imageWidget),
                  const SizedBox(height: 10),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        child: const FaIcon(FontAwesomeIcons.solidHeart,
                            color: Colors.red, size: 15)),
                    Text(shortenNumber(image.likes),
                        style:
                            TextStyle(fontSize: 12, color: Colors.grey[500])),
                    const SizedBox(width: 10),
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        child: FaIcon(FontAwesomeIcons.eye,
                            color: Colors.blue[800], size: 15)),
                    Text(shortenNumber(image.views),
                        style: TextStyle(fontSize: 12, color: Colors.grey[500]))
                  ])
                ]))));
  }
}
