import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta_app/Auth/auth_states.dart';
import 'package:insta_app/constants.dart';
import 'package:insta_app/controller/layout_states.dart';
import 'package:insta_app/models/post_model.dart';
import 'package:insta_app/models/user_model.dart';
import 'package:path/path.dart';
import 'package:uuid/uuid.dart';

class LayoutCubit extends Cubit<LayoutStates> {
  LayoutCubit() : super(LayoutInitialState());

  static LayoutCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;
  void getMyData() async {
    emit(GetMyDataLoadingState());
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(Constants.userId!)
          .get()
          .then((value) {
        userModel = UserModel.fromJson(data: value.data()!);
      });
      emit(GetMyDataSuccessState());
    } on FirebaseException catch (e) {
      emit(GetMyDataErrorState());
    }
  }

// image post

  File? postImgFile;
  getImage() async {
    final XFile? pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    try {
      if (pickedImage != null) {
        postImgFile = File(pickedImage.path);
        debugPrint("File issssssssssssssssssssssssss : ${postImgFile}");
        emit(PostImageSelectedSuccessState());
      } else {
        emit(PostImageSelectedErrorState());
      }
    } catch (e) {
      print('error for get image.......$e.......................');
      emit(PostImageSelectedErrorState());
    }
  }

  void imageNull() {
    postImgFile = null;
    emit(PostImageSelectedErrorState());
  }

  Future<String> uploadImageToStorage() async {
    debugPrint("File issssssssssssssssssssssssss : ${postImgFile}");
    Reference imageRef =
        FirebaseStorage.instance.ref(basename(postImgFile!.path));

    await imageRef.putFile(postImgFile!);

    return await imageRef.getDownloadURL();
  }

  //PostModel?  postModel;
  uploadPostToFireStore({
    required String description,
    // required String datePuplished,
    //  List? likes,
  }) async {
    emit(CreatPostLoadingState());

    String imgPostUrl = await uploadImageToStorage();

    if (postImgFile == null && postImgFile.toString().isEmpty) {
      emit(PostImageSelectedErrorState());
    } else {
      String newId = Uuid().v1();

      PostModel postModel = PostModel(
        profileImg: userModel!.image,
        username: userModel!.name,
        description: description,
        imgPost: imgPostUrl,
        uid: Constants.userId,
        // uid: userModel!.id,
        // postId: Random().nextInt(20000).toString(),
        postId: newId,
        datePuplished: DateTime.now().toString(),
        likes: [],
      );
      try {
        print('creatttttttttttt try');
        await FirebaseFirestore.instance
            .collection('posts')
            // .doc(Random().nextInt(20000).toString())
            .doc(newId)
            .set(postModel.toJson());
        emit(CreatPostSuccessState());
        print("///////////////////" "{$postModel}" "///////////////////");
        print('done.......................');
      } on FirebaseException catch (e) {
        emit(CreatPostErrorState());
      }
    }
  }

// get posts real time at home screen
  List<PostModel> posts = [];

  getPosts() {
    emit(GetPostRealTimesSuccessState());
    FirebaseFirestore.instance
        .collection('posts')
        .orderBy('datePuplished', descending: true)
        .snapshots()
        .listen((value) {
      posts.clear();
      for (var item in value.docs) {
        posts.add(PostModel.fromJson(data: item.data()));
        print(
            "///////////////////" "{$posts.toString()}" "///////////////////");
      }

      emit(GetPostRealTimesLoadingState());
    });
  }

// مراجعة كيف يتم استدعاء الداتا تدريجيا من الفايربيز
  List<PostModel> userposts = [];

  void getUserPosts() async {
    // userposts.clear();
    emit(GetUserPostsInHisProfileLoadingState());
    try {
      //  userposts.clear();

      emit(GetUserPostsInHisProfileLoadingState());
      await FirebaseFirestore.instance
          .collection('posts')
          .where('uid', isEqualTo: Constants.userId!)
          // هنا مشكلة عندما اقوم بترتيب الوتاريخ والوقت لا يت ظهور بوستات الشخص المسجل
          // .orderBy('datePuplished', descending: true)
          .get()
          .then((value) {
        userposts.clear();
        for (var item in value.docs) {
          userposts.add(PostModel.fromJson(data: item.data()));
          print(
              "hhhhhhhhhhh this is user data in profile ======== ${item.data()} ===================");
        }
      });

      emit(GetUserPostsInHisProfileSuccessState());
    } on FirebaseException catch (e) {
      emit(GetUserPostsInHisProfileErrorState());
    }
  }

  // دالة لعرض الصورة في نافذة منفصلة
  void showImageDialog(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Image.network(
            imageUrl,
          ), // استخدام الصورة المستلمة هنا
        );
      },
    );
  }

  List<UserModel> users = [];
  List<UserModel> usersFiltered = [];
  // List<String> uidsToShow = [];

  // UserModel? userModelForId;
  //  String?  id;
  // ده بيتغير فين ؟
  UserModel? userModelllll;
