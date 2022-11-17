import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_picker_widget/media_picker_widget.dart';

part 'album_create_page_event.dart';

part 'album_create_page_state.dart';

class AlbumCreatePageBloc
    extends Bloc<AlbumCreatePageEvent, AlbumCreatePageState> {
  AlbumCreatePageBloc() : super(AlbumCreatePageInitial()) {
    on<AlbumCreatePageEvent>((event, emit) {});
  }
}
