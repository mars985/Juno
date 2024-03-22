import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:juno/data/theme.dart';

class NavBar extends StatefulWidget {
  NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  var themePicked = 0;
  MyThemes theme = MyThemes();
  getColor(paletteName) {
    // return theme.colorPalette[themePicked][index];
    // return Color(theme.colors[themePicked][paletteName]);
  }

  var _selectedIndex = 0;
  final List<String> _pageRoutes = ['/homepage', '/peoplepage'];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: getColor("primary"),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: GNav(
            iconSize: 24,
            tabBackgroundColor: getColor("accent"),
            tabBorderRadius: 15,
            activeColor: getColor("secondary"),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            gap: 20,
            tabs: const [
              GButton(
                icon: Icons.home,
                text: "H O M E",
              ),
              GButton(
                icon: Icons.people,
                text: "P E O P L E",
              )
            ],
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
                Navigator.pushNamed(
                  context, _pageRoutes[index]
                );
              });
            },
          ),
        ),
      ),
    );
  }
}
