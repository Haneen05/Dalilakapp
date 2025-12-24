import 'package:daleelakappx/screens/not_found.dart';
import 'package:flutter/material.dart';

typedef DynamicRouterWidgetBuilder = Widget Function(
    BuildContext context, Map<String, String> params);

class DynamicRouter {
  final Map<String, DynamicRouterWidgetBuilder> _map = {};

  DynamicRouter add(String route, DynamicRouterWidgetBuilder builder) {
    _map[route] = builder;
    return this;
  }

  DynamicRouterBuilder layout(TransitionBuilder builder) {
    return DynamicRouterBuilder(this, builder);
  }

  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    debugPrint('on generate router called with name ${settings.name}');
    final uri = Uri.parse(settings.name!);

    for (var route in _map.keys) {
      final pattern = RegExp(
        "^${route.replaceAllMapped(RegExp(r':[a-zA-Z0-9_-]+'), (match) => '(?<${match[0]!.substring(1)}>[^/]+)')}\$",
      );

      debugPrint("matching uri ${uri.path} against pattern ${pattern.pattern}");
      final match = pattern.firstMatch(uri.path);
      debugPrint("found input: ${match?.input}");

      if (match != null) {
        final params = <String, String>{};
        for (var i = 1; i <= match.groupCount; i++) {
          String name = match.groupNames.elementAt(i - 1);
          params[name] = match[i]!;
        }
        return MaterialPageRoute(
          builder: (context) => _map[route]!(context, params),
          settings: settings,
        );
      }
    }
    return MaterialPageRoute(
      builder: (context) => const NotFoundScreen(),
      settings: settings,
    );
  }
}

class DynamicRouterBuilder {
  final DynamicRouter _router;
  final TransitionBuilder _builder;
  final Map<String, DynamicRouterWidgetBuilder> _map = {};

  DynamicRouterBuilder(this._router, this._builder);

  DynamicRouterBuilder add(String route, DynamicRouterWidgetBuilder builder) {
    _map[route] = (context, params) {
      return _builder(context, builder(context, params));
    };
    return this;
  }

  DynamicRouter end() {
    _router._map.addAll(_map);
    return _router;
  }
}
