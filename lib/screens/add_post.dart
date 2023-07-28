 

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_app/Auth/auth_cubit.dart';
import 'package:insta_app/Auth/auth_states.dart';
import 'package:insta_app/controller/layout_cubit.dart';
import 'package:insta_app/controller/layout_states.dart';
import 'package:insta_app/models/post_model.dart';
import 'package:insta_app/responsive/mobile.dart';
import 'package:insta_app/responsive/responsive.dart';
import 'package:insta_app/screens/home.dart';
 
import 'package:insta_app/shared/colors.dart';

class AddPostPage extends StatelessWidget {
    AddPostPage({Key? key}) : super(key: key);
  final postController = TextEditingController();

  @override
  Widget build(BuildContext context) {
     final layoutCubit = BlocProvider.of<LayoutCubit>(context) ;
     
    return
      
     BlocConsumer<LayoutCubit,LayoutStates>(
      
      listener: (context, state) {
        if (state is PostImageSelectedErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red,
                  content: Text('please choose photo'),
                ),
              );
          
           
        }else if(state is CreatPostSuccessState){
           ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.green,
                  content: Text('post uploaded successfully'),
                ),
              );
        }
        if (state is CreatPostSuccessState) {
          layoutCubit.postImgFile=null;
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
           return MobileScreen();
          }));
        }
        
    },
      builder: (context, state) {
        return 
        
        layoutCubit.postImgFile==null  ?     
        

        Scaffold(
          backgroundColor: mobileBackGroundColor,
          appBar: AppBar(
            backgroundColor: mobileBackGroundColor,
            title: const Text('Add Post'),
          ),
          body: Center(
            child: IconButton(
                onPressed: ()async {
                 await layoutCubit.getImage();
                   
                },
                icon: Icon(
                  Icons.upload,
                  size: 55,
                  color: Colors.white,
                )),
          ),
        )



        :
         Scaffold(
         backgroundColor: mobileBackGroundColor,
         
          appBar: AppBar(
            actions: [
              TextButton(onPressed: ()async {
               
                  if (postController.text==null||postController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red,
                  content: Text('please write a post'),
                ),
              );
                  }else{
                     await 
              layoutCubit.uploadPostToFireStore(
                description:postController.text , 
              // datePuplished: DateTime.now() ,

                
                );
                  }
             
               
              }, 
              child: Text('Post',style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold,color: Colors.blue,),),),
            ],
           leading: IconButton(onPressed: (){
              
             layoutCubit.imageNull();
             postController.clear();
             
              
           }, icon: Icon(Icons.arrow_back)),
           
             backgroundColor: mobileBackGroundColor,
              ),



    body: Column(
      children: [
        Divider(thickness: 1,color:Colors.white ,height: 20,),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CircleAvatar(
               radius: 33,
               backgroundImage: NetworkImage("https://www.dreamzone.co.in/blog/wp-content/uploads/2022/05/Sound-of-cartoon-characters-1.jpg"),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width*0.3,
              child: TextFormField(
                controller: postController,
               style: TextStyle(color: Colors.white,),
                maxLines: 8,
                decoration: InputDecoration(
                  hintText: "Write a post...",
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.white,)
                ),
              ),
            ),


            Container(
              width: 70,
              height: 74,
              decoration: BoxDecoration(
                image: DecorationImage(
                  //////////////////////////////////////////////
                  image: FileImage(layoutCubit.postImgFile!,),
                  //////////////////////////////////////////////////
                  fit: BoxFit.cover
                  
                  )
              ),
            )
          ],
        ),
      ],
    ),



         )
        
        
          
        
        
        
        
        ;
      },
    );
  }
}
