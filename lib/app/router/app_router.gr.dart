// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

part of 'app_router.dart';

class _$AppRouter extends RootStackRouter {
  _$AppRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    LoginRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const LoginPage()),
      );
    },
    HomeRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const HomePage()),
      );
    },
    PhotoDetailRoute.name: (routeData) {
      final args = routeData.argsAs<PhotoDetailRouteArgs>(
          orElse: () => const PhotoDetailRouteArgs());
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: PhotoDetailPage(
          key: args.key,
          mediaItems: args.mediaItems,
          initialIndex: args.initialIndex,
        ),
      );
    },
    AlbumRoute.name: (routeData) {
      final args = routeData.argsAs<AlbumRouteArgs>();
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: WrappedRoute(
            child: AlbumPage(
          key: args.key,
          id: args.id,
        )),
      );
    },
    AlbumCreateRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const AlbumCreatePage(),
      );
    },
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(
          '/#redirect',
          path: '/',
          redirectTo: '/login',
          fullMatch: true,
        ),
        RouteConfig(
          LoginRoute.name,
          path: '/login',
        ),
        RouteConfig(
          HomeRoute.name,
          path: '',
        ),
        RouteConfig(
          PhotoDetailRoute.name,
          path: '/photos',
        ),
        RouteConfig(
          AlbumRoute.name,
          path: '/albums/:id',
        ),
        RouteConfig(
          AlbumCreateRoute.name,
          path: '/albums/create',
        ),
      ];
}

/// generated route for
/// [LoginPage]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute()
      : super(
          LoginRoute.name,
          path: '/login',
        );

  static const String name = 'LoginRoute';
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: '',
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [PhotoDetailPage]
class PhotoDetailRoute extends PageRouteInfo<PhotoDetailRouteArgs> {
  PhotoDetailRoute({
    Key? key,
    List<MediaItem> mediaItems = const [],
    int? initialIndex,
  }) : super(
          PhotoDetailRoute.name,
          path: '/photos',
          args: PhotoDetailRouteArgs(
            key: key,
            mediaItems: mediaItems,
            initialIndex: initialIndex,
          ),
        );

  static const String name = 'PhotoDetailRoute';
}

class PhotoDetailRouteArgs {
  const PhotoDetailRouteArgs({
    this.key,
    this.mediaItems = const [],
    this.initialIndex,
  });

  final Key? key;

  final List<MediaItem> mediaItems;

  final int? initialIndex;

  @override
  String toString() {
    return 'PhotoDetailRouteArgs{key: $key, mediaItems: $mediaItems, initialIndex: $initialIndex}';
  }
}

/// generated route for
/// [AlbumPage]
class AlbumRoute extends PageRouteInfo<AlbumRouteArgs> {
  AlbumRoute({
    Key? key,
    required String id,
  }) : super(
          AlbumRoute.name,
          path: '/albums/:id',
          args: AlbumRouteArgs(
            key: key,
            id: id,
          ),
        );

  static const String name = 'AlbumRoute';
}

class AlbumRouteArgs {
  const AlbumRouteArgs({
    this.key,
    required this.id,
  });

  final Key? key;

  final String id;

  @override
  String toString() {
    return 'AlbumRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [AlbumCreatePage]
class AlbumCreateRoute extends PageRouteInfo<void> {
  const AlbumCreateRoute()
      : super(
          AlbumCreateRoute.name,
          path: '/albums/create',
        );

  static const String name = 'AlbumCreateRoute';
}
