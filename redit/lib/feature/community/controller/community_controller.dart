import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:redit/constants/constant.dart';
import 'package:redit/core/utils.dart';
import 'package:redit/feature/auth/controller/auth_controller.dart';
import 'package:redit/feature/community/repository/community_repository.dart';
import 'package:redit/models/community.dart';

class CommunityController {
  final CommunityRepository _communityRepository;
  final Ref _ref;

  CommunityController(
      {required CommunityRepository communityRepository, required Ref ref})
      : _communityRepository = communityRepository,
        _ref = ref;

  void createCommunity(String name, BuildContext context) async {
    final uid = _ref.read(userProvider)?.uid ??" ";
        Community community = Community(
        id: name,
        name: name,
        banner: Constants.bannerDefault,
        avatar: Constants.avatarDefault,
        members: [],
        mods: []
    );

      final res = await _communityRepository.createCommunity(community);
      res.fold((l)=> showSnackBar(context, l.message),
          (r){
            showSnackBar(context, "Community Created Successfully");
            Navigator.pop(context);
          }
      );

  }
}
