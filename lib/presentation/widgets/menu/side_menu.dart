import 'package:cine_app/config/menu/menu_items.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SideMenu extends StatefulWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;
  const SideMenu({
    super.key,
    this.scaffoldKey,
  });

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  int navDrawerIndex = 0;

  @override
  void initState() {
    super.initState();

    final currentUrl =
        GoRouter.of(context).routeInformationProvider.value.uri.toString();

    for (var i = 0; i < appMenuItems.length; i++) {
      if (appMenuItems[i].url == currentUrl) {
        setState(() {
          navDrawerIndex = i;
        });
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(
      selectedIndex: navDrawerIndex,
      onDestinationSelected: (value) {
        setState(() {
          navDrawerIndex = value;
        });

        final menuItem = appMenuItems[value];
        context.go(menuItem.url);
        widget.scaffoldKey?.currentState?.closeDrawer();
      },
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(28, 20, 0, 20),
          child: Text('Menu'),
        ),
        ...appMenuItems.map(
          (item) => NavigationDrawerDestination(
            icon: Icon(item.icon),
            label: Text(item.title),
          ),
        ),
      ],
    );
  }
}
