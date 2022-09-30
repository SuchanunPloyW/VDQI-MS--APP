class Position{
  Position({
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
    late List<PositionAPI> data;
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

    factory Position.fromJson(Map<String, dynamic> json) => Position(
        currentPage: json["current_page"],
        data: List<PositionAPI>.from(json["data"].map((e) => PositionAPI.fromJson(e))),
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
class PositionAPI {
  PositionAPI({
      required this.position_id,
      required this.car_line,
      required this.car_position,
      required this.position_status,
      required this.carWhere,
  });
  int position_id;
  String car_line;
  String car_position;
  String position_status;
  CarWhere carWhere;

  factory PositionAPI.fromJson(Map<String, dynamic> json) => PositionAPI(
        position_id: json["position_id"],
        car_line: json["car_line"],
        car_position: json["car_position"],
        position_status: json["position_status"],
        carWhere: CarWhere.fromJson(json["car_where"]),
        
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
