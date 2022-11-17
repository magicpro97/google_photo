import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../google_photo/google_photo.dart';

enum ViewType {
  image,
  video;
}

class MediaItemView extends StatelessWidget {
  const MediaItemView({
    Key? key,
    required this.mediaItem,
    required this.type,
    required this.onMediaItemPressed,
  }) : super(key: key);

  final MediaItem mediaItem;
  final ViewType type;
  final void Function(MediaItem) onMediaItemPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Hero(
        tag: mediaItem.id,
        child: InkWell(
          onTap: () => onMediaItemPressed(mediaItem),
          child: CachedNetworkImage(
            imageUrl: mediaItem.baseUrl,
            fit: BoxFit.cover,
            errorWidget: (_, __, ___) => const ErrorImageView(),
          ),
        ),
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
