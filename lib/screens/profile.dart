import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_app/controller/layout_cubit.dart';
import 'package:insta_app/controller/layout_states.dart';
import 'package:insta_app/models/post_model.dart';
import 'package:insta_app/models/user_model.dart';
import 'package:insta_app/shared/colors.dart';

class ProfilePage extends StatelessWidget {
    ProfilePage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
   final layoutCubit = BlocProvider.of<LayoutCubit>(context)..getUserPosts();
    final double widthScreen =MediaQuery.of(context).size.width;
    
    return BlocConsumer<LayoutCubit,LayoutStates>(
      listener: (context, state) {
        
      },
      builder: (context, state) {
         
        return state is GetMyDataLoadingState ? const Center(child: CircularProgressIndicator(color: Colors.black,))
          : Scaffold(
            
         backgroundColor: mobileBackGroundColor,
        appBar: AppBar(
          backgroundColor: mobileBackGroundColor,
          title:   Text('${layoutCubit.userModel!.name}') ,
    
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

                                    '${layoutCubit.userModel!.image}'),
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
                      Text( '${layoutCubit.userModel!.follwers!.length}'  ,style: TextStyle(
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
                      Text( '${layoutCubit.userModel!.follwing!.length}'  ,style: TextStyle(
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
               ElevatedButton.icon(
                onPressed: (){},
                 icon: Icon(Icons.edit,
                color: Colors.grey,
                 size: 24,
                 ),
                  label: Text('Edit Profile',
                  style: TextStyle(fontSize: 17,),
                  ),
                  style: ButtonStyle(
                    backgroundColor:MaterialStateProperty.all(
                      Color.fromARGB(0, 90, 103, 223),
                    
                    ), 
                    padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(vertical:widthScreen>600  ? 19 : 10,horizontal: 33,),
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                        side: BorderSide(
                          color: Color.fromARGB(109, 255, 255, 255),
                          style: BorderStyle.solid,
                        )
                      ),
                      
                    ),
                    ),
                  ),
             
             
             
                  SizedBox(width:5,),
             
             
             
                   ElevatedButton.icon(
                onPressed: (){},
                 icon: Icon(Icons.logout,
              
                 size: 24,
                 ),
                  label: Text('Log out',
                  style: TextStyle(fontSize: 17,),
                  ),
                  style: ButtonStyle(
                    backgroundColor:MaterialStateProperty.all(
                      Color.fromARGB(143, 255, 55, 112),
                    
                    ), 
                    padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(vertical: widthScreen>600  ? 19 : 10,horizontal: 33,),
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                      ),
                    ),
                    ),
                  ),
             
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
      },
       
    );
  }
}


