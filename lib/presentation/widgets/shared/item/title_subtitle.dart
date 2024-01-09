import 'package:flutter/material.dart';

class TitleSubtitle extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final double? titleFontSize;
  final FontWeight? titleFontWeight;
  final double? subtitleFontSize;
  final Color? subtitleFontColor;
  final double? horizontalPadding;

  const TitleSubtitle({
    super.key,
    this.title,
    this.subtitle,
    this.titleFontSize,
    this.subtitleFontSize,
    this.subtitleFontColor,
    this.titleFontWeight,
    this.horizontalPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: (horizontalPadding != null) ? horizontalPadding! : 10,
      ),
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
          if (title != null)
            Expanded(
              child: Text(
                title!,
                maxLines: 1,
                style: TextStyle(
                  fontSize: (titleFontSize != null) ? titleFontSize : 18,
                  fontWeight: (titleFontWeight != null)
                      ? titleFontWeight
                      : FontWeight.w600,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          const Spacer(),
          if (subtitle != null)
            Text(
              subtitle!,
              textAlign: TextAlign.end,
              style: TextStyle(
                fontSize: (subtitleFontSize != null) ? subtitleFontSize : 14,
                fontWeight: FontWeight.w400,
                color: (subtitleFontColor != null)
                    ? subtitleFontColor
                    : Colors.white,
              ),
            ),
        ],
      ),
    );
  }
}
