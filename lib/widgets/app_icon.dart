import 'package:flutter/cupertino.dart';

class AppIcon extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final double size;
  const AppIcon({Key? key,
    required this.icon,
    this.backgroundColor = const Color(0xFF388E3C),
    this.iconColor = const Color(0x8A000000),
    this.size = 40
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size/2),
        color: backgroundColor
      ),
      child:Icon(
        icon,
        color: iconColor,
        size: 16,
      ),
    );
  }
}
