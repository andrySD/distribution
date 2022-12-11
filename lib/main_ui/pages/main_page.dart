import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widgets/custom_item_bottom_nav_bar.dart';

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class MainUI extends StatefulWidget {
  const MainUI({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  State<MainUI> createState() => _MainUIState();
}

class _MainUIState extends State<MainUI> {
  final tabs = [
    const ScaffoldWithNavBarTabItem(
      initialLocation: '/sales_page',
      icon: Icon(Icons.home),
      label: 'Ventas',
    ),
    const ScaffoldWithNavBarTabItem(
      initialLocation: '/settings_page',
      icon: Icon(Icons.settings),
      label: 'Configuracion',
    ),
  ];

  int get _currentIndex => _locationToTabIndex(GoRouter.of(context).location);

  int _locationToTabIndex(String location) {
    final index =
        tabs.indexWhere((t) => location.startsWith(t.initialLocation));
    return index < 0 ? 0 : index;
  }

  void _onItemTapped(BuildContext context, int tabIndex) {
    if (tabIndex != _currentIndex) {
      context.go(tabs[tabIndex].initialLocation);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
        ),
        key: scaffoldKey,
        body: widget.child,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          items: tabs,
          onTap: (index) => _onItemTapped(context, index),
        ),
      ),
    );
  }
}
