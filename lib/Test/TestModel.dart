/* // To parse this JSON data, do
//
//     final passengersData = passengersDataFromJson(jsonString);

import 'dart:convert';

PassengersData passengersDataFromJson(String str) => PassengersData.fromJson(json.decode(str));

String passengersDataToJson(PassengersData data) => json.encode(data.toJson());

class PassengersData {
    PassengersData({
        required this.currentPage,
        required this.data,
        required this.firstPageUrl,
        required this.from,
        required this.lastPage,
        required this.lastPageUrl,
        required this.links,
        this.nextPageUrl,
        required this.path,
        required this.perPage,
        this.prevPageUrl,
        required this.to,
        required this.total,
    });

    int currentPage;
    List<Passenger> data;
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

    factory PassengersData.fromJson(Map<String, dynamic> json) => PassengersData(
        currentPage: json["current_page"],
        data: List<Passenger>.from(json["data"].map((x) => Passenger.fromJson(x))),
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

    Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": List<dynamic>.from(links.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
    };
}

class Passenger {
    Passenger({
        required this.carId,
        required this.carChassis,
        required this.carStatus,
        required this.carWhere,
        required this.carPosition,
        required this.fullname,
        required this.lastname,
        required this.date,
        required this.time,
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

    factory Passenger.fromJson(Map<String, dynamic> json) => Passenger(
        carId: json["car_id"],
        carChassis: json["car_chassis"],
        carStatus: CarStatus.fromJson(json["car_status"]),
        carWhere: CarWhere.fromJson(json["car_where"]),
        carPosition: json["car_position"],
        fullname: json["fullname"],
        lastname: json["lastname"],
        date: DateTime.parse(json["date"]),
        time: json["time"],
    );

    Map<String, dynamic> toJson() => {
        "car_id": carId,
        "car_chassis": carChassis,
        "car_status": carStatus.toJson(),
        "car_where": carWhere.toJson(),
        "car_position": carPosition,
        "fullname": fullname,
        "lastname": lastname,
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "time": time,
    };
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

    Map<String, dynamic> toJson() => {
        "status_id": statusId,
        "car_status": carStatus,
    };
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

    Map<String, dynamic> toJson() => {
        "where_id": whereId,
        "car_where": carWhere,
    };
}

class Link {
    Link({
        required this.url,
        required this.label,
        required this.active,
    });

    String url;
    String label;
    bool active;

    factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"] == null ? null : json["url"],
        label: json["label"],
        active: json["active"],
    );

    Map<String, dynamic> toJson() => {
        "url": url == null ? null : url,
        "label": label,
        "active": active,
    };
}
 */
