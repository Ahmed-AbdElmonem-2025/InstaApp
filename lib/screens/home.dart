import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insta_app/controller/layout_cubit.dart';
import 'package:insta_app/controller/layout_states.dart';
import 'package:insta_app/models/user_model.dart';
import 'package:insta_app/screens/comments.dart';
import 'package:insta_app/shared/colors.dart';
import 'package:intl/intl.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  UserModel? userModel;
  @override
  Widget build(BuildContext context) {
    final layoutCubit = BlocProvider.of<LayoutCubit>(context)..getMyData();
    final double widthScreen = MediaQuery.of(context).size.width;
    final double heightScreen = MediaQuery.of(context).size.height;

    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return layoutCubit.posts == null || layoutCubit.posts.isEmpty
            ? Scaffold(
                backgroundColor: mobileBackGroundColor,
                body: Center(
                    child: Text(
                  'no one posted yet',
                  style: TextStyle(color: Colors.amber),
                )),
              )
            : Scaffold(
                backgroundColor: widthScreen > 600
                    ? webBackGroundColor
                    : mobileBackGroundColor,
                appBar: widthScreen > 600
                    ? null
                    : AppBar(
                        actions: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.messenger_outline,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.logout,
                            ),
                          ),
                        ],
                        backgroundColor: mobileBackGroundColor,
                        title: SvgPicture.asset(
                          "assets/img/insta.svg",
                          color: primaryColor,
                          height: 32,
                        ),
                      ),
                body: layoutCubit.userModel == null
                    ? Center(
                        child: CircularProgressIndicator(
                        color: Colors.amber,
                      ))
                    : layoutCubit.posts.isEmpty
                        ? Center(
                            child: CircularProgressIndicator(
                            color: Colors.amber,
                          ))
                        : ListView.builder(
                            itemCount: layoutCubit.posts.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                decoration: BoxDecoration(
                                  color: mobileBackGroundColor,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                margin: EdgeInsets.symmetric(
                                  vertical: 11,
                                  horizontal:
                                      widthScreen > 600 ? widthScreen / 6 : 0,
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 16, horizontal: 13),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                radius: 26,
                                                backgroundImage: NetworkImage(
                                                    // "https://www.dreamzone.co.in/blog/wp-content/uploads/2022/05/Sound-of-cartoon-characters-1.jpg"
                                                    layoutCubit.posts[index]
                                                        .profileImg!),
                                              ),
                                              SizedBox(
                                                width: 17,
                                              ),
                                              Text(
                                                '${layoutCubit.posts[index].username}',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: primaryColor),
                                              ),
                                            ],
                                          ),
                                          IconButton(
                                            onPressed: () {},
                                            icon: Icon(
                                              Icons.more_vert,
                                              color: primaryColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        layoutCubit.showImageDialog(context,
                                            layoutCubit.posts[index].imgPost!);
                                      },
                                      child: Image.network(
                                        // "https://thebentleyhotel.com/wp-content/uploads/2021/12/Best-30-Fun-Things-To-Do-in-Miami-Beach-in-2023-1000x500.jpg",
                                        layoutCubit.posts[index].imgPost!,
                                        fit: BoxFit.cover,
                                        height: heightScreen * 0.35,
                                        width: double.infinity,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            IconButton(
                                              onPressed: () {},
                                              icon: Icon(
                                                Icons.favorite_border,
                                                color: primaryColor,
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                ////////////
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                  return CommentsScreen(
                                                    postId: layoutCubit
                                                        .posts[index].postId!,
                                                    userModel:
                                                        layoutCubit.userModel!,
                                                  );
                                                }));
                                              },
                                              icon: Icon(
                                                Icons.comment_outlined,
                                                color: primaryColor,
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {},
                                              icon: Icon(
                                                Icons.send,
                                                color: primaryColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                        IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.bookmark_add_outlined,
                                            color: primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                        margin:
                                            EdgeInsets.fromLTRB(10, 0, 0, 10),
                                        width: double.infinity,
                                        child: Text(
                                          "${layoutCubit.posts[index].likes!.length} ${layoutCubit.posts[index].likes!.length > 1 ? 'likes' : 'like'}",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: primaryColor),
                                        )),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 9,
                                        ),
                                        Text(
                                          layoutCubit.posts[index].username!,
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          layoutCubit.posts[index].description!,
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white70),
                                        ),
                                      ],
                                    ),
                                    GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        margin:
                                            EdgeInsets.fromLTRB(10, 13, 9, 10),
                                        width: double.infinity,
                                        child: Text(
                                          "view all 100 comments",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Color.fromARGB(
                                                  214, 175, 174, 169)),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(10, 0, 9, 10),
                                      width: double.infinity,
                                      child: Text(
                                        // "${layoutCubit.posts[index].datePuplished!}",

                                        DateFormat('dd/MM/yyyy    ${"hh:mm"}')
                                            .format(DateTime.parse(layoutCubit
                                                .posts[index].datePuplished!)),
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Color.fromARGB(
                                                214, 175, 174, 169)),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
              );
      },
    );
  }
}
