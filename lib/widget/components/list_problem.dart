import 'package:flutter/material.dart';

class ListProblem extends StatelessWidget {
  final String title;
  final GestureTapCallback onTap;
  final Border border;
  final Widget trailing;
  const ListProblem({
    super.key,
    required this.title,
    required this.onTap,
    required this.border,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: border,
        ),
        child: ListTile(
          minTileHeight: 10,
          onTap: onTap,
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          trailing: trailing,
        ),
      ),
    );
  }
}
