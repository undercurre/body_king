import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final String src;
  final double size;
  final double borderRadius;

  const Avatar({
    Key? key,
    required this.src,
    this.size = 80.0,
    this.borderRadius = 40.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Image.network(
        src,
        width: size,
        height: size,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: size,
            height: size,
            color: Colors.grey.shade200,
            child: Icon(
              Icons.person,
              size: size / 2,
              color: Colors.grey.shade400,
            ),
          );
        },
      ),
    );
  }
}
