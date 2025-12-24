import 'package:daleelakappx/main_layout.dart';
import 'package:daleelakappx/models.dart';
import 'package:daleelakappx/provider.dart';
import 'package:daleelakappx/providers/language_provider.dart';
import 'package:daleelakappx/screens/account/login/screen.dart';
import 'package:daleelakappx/screens/account/profile/screen.dart';
import 'package:daleelakappx/screens/admin_scaffold.dart';
import 'package:daleelakappx/screens/categories/companies/screen.dart';
import 'package:daleelakappx/screens/categories/screen.dart';
import 'package:daleelakappx/screens/client_scaffold.dart';
import 'package:daleelakappx/screens/companies/screen.dart';
import 'package:daleelakappx/screens/dashboard/admin/create/screen.dart';
import 'package:daleelakappx/screens/featured/screen.dart';
import 'package:daleelakappx/screens/landing_screen.dart';
import 'package:daleelakappx/screens/offers/create/screen.dart';
import 'package:daleelakappx/screens/offers/edit/screen.dart';
import 'package:daleelakappx/screens/offers/screen.dart';
import 'package:daleelakappx/screens/storefronts/create/screen.dart';
import 'package:daleelakappx/screens/storefronts/edit/screen.dart';
import 'package:daleelakappx/screens/storefronts/screen.dart';
import 'package:daleelakappx/theme.dart';
import 'package:daleelakappx/util/dynamic_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const DalilakApp());
}

class DalilakApp extends StatelessWidget {
  static final dynamicRouter = DynamicRouter()
      .layout((context, child) => MainLayout(child: child!))
      .add('/categories/:id/companies', (context, params) {
    var id = params['id'];
    if (id == null) throw ArgumentError('id cannot be null');
    return CategoriesListingScreen(id);
  })
      .add('/categories/:id', (context, params) {
    var id = params['id'];
    if (id == null) throw ArgumentError('id cannot be null');
    return CategoriesScreen(id);
  })
      .add('/companies/:id', (context, params) {
    var id = params['id'];
    if (id == null) throw ArgumentError('id cannot be null');
    return CompanyDetailsScreen(id);
  })
      .add('/account/login', (context, params) => const LoginScreen())
      .add('/account/profile', (context, params) => const ProfileScreen())
      .add('/dashboard/storefronts', (context, params) => const ManageStorefrontsScreen())
      .add('/dashboard/storefronts/create', (context, params) => const CreateStorefrontScreen())
      .add('/dashboard/storefronts/:id', (context, params) {
    var id = params['id'];
    if (id == null) throw ArgumentError('id cannot be null');
    return EditStorefrontScreen(id);
  })
      .add('/dashboard/featured', (context, params) => const ManageFeaturedScreen())
      .add('/dashboard/offers', (context, params) => const ManageOffersScreen())
      .add('/dashboard/offers/create', (context, params) => const CreateOfferScreen())
      .add('/dashboard/offers/:id', (context, params) {
    var id = params['id'];
    if (id == null) throw ArgumentError('id cannot be null');
    return EditOfferScreen(id);
  })
      .add('/dashboard/admin/create', (context, params) => const CreateAdminScreen())
      .add('/', (context, params) => const LandingScreen())
      .end();

  const DalilakApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppProvider(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => LanguageProvider()),
        ],
        child: Consumer<LanguageProvider>(
          builder: (context, languageProvider, child) {
            return MaterialApp(
              title: 'Dalilak',
              theme: dalilakThemeData,
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                AppLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('en'),
                Locale('ar'),
              ],
              locale: languageProvider.currentLocale,
              initialRoute: '/',
              onGenerateRoute: (settings) {
                final route = dynamicRouter.onGenerateRoute(settings);
                if (route != null && route is MaterialPageRoute) {
                  return animatedRoute(settings, route.builder(context));
                }
                return route;
              },

            );
          },
        ),
      ),
    );
  }
}
Route<dynamic>? animatedRoute(RouteSettings settings, Widget page) {
  return PageRouteBuilder(
    settings: settings,
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.easeInOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);

      return SlideTransition(position: offsetAnimation, child: child);
    },
    transitionDuration: const Duration(milliseconds: 400),
  );
}



class MainLayout extends StatelessWidget {
  final Widget child;

  const MainLayout({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    var provider = DProvider.of(context);
    final user = provider.user;
    return user?.role == Role.admin
        ? AdminScaffold(
            pageIndex: provider.pageIndex,
            onPageChange: provider.setPageIndex,
            child: child,
          )
        : ClientScaffold(
            pageIndex: provider.pageIndex,
            onPageChange: provider.setPageIndex,
            child: child,
          );
  }
}
