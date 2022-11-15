import 'dart:async';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_photo/google_photo/google_photo_repository.dart';
import 'package:google_photo/home/media_item_factory.dart';
import 'package:google_photo/shared/error.dart';
import 'package:injectable/injectable.dart';
import 'package:media_picker_widget/media_picker_widget.dart';

import '../generated/l10n.dart';
import 'media_item_view.dart';

part 'home_page_event.dart';

part 'home_page_state.dart';

@injectable
class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc(
    this._googlePhotoRepository,
    this._mediaItemFactory,
  ) : super(const HomePageLoading(false)) {
    on<GetMediaItems>(_onGetMediaItems);
    on<UploadMedia>(_onUploadMedia);

    add(GetMediaItems());
  }

  final GooglePhotoRepository _googlePhotoRepository;
  final MediaItemFactory _mediaItemFactory;

  FutureOr<void> _onGetMediaItems(
    GetMediaItems event,
    Emitter<HomePageState> emit,
  ) async {
    emit(const HomePageLoading(true));

    try {
      final response = await _googlePhotoRepository.getMediaItem();

      emit(HomePageMediaItemLoaded(await _mediaItemFactory
          .generateMediaItemViews(response.mediaItems ?? [])));
    } catch (e) {
      if (e is DioError && e.response?.statusCode == 401) {
        emit(HomePageError(UnauthorizedError('')));
      } else {
        emit(HomePageError(AppError(S.current.something_happened)));
      }
    } finally {
      emit(const HomePageLoading(false));
    }
  }

  FutureOr<void> _onUploadMedia(
    UploadMedia event,
    Emitter<HomePageState> emit,
  ) {

  }
}
