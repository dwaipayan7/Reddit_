
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

class ModToolsScreen extends StatelessWidget {
  final String name;
  const ModToolsScreen({super.key, required this.name});

  void navigateToModTools(BuildContext context) {
    Routemaster.of(context).push('/edit-community/$name');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mod Tools"),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text("Add Moderators"),
            leading: Icon(Icons.add_moderator),
            onTap: (){

            },
          ),
          ListTile(
            title: Text("Edit Community"),
            leading: Icon(Icons.edit),
            onTap: (){
                navigateToModTools(context);
            },
          )
        ],
      ),
    );
  }
}

