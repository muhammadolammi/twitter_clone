import 'package:flutter/material.dart';
import 'package:twitter_clone/theme/theme.dart';

class RoundedSmallButton extends StatelessWidget {
  final VoidCallback onTap;
  final String label;
  final Color backGroundColor;
  final Color labelColor;

  const RoundedSmallButton(
      {super.key,
      required this.onTap,
      required this.label,
      this.backGroundColor = Pallete.whiteColor,
      this.labelColor = Pallete.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Chip(
        label: Text(
          label,
          style: TextStyle(
            color: labelColor,
          ),
        ),
        backgroundColor: backGroundColor,
        labelPadding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 5,
        ),
      ),
    );
  }
}
