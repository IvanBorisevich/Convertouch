import 'package:convertouch/presentation/ui/style/color/colors.dart';
import 'package:flutter/material.dart';

class ConvertouchInfoBox extends StatelessWidget {
  final Color background;
  final Color? headerColor;
  final String? headerText;
  final double headerFontSize;
  final Color? bodyColor;
  final String? bodyText;
  final double bodyFontSize;
  final FontWeight bodyFontWeight;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final bool visible;
  final Widget? child;

  const ConvertouchInfoBox({
    this.background = noColor,
    this.headerColor,
    this.headerText,
    this.headerFontSize = 13,
    this.bodyColor,
    this.bodyText,
    this.bodyFontSize = 17,
    this.bodyFontWeight = FontWeight.w500,
    this.padding,
    this.margin,
    this.visible = true,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Container(
        padding: margin,
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: padding,
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              headerText != null
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 3),
                      child: Text(
                        headerText!,
                        style: TextStyle(
                          fontSize: headerFontSize,
                          fontWeight: FontWeight.w600,
                          color: headerColor,
                        ),
                      ),
                    )
                  : const SizedBox(
    height: 0,
    width: 0,
  ),
              bodyText != null
                  ? Text(
                      bodyText!,
                      style: TextStyle(
                        fontSize: bodyFontSize,
                        fontWeight: bodyFontWeight,
                        color: bodyColor,
                      ),
                    )
                  : const SizedBox(
    height: 0,
    width: 0,
  ),
              child ?? const SizedBox(
    height: 0,
    width: 0,
  ),
            ],
          ),
        ),
      ),
    );
  }
}
