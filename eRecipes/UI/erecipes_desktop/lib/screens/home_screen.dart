import 'package:erecipes_desktop/main.dart';
import 'package:erecipes_desktop/providers/auth_provider.dart';
import 'package:erecipes_desktop/screens/category_list_screen.dart';
import 'package:erecipes_desktop/screens/obavijesti_screen.dart';
import 'package:erecipes_desktop/screens/recipe_list_screen.dart';
import 'package:erecipes_desktop/screens/report_screen.dart';
import 'package:erecipes_desktop/screens/user_list_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
  static const String routeName = "/home";
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedNavItem = 'Recepti';
  
@override
void initState() {
  super.initState();
  selectedNavItem = 'Recepti'; 
}

  @override
  Widget build(BuildContext context) {
  bool isAdministrator() {
  return AuthProvider.korisnik?.uloga?.naziv
          ?.split(',')
          .map((e) => e.trim().toLowerCase())
          .contains('admin') ?? false;
  }
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'eRecipes',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
        ),
        backgroundColor: const Color.fromRGBO(1, 100, 34, 1),
      ),
      backgroundColor:  Colors.white,
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                NavItem(
                  title: 'Recepti',
                  isSelected: selectedNavItem == 'Recepti',
                  onTap: () {
                    setState(() {
                      selectedNavItem = 'Recepti';
                    });
                  },
                ),
                if (isAdministrator())
                NavItem(
                  title: 'Kategorije',
                  isSelected: selectedNavItem == 'Kategorije',
                  onTap: () {
                    setState(() {
                      selectedNavItem = 'Kategorije';
                    });
                  },
                ),
              if (isAdministrator())
                NavItem(
                  title: 'Izvještaji',
                  isSelected: selectedNavItem == 'Izvještaji',
                  onTap: () {
                    setState(() {
                      selectedNavItem = 'Izvještaji';
                    });
                  },
                ),
                if (isAdministrator())
                NavItem(
                  title: 'Korisnici',
                  isSelected: selectedNavItem == 'Korisnici',
                  onTap: () {
                    setState(() {
                      selectedNavItem = 'Korisnici';
                    });
                  },
                ),
                if (isAdministrator())
                NavItem(
                  title: 'Notifikacije',
                  isSelected: selectedNavItem == 'Notifikacije',
                  onTap: () {
                    setState(() {
                      selectedNavItem = 'Notifikacije';
                    });
                  },
                ),
                NavItem(
                  title: 'Dobro došli!',
                  isSelected: selectedNavItem == 'Dobro došli',
                  onTap: () {
                    setState(() {
                     
                    });
                  },
                 icon: const Icon(
                    Icons.person,
                    color: Colors.black,
                    size: 20,
                  ),
                ), NavItem(
                  title: 'Logout',
                  isSelected: selectedNavItem == 'Logout',
                  onTap: () {
                    AuthProvider.username = '';
                    AuthProvider.password = '';
                    AuthProvider.korisnik = null;
                     Navigator.of(context).pushNamedAndRemoveUntil(
                              LoginScreen.routeName,
                              (route) => false,
                            );
                    setState(() {
                      selectedNavItem = 'Logout';
                    });
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 252, 252, 252),
                borderRadius: BorderRadius.circular(10),
              ),
              child: _buildSelectedContent(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectedContent() {
    switch (selectedNavItem) {
      case 'Korisnici':
        return ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: const UserListScreen(),
        );
      case 'Recepti':
        return ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: const RecipeListScreen(),
        );
      case 'Kategorije':
        return ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: const CategoryListScreen(),
        );
      case 'Izvještaji':
          return ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: const ReportScreen(),
        );
      case 'Notifikacije':
         return ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child:  NotifikacijeScreen(),
        );
      case 'Logout':
        return const Center(child: Text('You have logged out!'));
      default:
        return const Center(child: Text('Select an item from the navigation bar'));
    }
  }
}

class NavItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool isSelected;
  final Icon? icon;

  const NavItem({super.key, 
    required this.title,
    required this.onTap,
    required this.isSelected,
    this.icon,
  });

 @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal, 
                color: isSelected ? Colors.black : Colors.black, 
              ),
            ),
            if (icon != null) ...[
              const SizedBox(width: 8),
              icon!,
            ],
          ],
        ),
      ),
    );
  }
}