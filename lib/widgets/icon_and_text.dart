

import 'package:flutter/cupertino.dart';
import 'package:invited_project/widgets/small_txt.dart';

import '../utils/colors.dart';

class IconAndText extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color? color;
  final Color iconColor;
  const IconAndText({Key? key,
    required this.icon,
    required this.text,
    this.color = AppColors.BigText,
    required this.iconColor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: iconColor ,),
        const SizedBox(width: 0,),
        SmallText(text: text, color: color,)
      ],
    );
  }
}