// String? iddddddddddd;

  UserModel? getUserFromIndex(index) {
    userModelllll = usersFiltered[index];
    // iddddddddddd=usersFiltered[index].id;
    if (userModelllll!.follwers!.contains(Constants.userId)) {
      showFollow = false;
    } else {
      showFollow = true;
    }
    return userModelllll;
  }

  // var index = 0;
  void getUserSearch({required String username}) {
    users.clear();
    usersFiltered.clear();
    FirebaseFirestore.instance.collection('users').get().then((value) {
      for (var item in value.docs) {
        users.add(UserModel.fromJson(
          data: item.data(),
        ));
      }
    }).then((value) {
      emit(FilteredUserLoadingState());
      // usersFiltered.clear();

      usersFiltered = users.where((element) {
        return element.name!.toLowerCase().contains(username.toLowerCase());
      }).toList();
      //هنا المشكلة بيجيب اندكس 0 على طول
      //getUserrrrrrrrPosts(usersFiltered[index].id);
      // print(usersFiltered.length);

      ////////////

      emit(FilteredUsersuccessState());
    }).catchError((context) {
      emit(FilteredUserErrorState());
    });
  }

  List<PostModel> userrrrrrrposts = [];

  Future<List<PostModel>> getUserrrrrrrrPosts(String uId) async {
    try {
      userrrrrrrposts.clear();
      QuerySnapshot<Map<String, dynamic>> myData =
          (await FirebaseFirestore.instance
              .collection('posts')
              .where('uid', isEqualTo: uId)
              // .doc(uid)
              .get());
      for (var element in myData.docs) {
        userrrrrrrposts.add(
          PostModel.fromJson(data: element.data()),
        );
      }
      emit(PostImageSelectedSuccessState());
      return userrrrrrrposts;
    } catch (e) {
      throw PlatformException(code: "404");
      // emit(PostImageSelectedErrorState());
    }
  }

  getUserSearchIsEmpty(String value) {
    if (value.isEmpty || value == null) {
      usersFiltered.clear();
      userrrrrrrposts.clear();
      emit(GetUserSearchIsEmpty());
    }
  }

  // follow and un follow
  bool showFollow = true;
  //int followers = 0;
// UserModel? userModellll;
  void follow({required int followers, required int following}) async {
    showFollow = !showFollow;

    if (showFollow == false) {
      userModelllll!.follwers!.length++;
      // userModelllll!.follwing!.length++;
      await addfollow();
      emit(FollowUserSuccessState());
    } else {
      userModelllll!.follwers!.length--;
      // userModelllll!.follwing!.length--;
      await removefollow();
      emit(FollowUserSuccessState());
    }

    // emit(GetUserSearchIsEmpty());
  }

  addfollow() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userModelllll!.id)
        .update({
      'follwers': FieldValue.arrayUnion([Constants.userId])
    });

    await FirebaseFirestore.instance
        .collection('users')
        .doc(Constants.userId)
        .update({
      'follwing': FieldValue.arrayUnion([userModelllll!.id])
    });

    // emit(PostImageSelectedErrorState());
  }

  removefollow() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userModelllll!.id)
        .update({
      'follwers': FieldValue.arrayRemove([Constants.userId])
    });

    await FirebaseFirestore.instance
        .collection('users')
        .doc(Constants.userId)
        .update({
      'follwing': FieldValue.arrayRemove([userModelllll!.id])
    });

    //emit(PostImageSelectedErrorState());
  }

  // upload Comment To FireStore
  uploadCommentToFireStore({
    required commentText,
    required postId,
  }) async {
    emit(UploadCommentToFireStoreLoadingState());
    try {
      if (commentText.isNotEmpty) {
        String commentId = Uuid().v1();
        await FirebaseFirestore.instance
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .set({
          'profilePic': userModel!.image,
          'username': userModel!.name,
          'textComment': commentText,
          'datePublished': DateTime.now(),
          'uid': userModel!.id,
          'commentId': commentId,
        });
        emit(UploadCommentToFireStoreSuccessState());
      } else {
        print('emptyyyyy');
      }
    } on FirebaseException catch (e) {
      emit(UploadCommentToFireStoreErrorState());
    }
  }




