import 'dart:async';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_photo/google_photo/google_photo_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:media_picker_widget/media_picker_widget.dart';

import '../../google_photo/google_photo.dart';
import '../../shared/error.dart';
import '../media_item_factory.dart';
import 'media_item/album_media_item_view.dart';

part 'album_create_page_event.dart';

part 'album_create_page_state.dart';

@injectable
class AlbumCreatePageBloc
    extends Bloc<AlbumCreatePageEvent, AlbumCreatePageState> {
  final MediaItemFactory _mediaItemFactory;
  final GooglePhotoRepository _googlePhotoRepository;

  late void Function(Media) onMediaItemPressed;
  late void Function(Media, String) onMediaItemUploaded;

  AlbumCreatePageBloc(
    this._mediaItemFactory,
    this._googlePhotoRepository,
  ) : super(const AlbumCreateLoading()) {
    on<CreateAlbum>(_onCreateAlbum);
    on<UpdateAlbum>(_onUpdateAlbum);
    on<CreateMediaItem>(_onCreateMediaItem);
    on<UploadMedia>(_onUploadMedia);
  }

  void setOnMediaItemPressed(void Function(Media) onMediaItemPressed) {
    this.onMediaItemPressed = onMediaItemPressed;
  }

  void setOnMediaItemUploaded(
      void Function(Media, String) onMediaItemUploaded) {
    this.onMediaItemUploaded = onMediaItemUploaded;
  }

  FutureOr<void> _onCreateMediaItem(
    CreateMediaItem event,
    Emitter<AlbumCreatePageState> emit,
  ) async {
    try {
      await _googlePhotoRepository.createMediaItems(
        albumId: event.albumId,
        newMediaItems: [
          NewMediaItem(
            simpleMediaItem: SimpleMediaItem(
              uploadToken: event.uploadToken,
            ),
          )
        ],
      );
    } catch (e) {
      _onError(e, emit);
    }
  }

  FutureOr<void> _onUploadMedia(
    UploadMedia event,
    Emitter<AlbumCreatePageState> emit,
  ) async {
    final mediaList = event.mediaList;
    final albumMediaItemView = _mediaItemFactory
        .generateAlbumMediaItemViews(
          mediaList,
          onMediaItemPressed,
          onMediaItemUploaded,
        )
        .toList(growable: false);

    emit(UploadingMedia(albumMediaItemView));
  }

  FutureOr<void> _onCreateAlbum(
    CreateAlbum event,
    Emitter<AlbumCreatePageState> emit,
  ) async {
    emit(const AlbumCreateLoading(isLoading: true));
    try {
      final album = await _googlePhotoRepository
          .createAlbum(Album(title: event.albumTitle));

      emit(AlbumCreated(album.id!));
    } catch (e) {
      _onError(e, emit);
    } finally {
      emit(const AlbumCreateLoading(isLoading: false));
    }
  }

  FutureOr<void> _onUpdateAlbum(
    UpdateAlbum event,
    Emitter<AlbumCreatePageState> emit,
  ) async {
    emit(const AlbumCreateLoading(isLoading: true));
    try {
      final album = await _googlePhotoRepository.updateAlbum(
        Album(title: event.albumTitle, id:  event.albumId),
        updateMask: 'title',
      );

      emit(AlbumCreated(album.id!));
    } catch (e) {
      _onError(e, emit);
    } finally {
      emit(const AlbumCreateLoading(isLoading: false));
    }
  }

  void _onError(Object e, Emitter<AlbumCreatePageState> emit) {
    if (e is DioError && e.response?.statusCode == 401) {
      emit(AlbumCreateError(UnauthorizedError()));
    } else {
      emit(AlbumCreateError(AppError()));
    }
  }
}
