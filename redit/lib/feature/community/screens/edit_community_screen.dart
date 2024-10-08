import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:redit/constants/constant.dart';
import 'package:redit/core/common/error_text.dart';
import 'package:redit/core/common/loader.dart';
import 'package:redit/core/utils.dart';
import 'package:redit/feature/community/controller/community_controller.dart';
import 'package:redit/theme/pallete.dart';

class EditCommunityScreen extends ConsumerStatefulWidget {
  final String name;
  const EditCommunityScreen({super.key, required this.name});

  @override
  ConsumerState<EditCommunityScreen> createState() => _EditCommunityScreenState();
}

class _EditCommunityScreenState extends ConsumerState<EditCommunityScreen> {
  File? bannerFile;
  File? profileFile;

  void selectBannerImage() async {
    final res = await pickImage();

    if (res != null) {
      setState(() {
        bannerFile = File(res.files.first.path!);
      });
    }
  }

  void selectProfileImage() async {
    final res = await pickImage();

    if (res != null) {
      setState(() {
        profileFile = File(res.files.first.path!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(getCommunityByNameProvider(widget.name)).when(
      data: (community) => Scaffold(
        backgroundColor:
        Pallete.darkModeAppTheme.scaffoldBackgroundColor,
        appBar: AppBar(
          title: const Text("Edit Community"),
          actions: [
            TextButton(
                onPressed: () {
                  // Add save logic here
                },
                child: const Text("Save")),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 200,
                  child: Stack(children: [
                    Semantics(
                      button: true,
                      child: GestureDetector(
                        onTap: selectBannerImage,
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(10),
                          dashPattern: const [10, 4],
                          strokeCap: StrokeCap.round,
                          color: Pallete.darkModeAppTheme
                              .textTheme
                              .bodyMedium!
                              .color!,
                          child: Container(
                              width: double.infinity,
                              height: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: bannerFile != null
                                  ? Image.file(bannerFile!)
                                  : community.banner.isEmpty ||
                                  community.banner ==
                                      Constants.bannerDefault
                                  ? const Center(
                                child: Icon(
                                  Icons.camera_alt_outlined,
                                  size: 40,
                                ),
                              )
                                  : Image.network(
                                community.banner,
                                fit: BoxFit.cover,
                              )),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      left: 20,
                      child: GestureDetector(
                        onTap: selectProfileImage,
                        child: profileFile != null
                            ? CircleAvatar(
                          backgroundImage:
                          FileImage(profileFile!),
                          radius: 32,
                        )
                            : CircleAvatar(
                          backgroundImage:
                          NetworkImage(community.avatar),
                          radius: 32,
                        ),
                      ),
                    )
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
      error: (error, stackTrace) =>
          ErrorText(error: error.toString()),
      loading: () => const Loader(),
    );
  }
}
