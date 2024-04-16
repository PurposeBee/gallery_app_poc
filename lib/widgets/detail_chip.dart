import 'package:flutter/material.dart';

class DetailChip extends StatelessWidget {
  final String value;
  final Color color;
  final Widget icon;
  const DetailChip(
      {super.key,
      required this.value,
      required this.color,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 80,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(20)),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[300]!.withOpacity(0.5)),
              child: icon),
          Text(value, style: const TextStyle(color: Colors.white))
        ]));
  }
}