// get Comment From FireStore as a real time
  List/*<Map<String, dynamic>>*/ comments=[];
 /*Future <List<Map<String, dynamic>>?>*/ getCommentFromFireStore({required postId}) async {
   // emit(GetMyDataErrorState());
      comments.clear();
    await FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments').orderBy('datePublished',descending: true)
        .snapshots()
        .listen((event) {
          comments.clear();
      for (var element in event.docs) {
        comments.add(element.data());
      }
       
      emit(GetMyDataSuccessState());
    });
 



    /*  Future aaa()async {
   var data =     FirebaseFirestore.instance
    .collection('users')
    .doc(userModelllll!.id).get();
  for (var element in data) {
    
  }
  }*/

    /*
    PostModel? postModel;
    List<PostModel> a=[];
  getUserrPosts({required String uid}) async {
    
   
    try {
      if (uid != null) {

        
        QuerySnapshot<Map<String, dynamic>> myData =
            (await FirebaseFirestore.instance
                .collection('posts')
                .where('uid',isEqualTo:uid /*usersFiltered[0].id*/)
                // .doc(uid)
                .get());
  
          for (var element in myData.docs) {
           
          /*  print('////////////////////////////////');
            print('{$uid"lllllllllllllllll"}');
            print('////////////////////////////////');
      
  */
         a.add(PostModel.fromJson(data: element.data()))   ;
          
          
        }
        emit(PostImageSelectedSuccessState());
      }
    } catch (e) {
      emit(PostImageSelectedErrorState());
    }
  }
*/
  }

/* List<PostModel> userSearchedPosts = [];
 getUserSearchedPosts() async {
  if (uid != null) {
    userSearchedPosts.clear(); // قم بمسح القائمة قبل جلب البيانات الجديدة
    var querySnapshot = await FirebaseFirestore.instance
        .collection('posts')
        .where('uid', isEqualTo: uid)
        .get();

    userSearchedPosts = querySnapshot.docs.map((doc) {
      return PostModel.fromJson(data: doc.data());
    }).toList();
  }
}
*/

/*    .then((value) {
        userposts.clear();
        for (var item in value.docs) {
          userposts.add(PostModel.fromJson(data: item.data()));
          print(
              "hhhhhhhhhhh this is user data in profile ======== ${item.data()} ===================");
        }
      });*/

/*
 getUserSearchedPosts() async {
  if (uid != null) {
    await FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: uid)
        .get()
        .then((value) {
      // قم بمسح قائمة البوستات السابقة قبل تحديثها بالبوستات الجديدة
      userSearchedPosts.clear();

      // تحقق من وجود نتائج مسترجعة قبل تخزينها في القائمة
      if (value.docs.isNotEmpty) {
        for (var item in value.docs) {
          // قم بإضافة البوستات المسترجعة من قاعدة البيانات إلى قائمة البوستات
          userSearchedPosts.add(PostModel.fromJson(data: item.data()));
        }

        // يمكنك هنا إصدار إشعار أو تحديث واجهة المستخدم بالبوستات المسترجعة
        // يعتمد هذا على كيفية بناء واجهة المستخدم الخاصة بصفحة عرض البوستات
      }
    }).catchError((error) {
      // إذا حدث خطأ أثناء جلب البوستات، يمكنك إصدار إشعار أو تحديث واجهة المستخدم برسالة الخطأ
      print("Error fetching posts: $error");
    });
  }
 */

// .where(uid,isEqualTo:FirebaseFirestore.instance.collection('users').doc('userId') ){

