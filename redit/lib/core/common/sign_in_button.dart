
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:redit/constants/constant.dart';
import 'package:redit/feature/auth/controller/auth_controller.dart';
import 'package:redit/theme/pallete.dart';

class SignInButton extends ConsumerWidget {
  const SignInButton({super.key});

  void SignInWithGoogle(BuildContext context, WidgetRef ref){
    ref.read(authControllerProvider.notifier).signInWithGoogle(context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Semantics(
        button: true,
        child: ElevatedButton.icon(
            onPressed: (){
              SignInWithGoogle(context, ref);
            },
            icon: Image.asset(Constants.googlePath, width: 35,),
          label: const Text("Continue with Google", style: TextStyle(
            fontSize: 18
          ),),
          style: ElevatedButton.styleFrom(
            backgroundColor: Pallete.greyColor,
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
            )
          )
        ),
      ),
    );
  }
}

