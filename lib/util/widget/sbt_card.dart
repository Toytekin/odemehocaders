import 'package:flutter/material.dart';

class SbtCard extends StatelessWidget {
  final String title;
  final String subTitle;
  final Icon icon;
  final bool odemeDurumu;
  const SbtCard({
    super.key,
    required this.title,
    required this.subTitle,
    required this.icon,
    this.odemeDurumu = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: odemeDurumu ? Colors.greenAccent : Colors.white,
      child: ListTile(
        title: Text(title),
        subtitle: Text(
          subTitle,
        ),
        leading: icon,
      ),
    );
  }
}
