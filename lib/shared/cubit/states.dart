abstract class AppStates {}

class AppInitialState extends AppStates {}


class GetCategoriesDataLoadingState extends AppStates {}
class GetDataCategoriesSuccessState extends AppStates {}
class pickedImageSuccessfulState extends AppStates {}
class GetDataCategoriesErrorState extends AppStates {
  final String? error;

  GetDataCategoriesErrorState(this.error);
}

class CreateMessageAllLoadingState extends AppStates {}
class CreateMessageAllErrorState extends AppStates {
  final String? error;

  CreateMessageAllErrorState(this.error);

}
class CreateMessageAllSuccessState extends AppStates {
  final String? success;

  CreateMessageAllSuccessState(this.success);
}


class CreateMessageToLoadingState extends AppStates {}
class CreateMessageToErrorState extends AppStates {
  final String? error;

  CreateMessageToErrorState(this.error);

}
class CreateMessageToSuccessState extends AppStates {
  final String? success;

  CreateMessageToSuccessState(this.success);
}


class GetMessagesAllLoadingState extends AppStates {}
class GetMessagesAllSuccessState extends AppStates {}
 class GetMessagesAllErrorState extends AppStates {
  final String? error;

  GetMessagesAllErrorState(this.error);
}



class CreateMessagesToLoadingState extends AppStates {}
class CreateMessagesToErrorState extends AppStates {
  final String? error;

  CreateMessagesToErrorState(this.error);

}
class CreateMessagesToSuccessState extends AppStates {
  final String? success;

  CreateMessagesToSuccessState(this.success);
}


class CreateShiftsDataLoadingState extends AppStates {}
class CreateShiftsDataErrorState extends AppStates {
  final String? error;

  CreateShiftsDataErrorState(this.error);

}
class CreateShiftsDataSuccessState extends AppStates {
  final String? success;

  CreateShiftsDataSuccessState(this.success);
}


class GetCarsTypeLoadingState extends AppStates {}
class GetCarsTypeSuccessState extends AppStates {}
class GetCarsTypeErrorState extends AppStates {
  final String? error;

  GetCarsTypeErrorState(this.error);
}