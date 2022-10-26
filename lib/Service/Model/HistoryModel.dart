class HistoryDB {
  HistoryDB({
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
  late List<HistoryDBAPI> data;
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

  factory HistoryDB.fromJson(Map<String, dynamic> json) => HistoryDB(
        currentPage: json["current_page"],
        data:
            List<HistoryDBAPI>.from(json["data"].map((e) => HistoryDBAPI.fromJson(e))),
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

class HistoryDBAPI {
  HistoryDBAPI({
    required this.his_id,
    required this.car_chassis,
    required this.fullname,
    required this.lastname,

    required this.date,
    required this.time,
    required this.carStatus,
    required this.carWhere,
  });

  int his_id;
  String car_chassis;
  String fullname;
  String lastname;
  String date;
  String time;
  CarStatus carStatus;
  CarWhere carWhere;

  factory HistoryDBAPI.fromJson(Map<String, dynamic> json) => HistoryDBAPI(
        his_id: json["his_id"],
        car_chassis: json["car_chassis"],
        fullname: json["fullname"],
        lastname: json["lastname"],
        date: json["date"],
        time: json["time"],
        carWhere: CarWhere.fromJson(json["car_where"]),
        carStatus: CarStatus.fromJson(json["car_status"]),
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
    required this.status_id,
    required this.car_status,
  });

  int status_id;
  String car_status;

  factory CarStatus.fromJson(Map<String, dynamic> json) => CarStatus(
        status_id: json["status_id"],
        car_status: json["car_status"],
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
