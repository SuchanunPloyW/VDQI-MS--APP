class ResponseModel{
  ResponseModel({required this.success, this.message = ""});

  late bool success;
  late String message;
}