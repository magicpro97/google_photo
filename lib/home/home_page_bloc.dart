import 'dart:async';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_photo/google_photo/google_photo.dart';
import 'package:injectable/injectable.dart';
import 'package:media_picker_widget/media_picker_widget.dart';

import '../google_photo/google_photo_repository.dart';
import '../shared/error.dart';
import 'album_list/album_item_view.dart';
import 'media_item_factory.dart';
import 'photo_list/media_item_view.dart';

part 'home_page_event.dart';

part 'home_page_state.dart';

@injectable
class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final GooglePhotoRepository _googlePhotoRepository;
  final MediaItemFactory _mediaItemFactory;

  late void Function(Album) onAlbumItemPressed;

  HomePageBloc(
    this._googlePhotoRepository,
    this._mediaItemFactory,
  ) : super(const HomePageLoading()) {
    on<GetAlbums>(_onGetAlbums);
  }

  void setOnAlbumItemPressed(void Function(Album) onAlbumItemPressed) {
    this.onAlbumItemPressed = onAlbumItemPressed;
  }

  FutureOr<void> _onGetAlbums(
    GetAlbums event,
    Emitter<HomePageState> emit,
  ) async {
    final loadType = event.loadType;
    emit(HomePageLoading(isLoading: true, loadType: loadType));

    try {
      final response = await _googlePhotoRepository.getAlbums(
        pageToken: event.nextPageToken,
      );

      emit(HomePageAlbumsLoaded(
        albumItemViews: _mediaItemFactory.generateAlbumViews(
          response.albums ?? [],
          onAlbumItemPressed,
        ),
        loadType: loadType,
        nextPageToken: response.nextPageToken,
      ));
    } catch (e) {
      _onError(e, emit);
      emit(HomePageAlbumsLoaded(
        loadType: loadType,
        hasError: true,
      ));
    } finally {
      emit(HomePageLoading(isLoading: false, loadType: loadType));
    }
  }

  void _onError(Object e, Emitter<HomePageState> emit) {
    if (e is DioError && e.response?.statusCode == 401) {
      emit(HomePageError(UnauthorizedError()));
    } else {
      emit(HomePageError(AppError()));
    }
  }
}
