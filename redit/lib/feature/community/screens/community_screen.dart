import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:redit/core/common/error_text.dart';
import 'package:redit/core/common/loader.dart';
import 'package:redit/feature/community/controller/community_controller.dart';

class CommunityScreen extends ConsumerWidget {
  final String name;
  const CommunityScreen({required this.name});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: ref.watch(getCommunityByNameProvider(name)).when(
          data: (community) => NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled){
            return [
              SliverAppBar(
                expandedHeight: 150,
              flexibleSpace: Stack(
                children: [
                  Positioned.fill(
                      child: Image.network(community.banner)
                  )
                ],
              ),
              )
            ];
          }, body: Text("display")
          ),
          error: (error, stackTrace) => ErrorText(error: error.toString()),
          loading: () => Loader()),
    );
  }
}
