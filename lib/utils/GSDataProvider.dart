// ignore_for_file: file_names

import 'dart:convert';
import 'package:nb_utils/nb_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:shop_order/main.dart';

// Source
import 'package:shop_order/model/GSModel.dart';
import 'package:shop_order/utils/GSConstants.dart';
import 'package:shop_order/utils/GSImages.dart';
import 'package:shop_order/utils/AppConstants.dart';

List<SliderModel> getSliderList() {
  List<SliderModel> list = [];
  int countSlider = imageSlider.length;
  for (int i = 0; i < countSlider; i++) {
    list.add(SliderModel(image: imageSlider[i]));
  }
  return list;
}

List<CategoryModel> getCategoryList() {
  List<CategoryModel> list = [];
  int countCategory = imageCategory.length;
  for (int i = 0; i < countCategory; i++) {
    String nameCate = imageCategory[i][0];
    String imageCate = imageCategory[i][1];
    list.add(CategoryModel(image: imageCate, catgoryName: nameCate));
  }
  return list;
}

Future getTotalMoney($user) async {
  var url = Uri.parse('$baseUrl/getTotalMoney.php');
  var response = await http.post(url, body: {'user': $user});
  var data = jsonDecode(response.body);
  return data;
}

Future getUserInfo(String username, String password) async {
  var url = Uri.parse('$baseUrl/get_user_info');
  List<User> list = [];
  var response =
      await http.post(url, body: {'username': username, 'password': password});
  if (response.statusCode == 200) {
    var data = json.decode(utf8.decode(response.bodyBytes));
    if (data['status'] == 'success') {
      var value = data['data'];
      String fullname = value['fullname'];
      String email = value['email'];
      String phone = value['phone'];
      String address = value['address'];

      list.add(User(
          fullname: fullname, email: email, phone: phone, address: address));
    }
    final prefs = await SharedPreferences.getInstance();
    String encode = jsonEncode(list[0]);
    prefs.setString('user_info', encode);
    return list.toList();
  }
}

Future getTopDiscount(int amount) async {
  List<GSRecommendedModel> list = [];

  var uri = Uri.parse('$baseUrl/top_discount/$amount');
  var response = await http.get(uri);
  if (response.statusCode == 200) {
    var data = json.decode(utf8.decode(response.bodyBytes));
    if (data['status'] == 'success') {
      var listData = data['data'];
      int countListData = listData.length;
      for (int i = 0; i < countListData; i++) {
        var value = listData[i];
        int id = int.parse(value['id_product']);
        String name = value['name'];
        String description = value['description'];
        double price = double.parse(value['price']);
        int ranking = int.parse(value['ranking']);
        String image = imageSource + value['image'];
        double discount = double.parse(value['discount']);
        int quantity = int.parse(value['quantity']);
        // int id_category = value['id_category'];

        double salePrice = price - (price * discount / 100);

        list.add(GSRecommendedModel(
          id: id,
          offer: discount.round().toString(),
          image: image,
          price: price,
          salePrice: salePrice,
          title: name,
          description: description,
          quantity: 'Còn $quantity sản phẩm',
          qty: quantity,
          total: 0,
          ranking: ranking,
        ));
      }
    }
  }
  final prefs = await SharedPreferences.getInstance();
  prefs.setString('top_discount', jsonEncode(list));
  return list;
}

Future getTopRanking(int amount) async {
  List<GSRecommendedModel> list = [];
  var uri = Uri.parse('$baseUrl/top_ranking/$amount');
  var response = await http.get(uri);
  var data = json.decode(utf8.decode(response.bodyBytes));
  if (data['status'] == 'success') {
    var listData = data['data'];
    int countListData = listData.length;
    for (int i = 0; i < countListData; i++) {
      var value = listData[i];
      int id = int.parse(value['id_product']);
      String name = value['name'];
      String description = value['description'];
      double price = double.parse(value['price']);
      int ranking = int.parse(value['ranking']);
      String image = imageSource + value['image'];
      double discount = double.parse(value['discount']);
      int quantity = int.parse(value['quantity']);
      // int id_category = value['id_category'];

      double salePrice = price - (price * discount / 100);

      list.add(GSRecommendedModel(
        id: id,
        offer: discount.round().toString(),
        image: image,
        price: price,
        salePrice: salePrice,
        title: name,
        description: description,
        quantity: 'Còn $quantity sản phẩm',
        qty: quantity,
        total: 0,
        ranking: ranking,
      ));
    }
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('top_ranking', jsonEncode(list));
    return list;
  } else {}
}

Future getCategoryProduct(String category) async {
  var uri = Uri.parse('$baseUrl/category_product/$category');
  var response = await http.get(uri);
  var data = json.decode(utf8.decode(response.bodyBytes));
  if (data['status'] == 'success') {
    var listData = data['data'];
    int countListData = listData.length;
    List<GSRecommendedModel> list = [];
    for (int i = 0; i < countListData; i++) {
      var value = listData[i];
      int id = int.parse(value['id_product']);
      String name = value['name'];
      String description = value['description'];
      double price = double.parse(value['price']);
      int ranking = int.parse(value['ranking']);
      String image = imageSource + value['image'];
      double discount = double.parse(value['discount']);
      int quantity = int.parse(value['quantity']);
      // int id_category = value['id_category'];

      double salePrice = price - (price * discount / 100);

      list.add(
        GSRecommendedModel(
          id: id,
          image: image,
          price: price,
          salePrice: salePrice,
          description: description,
          title: name,
          quantity: 'Còn $quantity sản phẩm',
          ranking: ranking,
        ),
      );
    }
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('${category}_product', jsonEncode(list));
    return list;
  } else {}
}

