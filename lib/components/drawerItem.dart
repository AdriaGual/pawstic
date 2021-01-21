import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  final IconData icon;
  final String text;
  DrawerItem(this.text, this.icon);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 30,
          ),
          SizedBox(
            width: 10,
          ),
          Text(text,
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'PoppinsSemiBold',
                  fontSize: 18))
        ],
      ),
    );
  }
}
