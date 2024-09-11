import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:redit/feature/auth/controller/auth_controller.dart';

import '../drawer/community_list_drawer.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  void displayDrawer(BuildContext context){
    Scaffold.of(context).openDrawer();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        leading: Builder(
          builder: (context) {
            return IconButton(onPressed: () {
              displayDrawer(context);
            }, icon: Icon(Icons.menu));
          }
        ),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.search)),

          IconButton(
            icon: CircleAvatar(
              backgroundImage: NetworkImage(user!.profilePic),
            ),
            onPressed: (){},
          )
        ],
      ),
      drawer: CommunityListDrawer(),
    );
  }
}
