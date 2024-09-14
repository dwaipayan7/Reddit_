import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:redit/core/common/loader.dart';
import 'package:redit/feature/community/controller/community_controller.dart';

class CreateCommunityScreens extends ConsumerStatefulWidget {
  const CreateCommunityScreens({super.key});

  @override
  ConsumerState<CreateCommunityScreens> createState() => _CreateCommunityScreensState();
}

class _CreateCommunityScreensState extends ConsumerState<CreateCommunityScreens> {
  
final communityNameController = TextEditingController();

@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    communityNameController.dispose();
  }

  void createCommunity(){
    ref.read(communityControllerProvider.notifier).createCommunity(communityNameController.text.trim(), context);
  }
  
  @override
  Widget build(BuildContext context) {
  final isLoading = ref.watch(communityControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create A Community"),
      ),
      body: isLoading?
      const Loader():
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            // Align(alignment: Alignment.topLeft,),
            Align(alignment: Alignment.topLeft,child: Text('Community Name')),
            const SizedBox(height: 10,),
            TextField(
              controller: communityNameController,
              decoration: const InputDecoration(
                hintText: 'New Community',
                filled: true,
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(18)
              ),
              maxLength: 21,
            ),
            SizedBox(height: 30,),
            ElevatedButton(
                onPressed: (){
                  createCommunity();
                },
                child: Text('Create Community',),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                // backgroundColor: Colors.blue,
                // shape: RoundedRectangleBorder(
                //   borderRadius: BorderRadius.circular(20)
                // )
              ),
            )
          ],
        ),
      ),
    );
  }
}
