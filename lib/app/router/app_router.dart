import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../google_photo/google_photo.dart';
import '../../home/home_page.dart';
import '../../home/photo_detail/photo_detail_page.dart';
import '../../login/login_page.dart';

part 'app_router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(
      path: '/login',
      page: LoginPage,
      initial: true,
    ),
    AutoRoute(
      path: '',
      page: HomePage,
    ),
    AutoRoute(
      page: PhotoDetailPage,
      path: '/photos',
      name: 'PhotoDetailRoute',
    ),
  ],
)
// extend the generated private router
class AppRouter extends _$AppRouter {}
