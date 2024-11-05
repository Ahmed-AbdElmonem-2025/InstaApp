import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_app/controller/layout_cubit.dart';
import 'package:insta_app/controller/layout_states.dart';
import 'package:insta_app/models/post_model.dart';
import 'package:insta_app/models/user_model.dart';
import 'package:insta_app/shared/colors.dart';

class UserSearchProfileScreen extends StatelessWidget {
  final UserModel userModel;
  final List<PostModel>? postModel;

  UserSearchProfileScreen({Key? key, required this.userModel,this.postModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
     var layoutCubit = BlocProvider.of<LayoutCubit>(context);
    final double widthScreen = MediaQuery.of(context).size.width;
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {
      
      
      },
      builder: (context, state) {
      /*  print('********************');
        print(layoutCubit.id);
        print('********************'); */
        return Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: mobileBackGroundColor,
              title: Text(userModel.name!),
            ),
            body: SingleChildScrollView(
                child: Column(
              children: [
                Column(children: [
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(left: 22),
                                child: CircleAvatar(
                                  radius: 40,
                                  backgroundColor:
                                      const Color.fromARGB(255, 114, 112, 107),
                                  child: CircleAvatar(
                                      radius: 35,
                                      backgroundImage: NetworkImage(
                                          
                                        userModel.image!,
                                        // 'https://www.dreamzone.co.in/blog/wp-content/uploads/2022/05/Sound-of-cartoon-characters-1.jpg'),
                                      )),
                                ),
                              ),
                              const SizedBox(
                                width: 17,
                              ),
                              Column(
                                children: [
                                  Text(
                                    "${layoutCubit.userrrrrrrposts.length}",
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text(
                                    'posts',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 17,
                              ),
                              Column(
                                children: [
                                  Text(
                                   /* userModel.follwers !=
                                                null &&
                                            userModel
                                                .follwers!.isNotEmpty
                                        ? '${userModel.follwers!.length}'

                                        :*/ 
                                        
                                      // '${userModel.follwers!.length}',
                                         "${layoutCubit.userModelllll!.follwers!.length}",
                                        
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text(
                                    'Followers',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 17,
                              ),
                              Column(children: [
                                Text(
                                 /* userModel.follwing!
                                              .length >
                                          0
                                      ?*/ '${userModel.follwing!.length}',
                                     // : '0',
                                  /* layoutCubit.usernavigate!.follwing!=null && layoutCubit.usernavigate!.follwing!.isNotEmpty
                                   ? '${layoutCubit.usernavigate!.follwing!.length}' :'0',*/
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  'Following',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                ),
                              ]),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 25),
                          child: Text(
                            userModel.title!,
                            style: const TextStyle(
                              color: Colors.amber,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),






                        ////////////////// followwwwwwwwwwwwwwwww and un 
                        layoutCubit.showFollow ==true ?
                        Center(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: MaterialButton(
                              // padding: EdgeInsets.symmetric(vertical: 22, horizontal: 22),
                              color:  Colors.white  ,
                              onPressed: ()  {
                                          // دا
                                      // layoutCubit.follow(followers: userModel.follwers!.length);
                              // او دا
                                        layoutCubit.follow(
                                          followers: layoutCubit.userModelllll!.follwers!.length,
                                          following: layoutCubit.userModelllll!.follwing!.length,
                                          
                                          );
                                           
                              },
                              child:  Text(
                                 'Follow',
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              )  
                            ),
                          ),
                        )
                        
                        :

                         



                          ////////////////// followwwwwwwwwwwwwwwww and un 
                        Center(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: MaterialButton(
                              // padding: EdgeInsets.symmetric(vertical: 22, horizontal: 22),
                              color:   Colors.red,
                              onPressed: ()async {
                                 
                                 
                                 layoutCubit.follow(
                                  followers: layoutCubit.userModelllll!.follwers!.length,
                                  following: layoutCubit.userModelllll!.follwing!.length,
                                 );
                                    
                                 
                              },
                              child:   Text(
                                 'UnFollow',
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold,color: Colors.white),
                              )
                            ),
                          ),
                        ),







                        const SizedBox(
                          height: 10,
                        ),
                        if (layoutCubit.userrrrrrrposts == null ||
                            layoutCubit.userrrrrrrposts.isEmpty)
                          Container(),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 33,
                            ),
                            itemCount: layoutCubit.userrrrrrrposts.length,
                            itemBuilder: (BuildContext context, int index) {
                              if (layoutCubit.userrrrrrrposts.length > 0) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Image.network(
                                   //   "${postModel!.imgPost![index]}"
                                   
                                   layoutCubit.userrrrrrrposts[index].imgPost!
       

                                    // 'https://www.dreamzone.co.in/blog/wp-content/uploads/2022/05/Sound-of-cartoon-characters-1.jpg',
                                    ,
                                    fit: BoxFit.fill,
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                 ])])  ) 
                    
                    
             );
             
      },
      
    );
    
  }
}