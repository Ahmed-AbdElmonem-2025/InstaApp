import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_app/controller/layout_cubit.dart';
import 'package:insta_app/controller/layout_cubit.dart';
import 'package:insta_app/controller/layout_cubit.dart';
import 'package:insta_app/controller/layout_states.dart';
import 'package:insta_app/screens/profile.dart';
import 'package:insta_app/screens/user_search_profile_screenn.dart';
 
import 'package:insta_app/shared/colors.dart';

class SearchPage extends StatelessWidget {
  SearchPage({Key? key}) : super(key: key);
  final searchConntroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final layoutCubit = BlocProvider.of<LayoutCubit>(context);
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: mobileBackGroundColor,
          appBar: AppBar(
            backgroundColor: mobileBackGroundColor,
            title: TextFormField(
              onChanged: (String value) {
                value = searchConntroller.text;
                layoutCubit.getUserSearch(username: value);
                layoutCubit.getUserSearchIsEmpty(value);
                
                /* if (value.isEmpty||value==null||searchConntroller.text.isEmpty||searchConntroller==null) {
              layoutCubit.usersFiltered.clear();
            }else{
              layoutCubit.getUserSearch(username: value);
            }*/
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter name';
                }
                return null;
              },
              style: TextStyle(
                color: Colors.white,
              ),
              controller: searchConntroller,
              decoration: const InputDecoration(
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
                // labelText: 'name',
                //labelStyle: TextStyle(color: Colors.white),
                hintText: 'search for a user',
                hintStyle: TextStyle(color: Colors.amber),
              ),
            ),
          ),
          body: layoutCubit.usersFiltered.isEmpty ||
                  layoutCubit.usersFiltered == null ||
                  searchConntroller.text.isEmpty
              ? const SizedBox()
              : Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: ListView.separated(
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: 10,
                      );
                    },
                    itemCount: layoutCubit.usersFiltered.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () async {
                              print('********************');
                          final user=await layoutCubit.getUserFromIndex(index);
                         // layoutCubit.iddddddddddd=user!.id;
                          final posts= await layoutCubit.getUserrrrrrrrPosts(user!.id!);
                          print("user from index: ${user.name}");
                         // print("Post from user: ${posts[0].username}");
                          print('********************');
                          if (layoutCubit.userrrrrrrposts.length>0) {
                             Navigator.push(context,
                             MaterialPageRoute(builder: (context) {
                            return UserSearchProfileScreen(
                              userModel: user,
                              
                              postModel: posts,
                            );
                            
                          }));
                          }else{
                            layoutCubit.userrrrrrrposts.clear();
                            
                             Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                              return UserSearchProfileScreen(
                              userModel: user,
                              
                               
                            );
                            
                          }));
                          }
                         
                        },
                        child: ListTile(
                          title: Text(
                            layoutCubit.usersFiltered[index].name!,
                            style: TextStyle(color: Colors.white),
                          ),
                          leading: CircleAvatar(
                              radius: 33,
                              backgroundImage: NetworkImage(
                                // 'https://thebentleyhotel.com/wp-content/uploads/2021/12/Best-30-Fun-Things-To-Do-in-Miami-Beach-in-2023-1000x500.jpg'),
                                layoutCubit.usersFiltered[index].image!,
                                
                              )),
                        ),
                        
                      );
                    },
                  ),
                ),
        );
      },
    );
  }
}
