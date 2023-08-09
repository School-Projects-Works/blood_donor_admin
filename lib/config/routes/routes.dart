import 'package:auto_route/auto_route.dart';

import '../../pages/auth/login_page.dart';
import '../../pages/home/components/dashboard_screen.dart';
import '../../pages/home/components/donations_screen.dart';
import '../../pages/home/components/request_screen.dart';
import '../../pages/home/components/user_screen.dart';
import '../../pages/home/home_page.dart';

part 'routes.gr.dart';
@AutoRouterConfig( replaceInRouteName: 'Page|Screen,Route',)
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes =>[
    AutoRoute(page: LoginRoute.page, path: '/login', initial: true),
    AutoRoute(page: HomeRoute.page, path: '/home', children: [
      AutoRoute(page: DashboardRoute.page, path: '/dashboard'),
      AutoRoute(page: UsersRoute.page, path: '/users'),
      AutoRoute(page: DonationRoute.page, path: '/donations'),
      AutoRoute(page: RequestRoute.page, path: '/requests'),
    ]),
    //redirect to login page if no route found
    RedirectRoute(path: '*', redirectTo: '/login'),
    RedirectRoute(path: '/', redirectTo: '/login'),
  ];

}