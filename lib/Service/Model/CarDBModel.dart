class CarDB{
  CarDB({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,

  });
  int currentPage;
  late List<CarDBAPI> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  List<Link> links;
  dynamic nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  factory CarDB.fromJson(Map<String, dynamic> json) => CarDB(
        currentPage: json["current_page"],
        data: List<CarDBAPI>.from(json["data"].map((e) => CarDBAPI.fromJson(e))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );
}

class CarDBAPI{
  CarDBAPI({
    required this.carId,
    required this.carChassis,
    required this.positId,
    required this.carStatus,
    required this.person,
  
    required this.date,
    required this.time,
    required this.sort, 
    required this.carWhere,

  });
  int carId;
  String carChassis;
  PositId positId;
  CarStatus carStatus;
  Person person;

  String date;
  String time;
  String sort;
  CarWhere carWhere;

  factory CarDBAPI.fromJson(Map<String, dynamic> json) => CarDBAPI(
        carId: json["car_id"],
        carChassis: json["car_chassis"],
        carStatus: CarStatus.fromJson(json["car_status"]),
        positId: PositId.fromJson(json["posit_id"]),
        person: Person.fromJson(json["person"]),
        date: json["date"],
        time: json["time"],
        sort: json["sort"],
        carWhere: CarWhere.fromJson(json["car_where"]),
      );

}


class Person {
  Person({
    required this.id,
    required this.fullname,
    required this.lastname,

  });
  int id;
  String fullname;
  String lastname;

  factory Person.fromJson(Map<String, dynamic> json) => Person(
        id: json["id"],
        fullname: json["fullname"],
        lastname: json["lastname"],
      );
}


class PositId {
  PositId({
    required this.positId,
    required this.line,
    required this.car_status,
    required this.posit,
    required this.sort,

 
  });

  int positId;
  String line;
  int car_status;
  int posit;
  int sort;

  
  factory PositId.fromJson(Map<String, dynamic> json) => PositId(
        positId: json["posit_id"],
        line: json["line"],
        car_status: json["car_status"],
        posit: json["posit"],
        sort: json["sort"],
      
       
      
      );
}
class CarWhere {
  CarWhere({
    required this.whereId,
    required this.carWhere,
  });

  int whereId;
  String carWhere;

  factory CarWhere.fromJson(Map<String, dynamic> json) => CarWhere(
        whereId: json["where_id"],
        carWhere: json["car_where"],
      );
}


class CarStatus {
  CarStatus({
    required this.statusId,
    required this.carStatus,
  });

  int statusId;
  String carStatus;

  factory CarStatus.fromJson(Map<String, dynamic> json) => CarStatus(
        statusId: json["status_id"],
        carStatus: json["car_status"],
      );
}

class Link {
  Link({
    required this.url,
    required this.label,
    required this.active,
  });

  String? url;
  String label;
  bool active;

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"] ?? "",
        label: json["label"],
        active: json["active"],
      );
}
