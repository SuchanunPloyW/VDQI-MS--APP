class Car {
  Car({
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
  late List<CarAPI> data;
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

  factory Car.fromJson(Map<String, dynamic> json) => Car(
        currentPage: json["current_page"],
        data: List<CarAPI>.from(json["data"].map((e) => CarAPI.fromJson(e))),
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

class CarAPI {
  CarAPI({
    required this.carId,
    required this.carChassis,
    required this.carStatus,
    required this.carWhere,
    required this.carPosition,
    required this.fullname,
    required this.lastname,
    required this.date,
    required this.time,
    required this.carLine,
  });

  int carId;
  String carChassis;
  CarStatus carStatus;
  CarWhere carWhere;
  String carPosition;
  String fullname;
  String lastname;
  DateTime date;
  String time;
  String carLine;

  factory CarAPI.fromJson(Map<String, dynamic> json) => CarAPI(
        carId: json["car_id"],
        carChassis: json["car_chassis"],
        carStatus: CarStatus.fromJson(json["car_status"]),
        carWhere: CarWhere.fromJson(json["car_where"]),
        carPosition: json["car_position"],
        fullname: json["fullname"],
        lastname: json["lastname"],
        date: DateTime.parse(json["date"]),
        time: json["time"],
        carLine: json["car_line"],
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
