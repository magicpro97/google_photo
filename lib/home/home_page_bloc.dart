import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_photo/google_photo/google_photo_repository.dart';
import 'package:google_photo/home/media_item_factory.dart';
import 'package:google_photo/shared/error.dart';
import 'package:injectable/injectable.dart';

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
      emit(HomePageError(AppError(S.current.something_happened)));
    } finally {
      emit(const HomePageLoading(false));
    }
  }
}
