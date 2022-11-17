import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app/di/dependencies.dart';
import '../photo_list/photo_list_bloc.dart';
import '../photo_list/photo_list_view.dart';

class AlbumPage extends StatelessWidget with AutoRouteWrapper {
  const AlbumPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  final String id;

  @override
  Widget build(BuildContext context) {
    return PhotoListView(
      albumId: id,
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<PhotoListBloc>(
      create: (_) => getIt(),
      child: this,
    );
  }
}
