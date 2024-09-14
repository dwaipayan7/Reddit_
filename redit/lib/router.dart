//logout route

//logIn route

import 'package:flutter/material.dart';
import 'package:redit/feature/auth/screens/login_screen.dart';
import 'package:redit/feature/community/screens/community_screen.dart';
import 'package:redit/feature/community/screens/create_community_screens.dart';
import 'package:redit/feature/home/screen/home_screen.dart';
import 'package:routemaster/routemaster.dart';

final loggedOutRoute = RouteMap(routes: {
  '/':(_) => const MaterialPage(child: LoginScreen()),
});

final loggedInRoute = RouteMap(routes: {
  '/':(_) => const MaterialPage(child: HomeScreen()),
  '/create-community': (_)=> const MaterialPage(child: CreateCommunityScreens()),
  '/r/:name': (route)=>  MaterialPage(child: CommunityScreen(
    name: route.pathParameters['name']!,
  )),
});