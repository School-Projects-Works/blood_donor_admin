import 'package:auto_route/auto_route.dart';
import 'package:blood_donor_admin/config/routes/routes.dart';
import 'package:blood_donor_admin/core/components/constants/enums.dart';
import 'package:blood_donor_admin/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../state/navigation_state.dart';

class SideBar extends ConsumerWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var width = ref.watch(sideBarWithProvider);
    var size = MediaQuery.of(context).size;
    return Container(
      width: width,
      color: primaryColor,
      height: size.height,
      child: Column(
          crossAxisAlignment:
              width < 100 ? CrossAxisAlignment.center : CrossAxisAlignment.end,
          children: [
            const SizedBox(
              height: 20,
            ),
            IconButton(
                onPressed: () {
                  if (ref.watch(sideBarWithProvider) == 60) {
                    ref.read(sideBarWithProvider.notifier).state = 200;
                  } else {
                    ref.read(sideBarWithProvider.notifier).state = 60;
                  }
                },
                icon: const Icon(
                  Icons.menu,
                  color: Colors.white,
                )),
            const SizedBox(
              height: 40,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SideBarItem(
                    destination: DashboardRoute(),
                    title: 'Dashboard',
                    icon: Icons.apps,
                  ),
                ],
              ),
            ),
          ]),
    );
  }
}

class SideBarItem extends ConsumerStatefulWidget {
  const SideBarItem( {super.key, this.title, this.icon, this.destination,this.page});
  final String? title;
  final IconData? icon;
  final PageRouteInfo<dynamic>? destination;
  final HomePages? page;

  @override
  ConsumerState<SideBarItem> createState() => _SideBarItemState();
}

class _SideBarItemState extends ConsumerState<SideBarItem> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    var size = ref.watch(sideBarWithProvider);
    return InkWell(
        onHover: (value) {
          setState(() {
            isHovered = value;
          });
        },
        onTap: () {
          ref.read(navigationPageProvider.notifier).state = widget.page!;
          AutoRouter.of(context).push(widget.destination!);
        },
        child: Container(
          width: size,
          height: 50,
          color: isHovered
              ? Colors.white.withOpacity(0.5)
              :ref.watch(navigationPageProvider) ==
                      HomePages.values
           mn    .firstWhere(
                  (element) => element.name == widget.destination!.routeName)
                  ? Colors.white
                  : Colors.transparent,
          child: size < 100
              ? Center(
                  child: Icon(
                    widget.icon,
                    color: Colors.white,
                  ),
                )
              : Row(children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Icon(
                    widget.icon,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    widget.title!,
                    style: const TextStyle(color: Colors.white),
                  )
                ]),
        ));
  }
}
