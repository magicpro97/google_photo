import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_photo/home/album_create/media_item/album_media_item_view_bloc.dart';
import 'package:media_picker_widget/media_picker_widget.dart';

import '../../../shared/widgets/error_image_view.dart';
import '../../../shared/widgets/full_screen_loading_page.dart';

class AlbumMediaItemView extends StatefulWidget {
  const AlbumMediaItemView({
    Key? key,
    required this.mediaItem,
    required this.onMediaItemPressed,
    required this.onMediaItemUploaded,
  }) : super(key: key);

  final Media mediaItem;
  final void Function(Media) onMediaItemPressed;
  final void Function(Media, String) onMediaItemUploaded;

  @override
  State<AlbumMediaItemView> createState() => _AlbumMediaItemViewState();
}

class _AlbumMediaItemViewState extends State<AlbumMediaItemView> {
  late final _albumMediaItemViewBloc = context.read<AlbumMediaItemViewBloc>();

  void _loadingListener(
    BuildContext context,
    AlbumMediaItemViewState state,
  ) {
    if (state is UploadProgress && state.uploadToken != null) {
      widget.onMediaItemUploaded(widget.mediaItem, state.uploadToken!);
    }
  }

  @override
  void initState() {
    super.initState();
    _albumMediaItemViewBloc.add(Upload(
      mediaItem: widget.mediaItem,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: widget.mediaItem.id!,
      child: GestureDetector(
        onTap: () => widget.onMediaItemPressed(widget.mediaItem),
        child: Stack(
          children: [
            Card(
              elevation: 10,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4.0),
                child: Image.memory(
                  widget.mediaItem.thumbnail!,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const ErrorImageView(),
                ),
              ),
            ),
            BlocConsumer<AlbumMediaItemViewBloc, AlbumMediaItemViewState>(
              listener: _loadingListener,
              builder: _loadingBuilder,
            ),
          ],
        ),
      ),
    );
  }

  Widget _loadingBuilder(BuildContext context, AlbumMediaItemViewState state) {
    var progress = 0.0;
    if (state is UploadProgress) {
      progress = state.progress;
    }
    return LoadingOverlay(
      loadCondition: progress < 1,
      progress: progress,
    );
  }
}
