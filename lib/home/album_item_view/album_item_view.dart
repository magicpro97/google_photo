import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../google_photo/google_photo.dart';
import '../../shared/widgets/error_image_view.dart';

class AlbumItemView extends StatelessWidget {
  const AlbumItemView({
    Key? key,
    required this.onAlbumPressed,
    required this.album,
  }) : super(key: key);

  final Album album;
  final void Function(Album) onAlbumPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Hero(
        tag: album.id,
        child: InkWell(
          onTap: () => onAlbumPressed(album),
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Stack(
                    children: [
                      CachedNetworkImage(
                        imageUrl: album.coverPhotoBaseUrl,
                        fit: BoxFit.cover,
                        errorWidget: (_, __, ___) => const ErrorImageView(),
                      ),
                      Positioned(
                        top: 20,
                        left: 20,
                        child: CachedNetworkImage(
                          imageUrl: album.coverPhotoBaseUrl,
                          fit: BoxFit.cover,
                          errorWidget: (_, __, ___) => const ErrorImageView(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Text(
                album.title,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
