import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:komdigi_logbooks_supervisors/core/components/spaces.dart';

class MenuButton extends StatelessWidget {
  final String label;
  final String iconPath;
  final Color color;
  final VoidCallback onPressed;

  const MenuButton({
    super.key,
    required this.label,
    required this.iconPath,
    required this.onPressed,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18.0),
          color: color,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              iconPath,
              width: 40.0,
              height: 40.0,
            ),
            const SpaceHeight(16.0),
            Text(
              label,
              style: const TextStyle(fontSize: 16.0),
            )
          ],
        ),
      ),
    );
  }
}
