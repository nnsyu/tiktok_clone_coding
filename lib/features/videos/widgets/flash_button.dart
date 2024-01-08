import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class FlashButton extends StatelessWidget {
  final bool isSelect;
  final VoidCallback setFlashMode;
  final IconData icon;

  const FlashButton({
    super.key,
    required this.isSelect, required this.setFlashMode, required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: isSelect ? Colors.amber.shade500 : Colors.white,
      onPressed: setFlashMode,
      icon: Icon(
        icon,
      ),
    );
  }
}
