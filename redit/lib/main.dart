import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:redit/core/common/error_text.dart';
import 'package:redit/core/common/loader.dart';
import 'package:redit/feature/auth/controller/auth_controller.dart';
import 'package:redit/models/user_model.dart';
import 'package:redit/router.dart';
import 'package:redit/theme/pallete.dart';
import 'package:routemaster/routemaster.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ProviderScope(child: const MyApp()));
}


class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  UserModel? userModel;

  void getData(WidgetRef ref, User data) async{
    userModel = await ref.watch(authControllerProvider.notifier).getUserData(data.uid).first;
    ref.read(userProvider.notifier).update((state)=> userModel);
    setState(() {});

  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(authStateChangeProvider).when(
        data: (data) => MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Reddit Demo',
          theme: Pallete.darkModeAppTheme,
          routerDelegate: RoutemasterDelegate(
              routesBuilder: (context) {
                // loggedOutRoute
                if (data != null) {
                  getData(ref, data);
                    if(userModel != null){
                      return loggedInRoute;

                    }
                }
                return loggedOutRoute;
              }
          ),
          routeInformationParser: const RoutemasterParser(),
        ),
        error: (error, stackTrace) => ErrorText(error: error.toString()),
        loading: () => const Loader());
  }
}



//
// class MyApp extends ConsumerWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//
//   }
// }