Future getUserCart(String username, String password) async {
  var uri = Uri.parse('$baseUrl/get_cart_product');
  var response = await http.post(uri, body: {
    'username': username,
    'password': password,
  });
  var data = json.decode(utf8.decode(response.bodyBytes));
  if (data['status'] == 'success') {
    var listData = data['data'];
    int countListData = listData.length;
    List<GSRecommendedModel> list = [];
    for (int i = 0; i < countListData; i++) {
      var value = listData[i];
      int id = int.parse(value['id_product']);
      String name = value['name'];
      String description = value['description'];
      double price = double.parse(value['price']);
      int ranking = int.parse(value['ranking']);
      String image = imageSource + value['image'];
      double discount = double.parse(value['discount']);
      int quantity = int.parse(value['quantity']);
      int amount = int.parse(value['amount']);
      // int id_category = value['id_category'];

      double salePrice = price - (price * discount / 100);

      list.add(
        GSRecommendedModel(
          id: id,
          image: image,
          price: price,
          salePrice: salePrice,
          description: description,
          title: name,
          qty: amount,
          quantity: 'Còn $quantity sản phẩm',
          ranking: ranking,
        ),
      );
    }
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('user_cart', jsonEncode(list));
    return list;
  } else {}
}

Future getOrderProduct(String username, String password, String idOrder) async {
  var uri = Uri.parse('$baseUrl/get_order_product');
  var response = await http.post(uri, body: {
    'username': username,
    'password': password,
    'id_order': idOrder,
  });
  var data = json.decode(utf8.decode(response.bodyBytes));
  if (data['status'] == 'success') {
    var listData = data['data'];
    int countListData = listData.length;
    List<GSRecommendedModel> list = [];
    for (int i = 0; i < countListData; i++) {
      var value = listData[i];
      int id = int.parse(value['id_product']);
      String name = value['name'];
      String description = value['description'];
      double price = double.parse(value['price']);
      int ranking = int.parse(value['ranking']);
      String image = imageSource + value['image'];
      double discount = double.parse(value['discount']);
      int quantity = int.parse(value['quantity']);
      int amount = int.parse(value['amount']);
      // int id_category = value['id_category'];

      double salePrice = price - (price * discount / 100);

      list.add(
        GSRecommendedModel(
          id: id,
          image: image,
          price: price,
          salePrice: salePrice,
          description: description,
          title: name,
          qty: amount,
          quantity: 'Còn $quantity sản phẩm',
          ranking: ranking,
        ),
      );
    }
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('product_order_$idOrder', jsonEncode(list));
    return list;
  } else {}
}

Future getOrderStatus(String username, String password, String status) async {
  var uri = Uri.parse('$baseUrl/get_order_status');
  var response = await http.post(uri, body: {
    'username': username,
    'password': password,
    'status': status,
  });
  if (response.statusCode == 200) {
    var data = json.decode(utf8.decode(response.bodyBytes));
    List<GSMyOrderModel> list = [];
    if (data['status'] == 'success' && data['data'][0] != false) {
      var listData = data['data'];
      int countListData = listData.length;
      for (int i = 0; i < countListData; i++) {
        var value = listData[i];

        String idOrder = value['id_order'].toString();
        String address = value['address_customer'].toString();
        String totalMoney = value['total_money'].toString();
        String date = value['order_date'].toString();
        String image = value['image'].toString();
        String status = value['status'].toString();

        int orderStatus = 0;
        if (status == 'pending') {
          orderStatus = pedingOrder;
        } else if (status == 'shipping') {
          orderStatus = shippedOrder;
        } else if (status == 'delivered') {
          orderStatus = deliveredOrder;
        } else if (status == 'canceled') {
          orderStatus = cancelledOrder;
        }

        list.add(GSMyOrderModel(
            title: '#$idOrder',
            date: date,
            orderStatus: orderStatus,
            image: imageSource + image,
            cost: totalMoney,
            address: address,
            orderId: idOrder));
      }
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('order_$status', jsonEncode(list));
    }
    return list;
  }
}

// List<GSAddressModel> getAddressList() {
//   List<GSAddressModel> list = [];
//   list.add(GSAddressModel(
//       address: "1980  Cicero Street",
//       city: "Malden",
//       state: "MO",
//       pinCode: "63863"));
//   list.add(GSAddressModel(
//       address: "122 Bessida St, Bloomfield, NJ, 07003",
//       city: "Cicero",
//       state: "IL",
//       pinCode: "60650"));
//   return list;
// }

// List<GSPromoModel> getPromoList() {
//   List<GSPromoModel> list = [];
//   list.add(GSPromoModel(
//       promoImage: gs_slider_image1,
//       offer: "Fruits 30% Off Promos",
//       offerDate: "Available until 20 Feb 2020"));
//   list.add(GSPromoModel(
//       promoImage: gs_slider_image2,
//       offer: "Grocery 30% Off Promos",
//       offerDate: "Available until 25 Feb 2020"));
//   return list;
// }

List<GSNotificationModel> getNotificationList() {
  List<GSNotificationModel> list = [];
  list.add(GSNotificationModel(
      title: "You got 10% off from your last order",
      subTitle: "The gift can you can use in next order",
      heading: "Promo"));
  list.add(GSNotificationModel(
      title: "Waiting for payment",
      subTitle: "The gift can you can use in next order",
      heading: "Transaction"));
  list.add(GSNotificationModel(
      title: "Rate your order experience",
      subTitle: "The gift can you can use in next order",
      heading: "Info"));
  return list;
}
