import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_app/controller/layout_cubit.dart';
import 'package:insta_app/controller/layout_states.dart';
import 'package:insta_app/models/post_model.dart';
import 'package:insta_app/models/user_model.dart';
import 'package:insta_app/shared/colors.dart';

class UserSearchProfileScreen extends StatelessWidget {
  final UserModel userModel;
  final PostModel? postModel;
  UserSearchProfileScreen({Key? key, required this.userModel, this.postModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final layoutCubit = BlocProvider.of<LayoutCubit>(context);
    final double widthScreen = MediaQuery.of(context).size.width;
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: mobileBackGroundColor,
              title: Text(userModel.name!),
            ),
            body: SingleChildScrollView(
                child: Column(
              children: [
                ListView.builder(
                    itemCount: layoutCubit.usersFiltered.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Column(children: [
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 22),
                                child: CircleAvatar(
                                  radius: 40,
                                  backgroundColor:
                                      Color.fromARGB(255, 114, 112, 107),
                                  child: CircleAvatar(
                                      radius: 35,
                                      backgroundImage: NetworkImage(
                                        layoutCubit.usersFiltered[index].image!,
                                        // 'https://www.dreamzone.co.in/blog/wp-content/uploads/2022/05/Sound-of-cartoon-characters-1.jpg'),
                                      )),
                                ),
                              ),
                              SizedBox(
                                width: 17,
                              ),
                              Column(
                                children: [
                                  Text(
                                    "${layoutCubit.userrrrrrrposts.length}",
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'posts',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 17,
                              ),
                              Column(
                                children: [
                                  Text(
                                    layoutCubit.usersFiltered[index].follwers !=
                                                null &&
                                            layoutCubit.usersFiltered[index]
                                                .follwers!.isNotEmpty
                                        ? '${layoutCubit.usersFiltered[index].follwers!.length}'
                                        : '0',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Followers',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 17,
                              ),
                              Column(children: [
                                Text(
                                  layoutCubit.usersFiltered[index].follwing!
                                              .length >
                                          0
                                      ? '${layoutCubit.usersFiltered[index].follwing!.length}'
                                      : '0',
                                  /* layoutCubit.usernavigate!.follwing!=null && layoutCubit.usernavigate!.follwing!.isNotEmpty
                                   ? '${layoutCubit.usernavigate!.follwing!.length}' :'0',*/
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
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
                        SizedBox(
                          height: 12,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 25),
                          child: Text(
                            layoutCubit.usersFiltered[index].title!,
                            style: TextStyle(
                              color: Colors.amber,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: MaterialButton(
                              // padding: EdgeInsets.symmetric(vertical: 22, horizontal: 22),
                              color: Colors.white,
                              onPressed: () {},
                              child: Text(
                                'Follow',
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        if (layoutCubit.userrrrrrrposts == null ||
                            layoutCubit.userrrrrrrposts.isEmpty)
                          Container(),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 33,
                            ),
                            itemCount: layoutCubit.userrrrrrrposts.length,
                            itemBuilder: (BuildContext context, int index) {
                              if (layoutCubit.userrrrrrrposts.length > 0)
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Image.network(
                                    "${postModel!.imgPost}"

                                    // layoutCubit.userrrrrrrposts[index].imgPost!

                                    // layoutCubit.userSearchedPosts[index].imgPost!
                                    //  postModel.imgPost![index]

                                    // 'https://www.dreamzone.co.in/blog/wp-content/uploads/2022/05/Sound-of-cartoon-characters-1.jpg',
                                    ,
                                    fit: BoxFit.fill,
                                  ),
                                );
                            },
                          ),
                        ),
                      ]);
                    }),
              ],
            )));
      },
    );
  }
}



/*
Scaffold(
            
         backgroundColor: mobileBackGroundColor,
        appBar: AppBar(
          backgroundColor: mobileBackGroundColor,
          title:   Text('n') ,
    
         ),
    
         body: Padding(
           padding: const EdgeInsets.only(left: 7,right: 7),
           child: Column(
            children: [
              Row(
                children: [
                   Container(
                    margin: EdgeInsets.only(left: 22),
                     child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Color.fromARGB(255, 114, 112, 107),
                       child: CircleAvatar(
                                radius: 35,
                                backgroundImage: NetworkImage(

                                    '${layoutCubit.userSearched[1]}'),
                              ),
                     ),
                   ),
               
               
               Expanded(
                 child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     Column(
                    children: [
                      Text('${layoutCubit.userposts.length}',style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),),
                      SizedBox(height: 5,),
                      Text('posts',style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),),
                    ],
                  ),
                 
                  SizedBox(width: 17,),
                  
                   Column(
                    children: [
                      Text( '0'  ,style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),),
                      SizedBox(height: 5,),
                      Text('Followers',style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),),
                    ],
                  ),
               
                   SizedBox(width: 17,),
                  
                  
                   Column(
                    children: [
                      Text(layoutCubit.userSearched[4]!=null && layoutCubit.userSearched[4].isNotEmpty ? '${layoutCubit.userSearched[4].length}' :'0' ,style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),),
                      SizedBox(height: 5,),
                      Text('Following',style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),),
                    ],
                  ),
                  ],
                 ),
               ),
                
                ],
              ),
         
              Container(
                width: double.infinity,
                margin: EdgeInsets.fromLTRB(15, 21, 0, 0),
                child: Text('${layoutCubit.userModel!.title}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Color.fromARGB(234, 255, 255, 255),),),),
            SizedBox(height: 15,),
             Divider(
              color: primaryColor,
              thickness: widthScreen>600 ? 0.05 : 0.44,
             ),
         
         
              SizedBox(height: 10,),
             Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               ElevatedButton(

                onPressed: (){},
                  
                  
                  
                  style: ButtonStyle(
                    backgroundColor:MaterialStateProperty.all(
                       Color.fromARGB(255, 94, 92, 92),
                    
                    ), 
                    
                    padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(vertical:widthScreen>600  ? 19 : 10,horizontal: 33,),
                    ),
                    
                
                    ), child: Text('Follow',style:TextStyle(fontSize: 25,fontWeight: FontWeight.bold,) ,),
                  ),
             
              
                  SizedBox(width:5,),
              
              ],
             ),
            
             SizedBox(height: 10,),
             Divider(
              color: primaryColor,
              thickness: widthScreen>600 ? 0.05 : 0.44,
             ),
         
         
         
         
             Expanded(
               child: Padding(
                 padding: widthScreen>600  ? const EdgeInsets.all(66)  :const EdgeInsets.all(8.0),
                 child: GridView.builder(
                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                     crossAxisCount: 2,
                     crossAxisSpacing: 10,
                     //childAspectRatio: 3/2,
                     mainAxisSpacing: 33,
                   ),
                   itemCount:layoutCubit.userposts.length,
                   itemBuilder: (BuildContext context, int index) {
                     return GestureDetector(
                      
                      onTap: () {
                      layoutCubit.showImageDialog(context, '${layoutCubit.userposts[index].imgPost}');
                      },
                       child: ClipRRect(
                         
                                         borderRadius: BorderRadius.circular(10.0),
                         child: Image.network(
                          '${layoutCubit.userposts[index].imgPost}'
                           
                         // 'https://www.dreamzone.co.in/blog/wp-content/uploads/2022/05/Sound-of-cartoon-characters-1.jpg'
                         ,fit: BoxFit.cover,
                         ),
                       ),
                     );
                   },
                 ),
               ),
             ),
            
            ],
           ),
         ),
      );
      */