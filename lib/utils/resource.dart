abstract class OurResource {
  String? errorMessage;
  dynamic successData;

  OurResource({this.errorMessage, this.successData});
}

class OurSuccess extends OurResource {
  OurSuccess(dynamic successData)
      : super(errorMessage: null, successData: successData);
}

class OurError extends OurResource {
  OurError(String errorMessage)
      : super(errorMessage: errorMessage, successData: null);
}
