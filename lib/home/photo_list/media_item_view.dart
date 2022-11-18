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
    required this.onMediaItemPressed,
  }) : super(key: key);

  final MediaItem mediaItem;
  final void Function(MediaItem) onMediaItemPressed;

  @override
  Widget build(BuildContext context) {
    return Hero(
        tag: mediaItem.id,
        child: GestureDetector(
          onTap: () => onMediaItemPressed(mediaItem),
          child: Material(
            child: Card(
              elevation: 10,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4.0),
                child: CachedNetworkImage(
                  imageUrl: mediaItem.baseUrl ?? mediaItem.productUrl,
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