/*if (uid!=null) {

      await FirebaseFirestore.instance
          .collection('posts')
          //.where(usersFiltered, /*isEqualTo:FirebaseFirestore.instance.collection('users').doc('userId')*/ )
      .doc(uid)
           
          .get()
          .then((value) {
         userSearchedPosts.add(PostModel.fromJson(data: value.data()!));
    });*/

/* userSearchedPosts.clear();
        value.forEach((element) {
        userSearchedPosts.add(PostModel.fromJson(data: element));
         });*/

/*
// مراجعة كيف يتم استدعاء الداتا تدريجيا من الفايربيز
 List<PostModel> userSearchedposts = [];
   
  void getUserSearchedPosts() async {
    try {
    emit(GetUserPostsInHisProfileLoadingState());
      await FirebaseFirestore.instance
          .collection('posts').id 
          .where(FirebaseFirestore.instance ).orderBy('datePuplished',descending: true)
          .get()
          .then((value) {
            userSearchedposts.clear();
         for (var item in value.docs) {
           
           userposts.add(PostModel.fromJson(data: item.data()));
          
     
    }});
     emit(GetUserPostsInHisProfileSuccessState());
    } on FirebaseException catch (e) {
     emit(GetUserPostsInHisProfileErrorState());
    }
  }


*/

/*

  post({
    required String profileImg,
    required String username,
    required String description,
    required String imgPost,   
  }) async {
    emit(CreatPostLoadingState());
     print('uploaded image');
      try {
  
    
  
      String imgUrl = await uploadImageToStorage();
    
   
     await   uploadPostToFireStore(
        profileImg: profileImg, 
        username: username, 
        description: description, 
        imgPost: imgUrl, 
        uid: Constants.userId.toString(),// or FirebaseAuth.instance.currentUser!.uid, 
        postId: Random().nextInt(200000).toString(), 
        datePuplished: DateTime.now(), 
      //  likes: []
        );
      emit(CreatPostSuccessState());
      print('uploadPostToFireStore');
    
}  catch (e) {
  print(e.toString());
  emit(CreatPostErrorState());
}
     
   
  }
   
  */

/*  List<UserModel> users = [];
  void getUsers() async {
    users.clear();
    emit(GetUsersLoadingState());
    try {
      await FirebaseFirestore.instance.collection('Users').get().then((value) {
        for (var item in value.docs) {
          if (item != Constants.userId) {
            users.add(UserModel.fromJson(data: item.data()));
          }

          emit(GetUsersDataSuccessState());
        }
      });
    } on FirebaseException catch (e) {
      users = [];
      emit(GetUsersDataErrorState());
    }
  }*/

/* List<UserModel> usersFiltered = [];

  void searchAboutUser({required String query}) {
    usersFiltered = users
        .where((element) =>
            element.name!.toLowerCase().startsWith(query.toLowerCase()))
        .toList();
    emit(FilteredUsersuccessState());
  }*/

/* bool SearchEnabled = false;

  void changeSearchStatus() {
    SearchEnabled = !SearchEnabled;
    if (SearchEnabled == false) usersFiltered.clear();
    emit(ChangeSearchEnabledSuccessState());
  }*/

/* void sendMessage({
    required String message,
    required String recieverID,
  })async {
    MessageModel messageModel = MessageModel(
        content: message,
        date: DateTime.now().toString(),
        senderID: Constants.userId);

       // save data on my doc
  await  FirebaseFirestore.instance
        .collection('Users')
        .doc(Constants.userId)
        .collection('Chat')
        .doc(recieverID).collection('Messages').add(messageModel.toJson());

       // save data on receiver doc
      await FirebaseFirestore.instance.collection('Users').doc(recieverID).collection('Chat')
       .doc(Constants.userId).collection('Messages').add(messageModel.toJson());
        emit(SendMessageSuccessState());
  }*/

/* List<MessageModel> messages=[];
  void getMessages({required String recieverID}){
  
    emit(GetMessagesLoadingState());
    FirebaseFirestore.instance.collection('Users').doc(Constants.userId).collection('Chat')
    .doc(recieverID).collection('Messages').orderBy('date').snapshots().listen((value) {
        messages.clear();
      for (var item in value.docs) {
        messages.add(MessageModel.fromJson(data: item.data()));
        
      }
      emit(GetMessagesSuccessState());
     });
  }*/
}
