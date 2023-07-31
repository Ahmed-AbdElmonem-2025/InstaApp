import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insta_app/controller/layout_cubit.dart';
import 'package:insta_app/cubit/home_cubit.dart';
import 'package:insta_app/cubit/home_states.dart';
import 'package:insta_app/screens/add_post.dart';
import 'package:insta_app/screens/home.dart';
import 'package:insta_app/screens/profile.dart';
import 'package:insta_app/screens/search.dart';
import 'package:insta_app/shared/colors.dart';

class WebScreen extends StatelessWidget {
  WebScreen({super.key});

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final layoutCubit = BlocProvider.of<LayoutCubit>(context);
    return BlocProvider<HomeCubit>(
      create: (context) {
        return HomeCubit();
      },
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = BlocProvider.of<HomeCubit>(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: mobileBackGroundColor,
              title: SvgPicture.asset(
                "assets/img/insta.svg",
                color: primaryColor,
                height: 32,
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      _pageController.jumpToPage(0);
                      cubit.navigateToScreen(0);
                    },
                    icon: Icon(
                      Icons.home,
                      color: cubit.currentIndex == 0
                          ? primaryColor
                          : secondaryColor,
                    )),
                IconButton(
                    onPressed: () {
                      _pageController.jumpToPage(1);
                      cubit.navigateToScreen(1);
                    },
                    icon: Icon(
                      Icons.search,
                      color: cubit.currentIndex == 1
                          ? primaryColor
                          : secondaryColor,
                    )),
                IconButton(
                    onPressed: () {
                      _pageController.jumpToPage(2);
                      cubit.navigateToScreen(2);
                    },
                    icon: Icon(
                      Icons.add_a_photo,
                      color: cubit.currentIndex == 2
                          ? primaryColor
                          : secondaryColor,
                    )),
                IconButton(
                    onPressed: () {
                      _pageController.jumpToPage(3);
                      cubit.navigateToScreen(3);
                    },
                    icon: Icon(
                      Icons.favorite,
                      color: cubit.currentIndex == 3
                          ? primaryColor
                          : secondaryColor,
                    )),
                IconButton(
                    onPressed: () {
                      _pageController.jumpToPage(4);
                      cubit.navigateToScreen(4);
                    },
                    icon: Icon(
                      Icons.person,
                      color: cubit.currentIndex == 4
                          ? primaryColor
                          : secondaryColor,
                    )),
              ],
            ),
            body: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                _pageController.jumpToPage(index);
              },
              physics: const NeverScrollableScrollPhysics(),
              children: [
                HomePage(postModel: layoutCubit.posts,),
                SearchPage(),
                AddPostPage(),
                Center(child: Text('llllllll')),
                ProfilePage(),
              ],
            ),
          );
        },
      ),
    );
  }
}
