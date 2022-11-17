// ignore_for_file: file_names

class User {
  // username, fullname, email, password, phone, address
  String? fullname;
  String? email;
  late String phone;
  late String address;

  User({this.fullname, this.email, this.phone = '', this.address = ''});
}

class SliderModel {
  String? image;

  SliderModel({this.image});
}

class CategoryModel {
  String? image;
  String? catgoryName;

  CategoryModel({this.image, this.catgoryName});
}

class GSRecommendedModel {
  int? id;
  String? offer;
  String? image;
  double? salePrice;
  double? price;
  String? title;
  String? quantity;
  String? description;
  int? qty;
  int? total;
  int? ranking;

  GSRecommendedModel(
      {this.id,
      this.offer,
      this.image,
      this.salePrice,
      this.price,
      this.title,
      this.quantity,
      this.description,
      this.qty,
      this.total,
      this.ranking});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'offer': offer,
      'image': image,
      'salePrice': salePrice,
      'price': price,
      'title': title,
      'quantity': quantity,
      'description': description,
      'qty': qty,
      'total': total,
      'ranking': ranking,
    };
  }

  factory GSRecommendedModel.fromJson(Map<String, dynamic> json) {
    return GSRecommendedModel(
      id: json['id'],
      offer: json['offer'],
      image: json['image'],
      salePrice: json['salePrice'],
      price: json['price'],
      title: json['title'],
      quantity: json['quantity'],
      description: json['description'],
      qty: json['qty'],
      total: json['total'],
      ranking: json['ranking'],
    );
  }
}

class GSMyOrderModel {
  String? title;
  String? date;
  int? orderStatus;
  String? image;
  String? address;
  String? cost;
  String? orderId;

  GSMyOrderModel(
      {this.title,
      this.date,
      this.orderStatus,
      this.image,
      this.address,
      this.cost,
      this.orderId});

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'date': date,
      'orderStatus': orderStatus,
      'image': image,
      'address': address,
      'cost': cost,
      'orderId': orderId,
    };
  }

  factory GSMyOrderModel.fromJson(Map<String, dynamic> json) {
    return GSMyOrderModel(
      title: json['title'],
      date: json['date'],
      orderStatus: json['orderStatus'],
      image: json['image'],
      address: json['address'],
      cost: json['cost'],
      orderId: json['orderId'],
    );
  }
}

class GSAddressModel {
  String? address;
  String? city;
  String? state;
  String? pinCode;

  GSAddressModel({this.address, this.city, this.state, this.pinCode});
}

class GSPromoModel {
  String? promoImage;
  String? offer;
  String? offerDate;

  GSPromoModel({this.promoImage, this.offer, this.offerDate});
}

class GSNotificationModel {
  String? title;
  String? subTitle;
  String? heading;

  GSNotificationModel({this.title, this.subTitle, this.heading});
}
