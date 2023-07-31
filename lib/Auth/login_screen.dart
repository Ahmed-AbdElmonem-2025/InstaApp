
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_app/Auth/auth_cubit.dart';
import 'package:insta_app/Auth/auth_states.dart';
import 'package:insta_app/Auth/register_screen.dart';
import 'package:insta_app/responsive/mobile.dart';
import 'package:insta_app/responsive/responsive.dart';
import 'package:insta_app/responsive/web.dart';
import 'package:insta_app/screens/home.dart';
import 'package:insta_app/shared/colors.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final emailConntroller = TextEditingController();
  final passConntroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double widthScreen = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Sign in'),
          backgroundColor: Colors.black,
        ),
        backgroundColor: mobileBackGroundColor,
          body: BlocConsumer<AuthCubit, AuthStates>(
        listener: (context, state) {
          if (state is LoginErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: Text('${state.message}'),
              ),
            );
          }
    
          if (state is LoginSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Colors.green,
              content: Text('Done...'),
            ));
    
            Navigator.push(
                context, MaterialPageRoute(builder: (context) =>  Responsive(mobScreen:MobileScreen() ,webScreen:WebScreen() )));
          }
        },
        builder: (context, state) {
         // final AuthCubit authCubit = BlocProvider.of<AuthCubit>(context);
    
          return Padding(
            padding: widthScreen>600 ?   EdgeInsets.symmetric(horizontal: widthScreen*0.25)   : const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
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
                        labelText: 'email',
                        labelStyle: TextStyle(color: Colors.white),
                        hintText: 'Enter Your email',
                       hintStyle: TextStyle(
                        color: Colors.amber
                       ),
                      ),
                    ),




















                const SizedBox(
                  height: 20,
                ),
               

              TextFormField(
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
                        labelText: 'password',
                        labelStyle: TextStyle(color: Colors.white),
                        hintText: 'Enter Your password',
                       hintStyle: TextStyle(
                        color: Colors.amber
                       ),
                      ),
                    ),













                SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  minWidth: double.infinity,
                  color: Colors.white,
                  textColor: Colors.white,
                  onPressed: () {
                    if (emailConntroller.text.isNotEmpty &&
                        passConntroller.text.isNotEmpty) {
                   BlocProvider.of<AuthCubit>(context).login(
                          email: emailConntroller.text,
                          password: passConntroller.text);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          backgroundColor: Colors.red,
                          content: Text('please fill email, password')));
                    }
                  },
                  child: state is LoginLoadingState
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text('Login',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.black),),
                ),

                 SizedBox(height: 50,),
                      Center(child: Container(
                        color: Color.fromARGB(255, 46, 45, 45),
                        child: TextButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return Registercreen();
                          }));
                        }, child: Text('you do not have an acount?  Register',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.amber,),))))
              ],
            ),
          );
        },
      )),
    );
  }
}
