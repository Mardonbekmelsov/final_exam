import 'package:final_exam/ui/screens/main_screen.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          ListTile(
            onTap: () => Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => MainScreen())),
            title: const Text("Expanses Screen"),
          ),
          const ListTile(
            title: Text("Incomings Screen"),
          ),
        ],
      ),
    );
  }
}
