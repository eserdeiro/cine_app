import 'package:flutter/material.dart';

class TitleSubtitle extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final double? titleFontSize;
  final FontWeight? titleFontWeight;
  final double? subtitleFontSize;
  final Color? subtitleFontColor;
  final double? horizontalPadding;
  final Function()? onTapSubtitle;

  const TitleSubtitle({
    super.key,
    this.title,
    this.subtitle,
    this.titleFontSize,
    this.subtitleFontSize,
    this.subtitleFontColor,
    this.titleFontWeight,
    this.horizontalPadding,
    this.onTapSubtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: horizontalPadding ?? 8,
      ),
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        children: [
          if (title != null)
            Text(
              title!,
              maxLines: 1,
              style: TextStyle(
                fontSize: titleFontSize ?? 18,
                fontWeight: titleFontWeight ?? FontWeight.w600,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          const Spacer(),
          if (subtitle != null)
            GestureDetector(
              onTap: onTapSubtitle,
              child: Text(
                subtitle!,
                style: TextStyle(
                fontSize: subtitleFontSize,
                  fontWeight: FontWeight.w400,
                  color: subtitleFontColor,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
