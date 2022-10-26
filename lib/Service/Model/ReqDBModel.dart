class ReqDB {
  ReqDB({
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
  late List<ReqDBAPI> data;
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

  factory ReqDB.fromJson(Map<String, dynamic> json) => ReqDB(
        currentPage: json["current_page"],
        data:
            List<ReqDBAPI>.from(json["data"].map((e) => ReqDBAPI.fromJson(e))),
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

class ReqDBAPI {
  ReqDBAPI({
    required this.req_id,
    required this.carid,
    required this.req_date,
    required this.req_time,
    required this.req_fullname,
    required this.req_lastname,
  });

  int req_id;
  Carid carid;
  String req_date;
  String req_time;
  String req_fullname;
  String req_lastname;

  factory ReqDBAPI.fromJson(Map<String, dynamic> json) => ReqDBAPI(
        req_id: json["req_id"],
        carid: Carid.fromJson(json["car_id"]),
        req_date: json["req_date"],
        req_time: json["req_time"],
        req_fullname: json["req_fullname"],
        req_lastname: json["req_lastname"],
      );
}

class Carid {
  Carid({
    required this.car_id,
    required this.car_chassis,
    required this.carStatus,
    required this.carWhere,
    required this.car_position,
    required this.fullname,
    required this.lastname,
    required this.date,
    required this.time,
    required this.car_line,
  });
  int car_id;
  String car_chassis;
  CarStatus carStatus;
  CarWhere carWhere;
  String car_position;
  String fullname;
  String lastname;
  String date;
  String time;
  String car_line;

  factory Carid.fromJson(Map<String, dynamic> json) => Carid(
        car_id: json["car_id"],
        car_chassis: json["car_chassis"],
        carWhere: CarWhere.fromJson(json["car_where"]),
        carStatus: CarStatus.fromJson(json["car_status"]),
        car_position: json["car_position"],
        fullname: json["fullname"],
        lastname: json["lastname"],
        date: json["date"],
        time: json["time"],
        car_line: json["car_line"],
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