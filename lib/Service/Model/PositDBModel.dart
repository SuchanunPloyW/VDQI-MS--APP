class PositDB{
  PositDB({
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
  late List<PositDBAPI> data;
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

  factory PositDB.fromJson(Map<String, dynamic> json) => PositDB(
        currentPage: json["current_page"],
        data: List<PositDBAPI>.from(json["data"].map((e) => PositDBAPI.fromJson(e))),
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
class PositDBAPI{
  PositDBAPI({
    required this.posit_id,
    required this.line,
    required this.posit,
    required this.sort,
    required this.carWhere,
    required this.status,
  });
   int posit_id;
   String line;
   int posit;
   int sort;
   CarWhere carWhere;
   int status;

   factory PositDBAPI.fromJson(Map<String, dynamic> json) => PositDBAPI(
        posit_id: json["posit_id"],
        line: json["line"],
        posit: json["posit"],
        sort: json["sort"],
        carWhere: CarWhere.fromJson(json["car_where"]),
        status: json["status"],
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
