import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../google_photo/google_photo.dart';
import '../../shared/widgets/error_image_view.dart';

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
          child: Card(
            elevation: 10,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4.0 ),
              child: CachedNetworkImage(
                imageUrl: mediaItem.baseUrl,
                fit: BoxFit.cover,
                errorWidget: (_, __, ___) => const ErrorImageView(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
