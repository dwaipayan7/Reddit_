import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:redit/core/common/error_text.dart';
import 'package:redit/core/common/loader.dart';
import 'package:redit/feature/auth/controller/auth_controller.dart';
import 'package:redit/feature/community/controller/community_controller.dart';
import 'package:redit/feature/community/screens/mod_tools_screen.dart';
import 'package:routemaster/routemaster.dart';

import '../../../models/community.dart';

class CommunityScreen extends ConsumerWidget {
  final String name;
  const CommunityScreen({required this.name});


  void navigateToModTools(BuildContext context) {
    Routemaster.of(context).push('/mod-tools/$name');
  }

  // void joinCommunity(WidgetRef ref, Community community, BuildContext context) {
  //   ref.read(communityControllerProvider.notifier).joinCommunity(community, context);
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
    return Scaffold(
      body: ref.watch(getCommunityByNameProvider(name)).when(
          data: (community) => NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    expandedHeight: 150,
                    floating: true,
                    snap: true,
                    flexibleSpace: Stack(
                      children: [
                        Positioned.fill(child: Image.network(community.banner))
                      ],
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.all(16),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          Align(
                            alignment: Alignment.topLeft,
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(community.avatar),
                              radius: 35,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "\tr/${community.name}",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              community.mods.contains(user.uid)?
                              OutlinedButton(
                                onPressed: () {
                                  navigateToModTools(context);
                                  // Navigator.push(context, MaterialPageRoute(builder: (context) => ModToolsScreen()));
                                },

                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 25)),
                                child: Text('Mod Tools', style: TextStyle(
                                  fontSize: 10
                                ),),
                              ):
                              OutlinedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(20)),
                                    padding:
                                    EdgeInsets.symmetric(horizontal: 25)),
                                child: Text(community.members.contains(user.uid)?'Joined' : 'Join', style: TextStyle(
                                    fontSize: 10
                                ),),
                              )
                            ],
                          ),
                          Padding(
                              padding: EdgeInsets.only(top: 10),
                            child: Text('${community.members.length} members'),
                          
                          ),
                        ],
                      ),
                    ),
                  )
                ];
              },
              body: Text("Displaying posts")),
          error: (error, stackTrace) => ErrorText(error: error.toString()),
          loading: () => Loader()),
    );
  }
}
