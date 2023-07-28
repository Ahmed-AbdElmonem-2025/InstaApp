import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_app/cubit/home_cubit.dart';
import 'package:insta_app/cubit/home_states.dart';
import 'package:insta_app/screens/add_post.dart';
import 'package:insta_app/screens/comments.dart';
import 'package:insta_app/screens/home.dart';
import 'package:insta_app/screens/profile.dart';
import 'package:insta_app/screens/search.dart';
import 'package:insta_app/shared/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MobileScreen extends StatefulWidget {
  MobileScreen({
    super.key,
  });

  @override
  State<MobileScreen> createState() => _MobileScreenState();
}

class _MobileScreenState extends State<MobileScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  
@override
  void dispose() {
      _pageController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    
   
    return BlocProvider<HomeCubit>(
      
      create: (context) {
        return HomeCubit();
      },
      child: BlocConsumer<HomeCubit,HomeStates>(
        listener: (context, state) {
          
        },
        builder: (context, state) {
       HomeCubit cubit=    HomeCubit.get(context);
          return Scaffold(
          
          bottomNavigationBar: CupertinoTabBar(
              backgroundColor: mobileBackGroundColor,
              
             currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeBottomNavBar(index);
                _pageController.jumpToPage(index);
               
              },
              items:   [
                BottomNavigationBarItem(
                  
                  icon: Icon(
                    Icons.home,
                    color: cubit.currentIndex ==0 ? primaryColor   :secondaryColor   ,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.search,
                    color: cubit.currentIndex ==1 ? primaryColor  :  secondaryColor,
                  ),
                  label: 'search',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.add_circle,
                    color: cubit.currentIndex ==2  ? primaryColor  :  secondaryColor,
                  ),
                  label: 'Add Post',
                  
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.favorite,
                    color: cubit.currentIndex ==3  ? primaryColor  :  secondaryColor,
                  ),
                  label: 'Favorites',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person,
                    color: cubit.currentIndex ==4  ? primaryColor  :  secondaryColor,
                  ),
                  label: 'person',
                ),
              ]),
          body: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              _pageController.jumpToPage(index);
            },
            physics: const NeverScrollableScrollPhysics(),
            children:  [
              
               HomePage(),
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
