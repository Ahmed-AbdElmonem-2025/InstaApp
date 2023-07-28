 
 
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_app/cubit/home_states.dart';
 
class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(IntitialHomeState());

   static HomeCubit get(context) => BlocProvider.of(context);


bool selectedColor = true;
   int currentIndex=0;

    void changeBottomNavBar(int index,){
      
      currentIndex=index;
     selectedColor = !selectedColor;
       emit(ChangeBottomNavState());
    }


    navigateToScreen( int index ){

       currentIndex=index;
         emit(ChangeBottomNavState());
    }
   
  }
 
