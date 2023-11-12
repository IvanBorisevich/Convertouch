import 'package:flutter/material.dart';

class ConvertouchCheckbox extends StatelessWidget {
  final bool value;
  final double size;
  final Color color;
  final Color colorChecked;

  const ConvertouchCheckbox(
    this.value, {
    this.size = 15,
    this.color = Colors.blueAccent,
    this.colorChecked = const Color(0xFF1D4D9D),
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size),
        border: Border.all(
          color: value ? colorChecked : color,
          width: 1,
        ),
        color: value ? colorChecked : Colors.transparent,
      ),
      child: Icon(
        Icons.check_outlined,
        size: size,
        color: value ? Colors.white : Colors.transparent,
      ),
    );
  }
}
