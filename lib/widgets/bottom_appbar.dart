import 'package:flutter/material.dart';

class BottomAppbarWidget extends StatelessWidget {
  const BottomAppbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 8,
      color: Color(0xff1565C0),
      child: IconTheme(
        data: IconThemeData(color: Colors.white),
        child: Row(
          children: <Widget>[
            IconButton(
              tooltip: 'Menu',
              icon: const Icon(Icons.menu_rounded),
              onPressed: () {},
            ),
            IconButton(
              tooltip: 'Tim kiem',
              icon: const Icon(Icons.search_rounded),
              onPressed: () {},
            ),
            IconButton(
              tooltip: 'Yeu thich',
              icon: const Icon(Icons.star_rounded),
              onPressed: () {},
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
