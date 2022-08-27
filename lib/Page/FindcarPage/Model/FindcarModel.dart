class Car {
  int? currentPage;
  List<Data>? data;

  Car({this.currentPage, this.data});

  Car.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? carId;
  String? carChassis;
  CarStatus? carStatus;
  CarWhere? carWhere;
  String? carPosition;
  String? fullname;
  String? lastname;
  String? date;
  String? time;

  Data(
      {this.carId,
      this.carChassis,
      this.carStatus,
      this.carWhere,
      this.carPosition,
      this.fullname,
      this.lastname,
      this.date,
      this.time});

  Data.fromJson(Map<String, dynamic> json) {
    carId = json['car_id'];
    carChassis = json['car_chassis'];
    carStatus = json['car_status'] != null
        ? new CarStatus.fromJson(json['car_status'])
        : null;
    carWhere = json['car_where'] != null
        ? new CarWhere.fromJson(json['car_where'])
        : null;
    carPosition = json['car_position'];
    fullname = json['fullname'];
    lastname = json['lastname'];
    date = json['date'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['car_id'] = this.carId;
    data['car_chassis'] = this.carChassis;
    if (this.carStatus != null) {
      data['car_status'] = this.carStatus!.toJson();
    }
    if (this.carWhere != null) {
      data['car_where'] = this.carWhere!.toJson();
    }
    data['car_position'] = this.carPosition;
    data['fullname'] = this.fullname;
    data['lastname'] = this.lastname;
    data['date'] = this.date;
    data['time'] = this.time;
    return data;
  }
}

class CarStatus {
  int? statusId;
  String? carStatus;

  CarStatus({this.statusId, this.carStatus});

  CarStatus.fromJson(Map<String, dynamic> json) {
    statusId = json['status_id'];
    carStatus = json['car_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_id'] = this.statusId;
    data['car_status'] = this.carStatus;
    return data;
  }
}

class CarWhere {
  int? whereId;
  String? carWhere;

  CarWhere({this.whereId, this.carWhere});

  CarWhere.fromJson(Map<String, dynamic> json) {
    whereId = json['where_id'];
    carWhere = json['car_where'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['where_id'] = this.whereId;
    data['car_where'] = this.carWhere;
    return data;
  }
}
