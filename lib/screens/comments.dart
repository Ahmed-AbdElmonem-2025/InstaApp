import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_app/controller/layout_cubit.dart';
import 'package:insta_app/controller/layout_states.dart';
import 'package:insta_app/models/user_model.dart';
import 'package:insta_app/shared/colors.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class CommentsScreen extends StatelessWidget {
  final String postId;
  final UserModel userModel;
  final commentController = TextEditingController();
  final scrollController = ScrollController();
  CommentsScreen({super.key, required this.postId, required this.userModel});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context)
      ..getCommentFromFireStore( postId: postId);

    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: mobileBackGroundColor,
          appBar: AppBar(
            backgroundColor: mobileBackGroundColor,
            title: Text('comments'),
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    cubit.comments == null
                        ? Text(
                            'loading',
                            style: TextStyle(color: Colors.amber),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Container(
                              width: double.infinity,
                              child: ListView.builder(
                                controller: scrollController,
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: cubit.comments.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Column(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(bottom: 10),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CircleAvatar(
                                              radius: 30,
                                              child: CircleAvatar(
                                                radius: 26,
                                                backgroundImage: NetworkImage(
                                                  cubit.comments[index]
                                                      ['profilePic'],
                                                  //  "https://www.dreamzone.co.in/blog/wp-content/uploads/2022/05/Sound-of-cartoon-characters-1.jpg"
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            cubit.comments[
                                                                    index]
                                                                ['username'],
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 17,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                          Text(
                                                            DateFormat(
                                                                    'dd/MM/yyyy    ${"hh:mm"}')
                                                                .format(DateTime.parse(cubit
                                                                    .comments[
                                                                        index][
                                                                        'datePublished']
                                                                    .toDate()
                                                                    .toString())),
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        width: 19,
                                                      ),

                                                      /*   Expanded(
                                                    child: Text(
                                                      cubit.comments[index]['textComment'],
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                        
                        */

                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          TextButton(
                                                            onPressed: () {},
                                                            child: Icon(
                                                              Icons.favorite,
                                                              color: Colors
                                                                  .blueGrey,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        margin: EdgeInsets.only(bottom: 40),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color:
                                              Color.fromARGB(255, 54, 53, 53),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            cubit.comments[index]
                                                ['textComment'],
                                            style: const TextStyle(
                                              fontSize: 18,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      child: CircleAvatar(
                        radius: 26,
                        backgroundImage: NetworkImage(
                          "${userModel.image}",
                          //  "https://www.dreamzone.co.in/blog/wp-content/uploads/2022/05/Sound-of-cartoon-characters-1.jpg"
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: commentController,

                        style: TextStyle(
                          color: Colors.white,
                        ),
                        //controller: titleConntroller,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.white,
                          )),
                          fillColor: Color.fromARGB(255, 51, 49, 49),
                          filled: true,
                          // border: OutlineInputBorder(),
                          labelText: 'write a comment',
                          labelStyle: TextStyle(color: Colors.white),
                          hintText: 'write a comment',

                          hintStyle: TextStyle(color: Colors.amber),

                          suffixIcon: IconButton(
                            onPressed: () async {
                              await LayoutCubit.get(context)
                                  .uploadCommentToFireStore(
                                      commentText: commentController.text,
                                      postId: postId);
                              commentController.clear();
                              // بعد إضافة التعليق الجديد، سنقوم بالتمرير لأخر عنصر تمت إضافته
                           //   scrollController.jumpTo(scrollController.position.maxScrollExtent);
                            
                             // التمرير لأسفل في نهاية دالة رفع التعليق
    scrollController.animateTo(
      scrollController.position.minScrollExtent,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
                            },
                            icon: const Icon(
                              Icons.send,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
