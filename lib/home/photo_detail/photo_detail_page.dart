import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../../google_photo/google_photo.dart';

class PhotoDetailPage extends StatefulWidget {
  const PhotoDetailPage({
    Key? key,
    this.mediaItems = const [],
    this.initialIndex,
  }) : super(key: key);

  final List<MediaItem> mediaItems;
  final int? initialIndex;

  @override
  State<PhotoDetailPage> createState() => _PhotoDetailPageState();
}

class _PhotoDetailPageState extends State<PhotoDetailPage> {
  late final _pageController =
      PageController(initialPage: widget.initialIndex ?? 0);
  late final List<MediaItem> _mediaItems = widget.mediaItems;

  void _onBackPressed() {
    context.router.pop(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PhotoViewGallery.builder(
            scrollPhysics: const BouncingScrollPhysics(),
            builder: (BuildContext context, int index) {
              final mediaItem = _mediaItems[index];
              // if (mediaItem.mediaMetadata.video != null) {
              //   return PhotoViewGalleryPageOptions.customChild(
              //     child: VideoView(
              //       url: mediaItem.productUrl,
              //     ),
              //   );
              // }

              return PhotoViewGalleryPageOptions(
                imageProvider: CachedNetworkImageProvider(
                    mediaItem.baseUrl ?? mediaItem.productUrl),
                initialScale: PhotoViewComputedScale.contained,
                heroAttributes: PhotoViewHeroAttributes(tag: mediaItem.id),
              );
            },
            itemCount: _mediaItems.length,
            loadingBuilder: (context, event) => const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
            pageController: _pageController,
          ),
          SafeArea(
            child: IconButton(
              onPressed: _onBackPressed,
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
