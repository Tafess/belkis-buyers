import 'package:belkis/screens/account_screen.dart';
import 'package:belkis/screens/cart_screen.dart';
import 'package:belkis/screens/category_screen.dart';
import 'package:belkis/screens/home_screen.dart';
import 'package:belkis/screens/message_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class MainScreen extends StatefulWidget {
  static const String id = 'home_screen';
  final int? index;
  const MainScreen({this.index, Key? key}) : super(key: key);

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    CategoryScreen(),
    MessageScreen(),
    CartScreen(),
    AccountScreen(),
  ];

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.index != null) {
      setState(() {
        _selectedIndex = widget.index!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MainScreen._widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(
          color: Colors.blue.shade900,
        ))),
        child: BottomNavigationBar(
            backgroundColor: Colors.white,
            elevation: 9,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(
                    _selectedIndex == 0 ? Icons.home : Icons.home_outlined),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(_selectedIndex == 1
                    ? Icons.category
                    : Icons.category_outlined),
                label: 'Category',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                    _selectedIndex == 2 ? IconlyBold.chat : IconlyLight.chat),
                label: 'Message',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                    _selectedIndex == 3 ? IconlyBold.buy : IconlyLight.buy),
                label: 'Cart',
              ),
              BottomNavigationBarItem(
                icon: Icon(_selectedIndex == 4
                    ? CupertinoIcons.person_solid
                    : CupertinoIcons.person),
                label: 'Account',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.deepOrange,
            showUnselectedLabels: true,
            onTap: _onItemTapped,
            selectedFontSize: 12,
            type: BottomNavigationBarType.fixed),
      ),
    );
  }
}
