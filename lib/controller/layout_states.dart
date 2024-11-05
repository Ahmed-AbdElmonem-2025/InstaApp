
abstract class LayoutStates   {}

class LayoutInitialState extends LayoutStates {}

class GetMyDataSuccessState extends LayoutStates {}
class GetMyDataLoadingState extends LayoutStates {}
class GetMyDataErrorState extends LayoutStates {}


class PostImageSelectedSuccessState extends LayoutStates {}
class PostImageSelectedLoadingState extends LayoutStates {}
class PostImageSelectedErrorState extends LayoutStates {}



// post
class CreatPostSuccessState extends LayoutStates {}
class CreatPostErrorState extends LayoutStates {}
class CreatPostLoadingState extends LayoutStates {}

 // get posts real time
 class GetPostRealTimesLoadingState extends LayoutStates {}
class GetPostRealTimesSuccessState extends LayoutStates {}


 // get user posts in his profile
class GetUserPostsInHisProfileLoadingState extends LayoutStates {}
class GetUserPostsInHisProfileSuccessState extends LayoutStates {}
class GetUserPostsInHisProfileErrorState extends LayoutStates {}

 class FilteredUsersuccessState extends LayoutStates {}
 class FilteredUserErrorState extends LayoutStates {}
 class FilteredUserLoadingState extends LayoutStates {}
 class GetUserSearchIsEmpty extends LayoutStates {}

  class FollowUserSuccessState extends LayoutStates {}
  class FollowUserErrorState extends LayoutStates {}



 class  UploadCommentToFireStoreSuccessState extends LayoutStates {}
 class  UploadCommentToFireStoreLoadingState extends LayoutStates {}
 class  UploadCommentToFireStoreErrorState extends LayoutStates {}

  class  LikeSuccessState extends LayoutStates {}
 class   UnLikeSuccessState extends LayoutStates {}
/*
class GetUsersLoadingState extends LayoutStates {}
class GetUsersDataSuccessState extends LayoutStates {}
class GetUsersDataErrorState extends LayoutStates {}


 class FilteredUsersuccessState extends LayoutStates {}

 class ChangeSearchEnabledSuccessState extends LayoutStates {}

 

class SendMessageSuccessState extends LayoutStates {}

class GetMessagesLoadingState extends LayoutStates {}
class GetMessagesSuccessState extends LayoutStates {}
class GetMessagesErrorState extends LayoutStates {} */