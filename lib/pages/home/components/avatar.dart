import 'package:flutter/material.dart';

class Avatar extends StatefulWidget {
  final String src;
  final double size;

  const Avatar({
    Key? key,
    required this.src,
    this.size = 70.0, // 设置默认的头像大小
  }) : super(key: key);

  @override
  _AvatarState createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {
  late String _imageUrl;

  @override
  void initState() {
    super.initState();
    _imageUrl = widget.src;
  }

  void updateImageUrl(String newImageUrl) {
    setState(() {
      _imageUrl = newImageUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Image.network(
        _imageUrl,
        width: widget.size,
        height: widget.size,
        fit: BoxFit.cover,
        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) {
            return child;
          } else {
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                    : null,
              ),
            );
          }
        },
        errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
          return Icon(
            Icons.error,
            size: widget.size,
          );
        },
      ),
    );
  }
}
