class ApiModel {
  int id;
  String Name;
  String Email;
  String Address;
  String Company; // this is the values that are there in the api as json format
  //here we are using the MVVM (Model View ViewModel)to Make the code clean and formated

  ApiModel(
      {required this.id,
      required this.Name,
      required this.Company,
      required this.Address,
      required this.Email});

  //this is the constructed that is called when we use this method and all the values should be given since it is required

  factory ApiModel.fromJson(Map<String, dynamic> json) {
    return ApiModel(
        // this method used to covert the data from json,its a factory method
        id: json["id"],
        Name: json["Name"],
        Company: json["Company"],
        Address: json["Address"],
        Email: json["Email"]);
  }

  Map<String, dynamic> toJson() {
    /// this method is used to conveting data to json
    return {
      //generally we don't need this because the post in http automatically converts to json format if we want to convert object into json we use this method
      "id": id,
      "Name": Name,
      "Company": Company,
      "Email": Email,
      "Address": Address,
    };
  }
}
