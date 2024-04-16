import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gallery_poc/extensions/string_extensions.dart';
import 'package:gallery_poc/models/image.dart';
import 'package:gallery_poc/utils/shorten_number.dart';
import 'package:gallery_poc/widgets/detail_chip.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsModalBottomSheet extends StatelessWidget {
  final HitImage image;
  const DetailsModalBottomSheet({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Container(
        height: isPortrait ? screenHeight * .35 : screenWidth * .35,
        width: double.maxFinite,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  Colors.purple[50]!.withOpacity(0.9),
                  Colors.blue[50]!.withOpacity(0.9)
                ]),
            borderRadius: const BorderRadius.only(
                topLeft: Radius.elliptical(10, 5),
                topRight: Radius.elliptical(10, 5))),
        child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                      height: 5,
                      width: 50,
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(20))))),
          const Text('Details', style: TextStyle(fontSize: 20)),
          const SizedBox(height: 5),
          Text('Type: ${image.type.capitalize()}',
              style: TextStyle(color: Colors.grey[700]!)),
          const SizedBox(height: 5),
          Row(children: [
            Text('Width: ${image.width}',
                style: TextStyle(color: Colors.grey[700]!)),
            const SizedBox(width: 10),
            Text('Height: ${image.height}',
                style: TextStyle(color: Colors.grey[700]!))
          ]),
          const SizedBox(height: 5),
          Text('Tags: ', style: TextStyle(color: Colors.grey[700]!)),
          const SizedBox(height: 5),
          Wrap(
              runSpacing: 5,
              children: image.tags
                  .map((tag) => Container(
                      margin: const EdgeInsets.only(right: 5),
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.grey[700]!)),
                      child: Text(tag.capitalize())))
                  .toList()),
          const SizedBox(height: 10),
          Row(children: [
            DetailChip(
                value: shortenNumber(image.likes),
                color: Colors.red,
                icon: FaIcon(FontAwesomeIcons.solidHeart,
                    color: Colors.grey[200]!, size: 15)),
            const SizedBox(width: 10),
            DetailChip(
                value: shortenNumber(image.views),
                color: Colors.blue,
                icon: FaIcon(FontAwesomeIcons.eye,
                    color: Colors.grey[200]!, size: 15)),
            IconButton(
                onPressed: () {
                  launchUrl(Uri.parse(image.pageUrl),
                      mode: LaunchMode.externalApplication);
                },
                icon: const Icon(Icons.open_in_new))
          ])
        ])));
  }
}
