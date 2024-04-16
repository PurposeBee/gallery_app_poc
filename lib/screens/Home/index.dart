import 'package:flutter/material.dart';
import 'package:gallery_poc/controllers/gallery_controller.dart';
import 'package:gallery_poc/screens/Home/widgets/image_item.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final galleryController = Provider.of<GalleryController>(context);
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final sliver = SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: (screenWidth / 170).floor());

    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: const Text('Gallery', style: TextStyle(color: Colors.white)),
            elevation: 10,
            shadowColor: Colors.black,
            flexibleSpace: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: <Color>[Colors.purple, Colors.blue])))),
        body: SingleChildScrollView(
            child: Column(children: [
          Container(
              height: 50,
              margin: const EdgeInsets.all(10),
              child: TextField(
                  onSubmitted: (value) => galleryController.browseImages(),
                  onChanged: (value) {
                    galleryController.setSearchQuery = value;
                  },
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      hintText: 'Explore',
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 20),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: const BorderSide(color: Colors.grey))))),
          SizedBox(
              height: isPortrait ? screenHeight * .75 : screenWidth * .25,
              child: RefreshIndicator(
                  onRefresh: () {
                    galleryController.browseImages();
                    return Future.value();
                  },
                  child: !galleryController.isLoading
                      ? GridView.builder(
                          physics: const ScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: galleryController.images.length,
                          gridDelegate: sliver,
                          itemBuilder: (context, index) {
                            final image = galleryController.images[index];
                            return ImageItem(image: image);
                          })
                      : Center(
                          child: LoadingAnimationWidget.stretchedDots(
                              color: Colors.purple, size: 50))))
        ])));
  }
}
