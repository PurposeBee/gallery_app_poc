import 'package:flutter/material.dart';
import 'package:gallery_poc/models/image.dart';
import 'package:gallery_poc/screens/ImageView/widgets/details_modal_bottom_sheet.dart';
import 'package:photo_view/photo_view.dart';

class ImageView extends StatelessWidget {
  final int heroTag;
  final ImageProvider imageData;
  final HitImage image;
  const ImageView(
      {super.key,
      required this.heroTag,
      required this.imageData,
      required this.image});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    void showDetails() {
      showModalBottomSheet(
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          context: context,
          builder: (context) => DetailsModalBottomSheet(image: image));
    }

    return Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
            surfaceTintColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back, color: Colors.white))),
        body: Hero(
            tag: heroTag,
            child: Stack(children: [
              PhotoView(imageProvider: imageData, minScale: 0.28),
              Positioned(
                  bottom: 0,
                  child: GestureDetector(
                      onVerticalDragEnd: (details) => showDetails(),
                      child: Container(
                          height: 100,
                          width: screenWidth,
                          color: Colors.transparent))),
              Positioned(
                  bottom: 50,
                  left: screenWidth * .4,
                  child: OutlinedButton(
                      style:
                          OutlinedButton.styleFrom(shape: const CircleBorder()),
                      onPressed: showDetails,
                      child: const Icon(Icons.keyboard_double_arrow_up_sharp,
                          color: Colors.white)))
            ])));
  }
}
