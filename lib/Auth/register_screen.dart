import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_app/Auth/auth_cubit.dart';
import 'package:insta_app/Auth/auth_states.dart';
import 'package:insta_app/Auth/login_screen.dart';
import 'package:insta_app/shared/colors.dart';

class Registercreen extends StatelessWidget {
  Registercreen({super.key});
  final nameConntroller = TextEditingController();
  final titleConntroller = TextEditingController();
  final emailConntroller = TextEditingController();
  final passConntroller = TextEditingController();
   final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final double widthScreen = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('Register'),
        ),
        backgroundColor:mobileBackGroundColor,
        body: BlocConsumer<AuthCubit, AuthStates>(
          listener: (context, state) {
             if (state is UserImageSelectedErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                backgroundColor: Colors.red,
                content: Text('please choose photo'),
              ));

              
            }
           else if (state is UserCreatedErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red,
                  content: Text('${state.message}'),
                ),
              );
            }
          


            


          else  if (state is UserCreatedSucessState) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                backgroundColor: Colors.green,
                content: Text('Done...'),
              ));

               Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
            }

            
          },
          builder: (context, state) {
            //final AuthCubit  authCubit =  BlocProvider.of<AuthCubit>(context);
            return Padding(
              padding: widthScreen > 600
                  ? EdgeInsets.symmetric(horizontal: widthScreen * 0.25)
                  : const EdgeInsets.all(15),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BlocProvider.of<AuthCubit>(context).userImgFile != null
                          ? Center(
                              child: Column(
                                
                                children: [
                                  SizedBox(height: 50,),
                                  CircleAvatar(
                                    radius: 60,
                                    backgroundImage: FileImage(
                                        BlocProvider.of<AuthCubit>(context)
                                            .userImgFile!),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      BlocProvider.of<AuthCubit>(context)
                                          .getImage();
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.image,
                                          color: Colors.white,
                                        ),
                                        SizedBox(width: 10,),
                                        Text('change photo',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.amber,
                                        ),),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Column(
                            children: [
                               SizedBox(height: 60,),
                              OutlinedButton(
                                  onPressed: () {
                                    BlocProvider.of<AuthCubit>(context).getImage();
                                  },
                                  child: Row(
                          
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.image,
                                        color: Colors.green,
                                        size: 70,
                                      ),
                                      const SizedBox(
                                        width: 7,
                                      ),
                                      const Text('select photo',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                              return 'Please enter name';
                                     }
                                      return null;
                        },
                        style: TextStyle(color: Colors.white,),
                        controller: nameConntroller,
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
                          labelText: 'name',
                          labelStyle: TextStyle(color: Colors.white),
                          hintText: 'Enter Your Name',
                         hintStyle: TextStyle(
                          color: Colors.amber
                         ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                      return 'Please enter title';
                    }
                    return null;
                        },
                        style: TextStyle(color: Colors.white,),
                        controller: titleConntroller,
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
                          labelText: 'Title',
                          labelStyle: TextStyle(color: Colors.white),
                          hintText: 'Enter Your title',
                         hintStyle: TextStyle(
                          color: Colors.amber
                         ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                      return 'Please enter email';
                    }
                    return null;
                        },
                        style: TextStyle(color: Colors.white,),
                        controller: emailConntroller,
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
                          labelText: 'Email',
                          labelStyle: TextStyle(color: Colors.white),
                          hintText: 'Enter Your Email',
                         hintStyle: TextStyle(
                          color: Colors.amber
                         ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                      return 'Please enter password';
                    }
                    return null;
                        },
                        style: TextStyle(color: Colors.white,),
                        controller: passConntroller,
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
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Colors.white),
                          hintText: 'Enter Your Password',
                         hintStyle: TextStyle(
                          color: Colors.amber
                         ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      MaterialButton(
                        minWidth: double.infinity,
                        color: Colors.white,
                        textColor: Colors.black,
                        onPressed: () {
                         if (_formKey.currentState!.validate()) {
                           BlocProvider.of<AuthCubit>(context).register(
                                name: nameConntroller.text,
                                email: emailConntroller.text,
                                title: titleConntroller.text,
                                password: passConntroller.text);
                         }
                
                            else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text('please fill email, password')));
                          }
                        },
                        child: state is RegisterLoadingState
                            ? const SizedBox(
                              width: 25,
                              height: 25,
                              child:  CircularProgressIndicator(
                                  color: Colors.black,
                                  strokeWidth: 5,
                                  
                                ),
                            )
                            : const Text('Sign Up',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,),),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
