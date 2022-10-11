class Req {
  Req({
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
  late List<ReqAPI> data;
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

  factory Req.fromJson(Map<String, dynamic> json) => Req(
        currentPage: json["current_page"],
        data: List<ReqAPI>.from(json["data"].map((e) => ReqAPI.fromJson(e))),
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

class ReqAPI {
  ReqAPI(
      {required this.reqId,
      required this.carChassis,
      required this.fullname,
      required this.lastname,
      required this.reqDate,
      required this.reqTime,
      required this.carPosition,
      required this.carWhere,
      required this.carStatus,
      required this.carStation,
      required this.carLine
      });
  int reqId;
  String carChassis;
  String fullname;
  String lastname;
  String reqDate;
  String reqTime;
  String carPosition;
  String carLine;
  CarWhere carWhere;
  CarStatus carStatus;
  CarStation carStation;

  factory ReqAPI.fromJson(Map<String, dynamic> json) => ReqAPI(
        reqId: json["req_id"],
        carChassis: json["car_chassis"],
        carStatus: CarStatus.fromJson(json["car_status"]),
        carWhere: CarWhere.fromJson(json["car_where"]),
        carStation: CarStation.fromJson(json["car_station"]),
        carPosition: json["car_position"],
        fullname: json["fullname"],
        lastname: json["lastname"],
        reqDate: json["req_date"],
        reqTime: json["req_time"],
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

class CarStation {
  CarStation({
    required this.stationId,
    required this.carStation,
  });

  int stationId;
  String carStation;

  factory CarStation.fromJson(Map<String, dynamic> json) => CarStation(
        stationId: json["station_id"],
        carStation: json["car_station"],
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