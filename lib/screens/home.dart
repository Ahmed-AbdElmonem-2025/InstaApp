import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insta_app/constants.dart';
import 'package:insta_app/controller/layout_cubit.dart';
import 'package:insta_app/controller/layout_states.dart';
import 'package:insta_app/models/post_model.dart';
import 'package:insta_app/models/user_model.dart';
import 'package:insta_app/screens/comments.dart';
import 'package:insta_app/shared/colors.dart';
import 'package:intl/intl.dart';

class HomePage extends StatelessWidget {
  HomePage({
    Key? key,
    required List<PostModel> postModel,
  }) : super(key: key);

  PostModel? postModel;

  UserModel? userModel;

  @override
  Widget build(BuildContext context) {
    final layoutcubit = BlocProvider.of<LayoutCubit>(context);
    // final layoutCubit = BlocProvider.of<LayoutCubit>(context)..getMyData();
    final double widthScreen = MediaQuery.of(context).size.width;
    final double heightScreen = MediaQuery.of(context).size.height;

    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return   layoutcubit.posts == null  || layoutcubit.posts.isEmpty 
            ? Scaffold(
                backgroundColor: mobileBackGroundColor,
                body: Center(
                    child: Text('posts',style: TextStyle(color: Colors.amber),) ),
              )
            : 
            Scaffold(
          backgroundColor:
              widthScreen > 600 ? webBackGroundColor : mobileBackGroundColor,
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
          body: layoutcubit.userModel == null
              ? Center(
                  child: CircularProgressIndicator(
                  color: Colors.amber,
                ))
              : layoutcubit.posts.isEmpty ||
                      layoutcubit.postComments.isEmpty ||
                      layoutcubit.postComments == null
                  ? Center(
                      child: CircularProgressIndicator(
                      color: Colors.amber,
                    ))
                  : ListView.builder(
                      itemCount: layoutcubit.posts.length,
                      itemBuilder: (BuildContext context, int index) {
                        // final post=  layoutCubit.aaa(postiiiiiiiid: layoutCubit.posts[index].postId);
                        //  layoutCubit.getPostIndex(post);
                        //layoutCubit.aaa(postiiiiiiiid:layoutCubit.postModeeel!.postId!,index: index);

                        return Container(
                          decoration: BoxDecoration(
                            color: mobileBackGroundColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          margin: EdgeInsets.symmetric(
                            vertical: 11,
                            horizontal: widthScreen > 600 ? widthScreen / 6 : 0,
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
                                              layoutcubit
                                                  .posts[index].profileImg!),
                                        ),
                                        SizedBox(
                                          width: 17,
                                        ),
                                        Text(
                                          '${layoutcubit.posts[index].username}',
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: primaryColor),
                                        ),
                                      ],
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        // delete post from home screen

                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return SimpleDialog(
                                                children: [
                                                  FirebaseAuth
                                                              .instance
                                                              .currentUser!
                                                              .uid ==
                                                          layoutcubit
                                                              .posts[index].uid
                                                      ? SimpleDialogOption(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                            layoutcubit.deletepostfromhomescreen(
                                                                postID: layoutcubit
                                                                    .posts[
                                                                        index]
                                                                    .postId!);
                                                          },
                                                          padding:
                                                              EdgeInsets.all(
                                                                  20),
                                                          child: Text(
                                                            'Delete post',
                                                            style: TextStyle(
                                                              fontSize: 18,
                                                            ),
                                                          ),
                                                        )
                                                      : SimpleDialogOption(
                                                          onPressed: () {},
                                                          padding:
                                                              EdgeInsets.all(
                                                                  20),
                                                          child: Text(
                                                            'can not Delete this post',
                                                            style: TextStyle(
                                                              fontSize: 18,
                                                            ),
                                                          ),
                                                        ),
                                                  SimpleDialogOption(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    padding: EdgeInsets.all(20),
                                                    child: Text(
                                                      'cancel',
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                  ),

                                                  /* 
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context);
            },
            padding: EdgeInsets.all(20),
            child: Text('cancel',style: TextStyle(fontSize: 18,),),
          ),*/
                                                ],
                                              );
                                            });
                                      },
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
                                  layoutcubit.showImageDialog(context,
                                      layoutcubit.posts[index].imgPost!);
                                },
                                child: Image.network(
                                  // "https://thebentleyhotel.com/wp-content/uploads/2021/12/Best-30-Fun-Things-To-Do-in-Miami-Beach-in-2023-1000x500.jpg",
                                  layoutcubit.posts[index].imgPost!,

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
                                          onPressed: () {
                                            if (layoutcubit.posts[index].likes!
                                                .contains(Constants.userId)) {
                                              layoutcubit.unlike(
                                                  postid: layoutcubit
                                                      .posts[index].postId);
                                            } else {
                                              layoutcubit.like(
                                                  postid: layoutcubit
                                                      .posts[index].postId);
                                            }
                                          },
                                          icon: layoutcubit.posts[index].likes!
                                                  .contains(Constants.userId)
                                              ? Icon(
                                                  Icons.favorite,
                                                  color: Colors.red,
                                                )
                                              : Icon(
                                                  Icons.favorite_border,
                                                  color: primaryColor,
                                                )),
                                      IconButton(
                                        onPressed: () {
                                          ////////////
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return CommentsScreen(
                                              postId: layoutcubit
                                                  .posts[index].postId!,
                                              userModel: layoutcubit.userModel!,
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
                                  margin: EdgeInsets.fromLTRB(10, 0, 0, 10),
                                  width: double.infinity,
                                  child: Text(
                                    "${layoutcubit.posts[index].likes!.length} ${layoutcubit.posts[index].likes!.length > 1 ? 'likes' : 'like'}",
                                    style: TextStyle(
                                        fontSize: 18, color: primaryColor),
                                  )),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 9,
                                  ),
                                  Text(
                                    layoutcubit.posts[index].username!,
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    layoutcubit.posts[index].description!,
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white70),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(10, 13, 9, 10),
                                  width: double.infinity,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return CommentsScreen(
                                          postId:
                                              layoutcubit.posts[index].postId!,
                                          userModel: layoutcubit.userModel!,
                                        );
                                      }));
                                    },
                                    child: Text(
                                      // '${layoutCubit.comments[index].length}',

                                      "view all ${layoutcubit.postComments[index]} comments",

                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Color.fromARGB(
                                              214, 175, 174, 169)),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(10, 0, 9, 10),
                                width: double.infinity,
                                child: Text(
                                  // "${layoutCubit.posts[index].datePuplished!}",

                                  DateFormat('dd/MM/yyyy    ${"hh:mm"}').format(
                                      DateTime.parse(layoutcubit
                                          .posts[index].datePuplished!)),
                                  style: TextStyle(
                                      fontSize: 16,
                                      color:
                                          Color.fromARGB(214, 175, 174, 169)),
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
