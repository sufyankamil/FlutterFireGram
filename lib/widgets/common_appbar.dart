import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor;
  final Color primaryColor;
  final IconData icon;
  final Function()? messengerButtonCallback;

  const CommonAppBar({
    super.key,
    required this.backgroundColor,
    required this.primaryColor,
    this.messengerButtonCallback,
    required this.icon,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: backgroundColor,
      centerTitle: false,
      title: SvgPicture.asset(
        'assets/images/ic_instagram.svg',
        color: primaryColor,
        height: 32,
      ),
      actions: [
        IconButton(
          onPressed: messengerButtonCallback,
          icon: Icon(
            icon,
            color: primaryColor,
          ),
        ),
      ],
    );
  }
}
