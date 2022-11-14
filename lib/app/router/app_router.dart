import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../home/home_page.dart';
import '../../home/photo_detail/photo_detail_page.dart';
import '../../login/login_page.dart';

part 'app_router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(
      page: LoginPage,
      initial: true,
    ),
    AutoRoute(
      page: HomePage,
      children: [
        AutoRoute(page: PhotoDetailPage, path: 'photo/:id'),
      ],
    ),
  ],
)
// extend the generated private router
class AppRouter extends _$AppRouter {}
