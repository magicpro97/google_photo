import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../google_photo/google_photo.dart';

enum ViewType {
  image,
  video;
}

class MediaItemView extends StatelessWidget {
  const MediaItemView({
    Key? key,
    required this.mediaItem,
    required this.type,
    this.thumbnailFile,
  }) : super(key: key);

  final MediaItem mediaItem;
  final ViewType type;
  final String? thumbnailFile;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: mediaItem.id,
      child: Column(
        children: [
          Visibility(
            visible: type == ViewType.image,
            child: CachedNetworkImage(
              imageUrl: mediaItem.productUrl,
              fit: BoxFit.cover,
              errorWidget: (_, __, ___) => const ErrorImageView(),
            ),
          ),
          Visibility(
            visible: type == ViewType.video && thumbnailFile != null,
            child: Image.file(
              File(thumbnailFile!),
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const ErrorImageView(),
            ),
          ),
        ],
      ),
    );
  }
}

class ErrorImageView extends StatelessWidget {
  const ErrorImageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Icon(
        Icons.error,
        size: 48,
        color: Colors.red,
      ),
    );
  }
}
