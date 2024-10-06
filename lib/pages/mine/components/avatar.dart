import 'dart:io';

import 'package:body_king/store/global.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../apis/avatar.dart';
import '../../../apis/models/avatar_res.dart';
import '../../../services/api_response.dart';

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
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _imageUrl = widget.src;
  }

  @override
  void didUpdateWidget(Avatar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.src != widget.src) {
      setState(() {
        _imageUrl = widget.src;
      });
    }
  }

  Future<void> updateImageUrl(File imageFile) async {
    try {
      // 调用上传头像接口
      final response = await AvatarApi().fetchUploadAvatar(imageFile);
      if (response.code == 200) {
        ApiResponse<CreateAvatarResponse> cres = await AvatarApi().fetchCreateAvatar(response.data.url);
        if (cres.code == 200) {
          GlobalState().setAvatar(response.data.url);
        } else {
          // 处理上传失败情况
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('头像上传失败'),
          ));
        }
      } else {
        // 处理上传失败情况
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('头像文件上传失败'),
        ));
      }
    } catch (e) {
      // 处理异常情况
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('头像文件上传异常: $e'),
      ));
    }
  }

  Future<void> _selectImageSource() async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('选择头像', style: TextStyle(fontSize: 18)),
              const SizedBox(height: 20),
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('拍照'),
                onTap: () async {
                  Navigator.of(context).pop();
                  await _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo),
                title: Text('从相册选择'),
                onTap: () async {
                  Navigator.of(context).pop();
                  await _pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      File imageFile = File(image.path);
      await updateImageUrl(imageFile); // 上传图片并更新头像
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _selectImageSource, // 点击头像打开选择图片来源的底部 Sheet
      child: ClipOval(
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
      ),
    );
  }
}
