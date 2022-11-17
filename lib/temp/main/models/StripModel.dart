// class StripePayModel {
//   String? object;
//   int? amount;
//   int? amount_capturable;
//   int? amount_received;
//   String? application;
//   String? application_fee_amount;
//   String? canceled_at;
//   String? cancellation_reason;
//   String? capture_method;
//   Charges? charges;
//   String? client_secret;
//   String? confirmation_method;
//   int? created;
//   String? currency;
//   String? customer;
//   String? description;
//   String? id;
//   String? invoice;
//   String? last_payment_error;
//   bool? livemode;
//   String? next_action;
//   String? on_behalf_of;
//   String? payment_method;
//   PaymentMethodOptions? payment_method_options;
//   List<String>? payment_method_types;
//   String? receipt_email;
//   String? review;
//   String? setup_future_usage;
//   String? shipping;
//   String? source;
//   String? statement_descriptor;
//   String? statement_descriptor_suffix;
//   String? status;
//   String? transfer_data;
//   String? transfer_group;

//   StripePayModel({this.object, this.amount, this.amount_capturable, this.amount_received, this.application, this.application_fee_amount, this.canceled_at, this.cancellation_reason, this.capture_method, this.charges, this.client_secret, this.confirmation_method, this.created, this.currency, this.customer, this.description, this.id, this.invoice, this.last_payment_error, this.livemode, this.next_action, this.on_behalf_of, this.payment_method, this.payment_method_options, this.payment_method_types, this.receipt_email, this.review, this.setup_future_usage, this.shipping, this.source, this.statement_descriptor, this.statement_descriptor_suffix, this.status, this.transfer_data, this.transfer_group});

//   factory StripePayModel.fromJson(Map<String, dynamic> json) {
//     return StripePayModel(
//       object: json['object'],
//       amount: json['amount'],
//       amount_capturable: json['amount_capturable'],
//       amount_received: json['amount_received'],
//       application: json['application'],
//       application_fee_amount: json['application_fee_amount'],
//       canceled_at: json['canceled_at'],
//       cancellation_reason: json['cancellation_reason'],
//       capture_method: json['capture_method'],
//       charges: json['charges'] != null ? Charges.fromJson(json['charges']) : null,
//       client_secret: json['client_secret'],
//       confirmation_method: json['confirmation_method'],
//       created: json['created'],
//       currency: json['currency'],
//       customer: json['customer'],
//       description: json['description'],
//       id: json['id'],
//       invoice: json['invoice'],
//       last_payment_error: json['last_payment_error'],
//       livemode: json['livemode'],
//       next_action: json['next_action'],
//       on_behalf_of: json['on_behalf_of'],
//       payment_method: json['payment_method'],
//       payment_method_options: json['payment_method_options'] != null ? PaymentMethodOptions.fromJson(json['payment_method_options']) : null,
//       payment_method_types: json['payment_method_types'] != null ? new List<String>.from(json['payment_method_types']) : null,
//       receipt_email: json['receipt_email'],
//       review: json['review'],
//       setup_future_usage: json['setup_future_usage'],
//       shipping: json['shipping'],
//       source: json['source'],
//       statement_descriptor: json['statement_descriptor'],
//       statement_descriptor_suffix: json['statement_descriptor_suffix'],
//       status: json['status'],
//       transfer_data: json['transfer_data'],
//       transfer_group: json['transfer_group'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['`object`'] = this.object;
//     data['amount'] = this.amount;
//     data['amount_capturable'] = this.amount_capturable;
//     data['amount_received'] = this.amount_received;
//     data['application'] = this.application;
//     data['application_fee_amount'] = this.application_fee_amount;
//     data['canceled_at'] = this.canceled_at;
//     data['cancellation_reason'] = this.cancellation_reason;
//     data['capture_method'] = this.capture_method;
//     data['client_secret'] = this.client_secret;
//     data['confirmation_method'] = this.confirmation_method;
//     data['created'] = this.created;
//     data['currency'] = this.currency;
//     data['customer'] = this.customer;
//     data['description'] = this.description;
//     data['id'] = this.id;
//     data['invoice'] = this.invoice;
//     data['last_payment_error'] = this.last_payment_error;
//     data['livemode'] = this.livemode;
//     data['next_action'] = this.next_action;
//     data['on_behalf_of'] = this.on_behalf_of;
//     data['payment_method'] = this.payment_method;
//     data['receipt_email'] = this.receipt_email;
//     data['review'] = this.review;
//     data['setup_future_usage'] = this.setup_future_usage;
//     data['shipping'] = this.shipping;
//     data['source'] = this.source;
//     data['statement_descriptor'] = this.statement_descriptor;
//     data['statement_descriptor_suffix'] = this.statement_descriptor_suffix;
//     data['status'] = this.status;
//     data['transfer_data'] = this.transfer_data;
//     data['transfer_group'] = this.transfer_group;
//     if (this.charges != null) {
//       data['charges'] = this.charges!.toJson();
//     }
//     if (this.payment_method_options != null) {
//       data['payment_method_options'] = this.payment_method_options!.toJson();
//     }
//     if (this.payment_method_types != null) {
//       data['payment_method_types'] = this.payment_method_types;
//     }
//     return data;
//   }
// }

// class PaymentMethodOptions {
//   Card? card;

//   PaymentMethodOptions({this.card});

//   factory PaymentMethodOptions.fromJson(Map<String, dynamic> json) {
//     return PaymentMethodOptions(
//       card: json['card'] != null ? Card.fromJson(json['card']) : null,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.card != null) {
//       data['card'] = this.card!.toJson();
//     }
//     return data;
//   }
// }

// class Card {
//   String? installments;
//   String? network;
//   String? request_three_d_secure;

//   Card({this.installments, this.network, this.request_three_d_secure});

//   factory Card.fromJson(Map<String, dynamic> json) {
//     return Card(
//       installments: json['installments'],
//       network: json['network'],
//       request_three_d_secure: json['request_three_d_secure'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['installments'] = this.installments;
//     data['network'] = this.network;
//     data['request_three_d_secure'] = this.request_three_d_secure;
//     return data;
//   }
// }

// class Charges {
//   String? object;
//   bool? has_more;
//   int? total_count;
//   String? url;

//   Charges({this.object, this.has_more, this.total_count, this.url});

//   factory Charges.fromJson(Map<String, dynamic> json) {
//     return Charges(
//       object: json['object'],
//       has_more: json['has_more'],
//       total_count: json['total_count'],
//       url: json['url'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['`object`'] = this.object;
//     data['has_more'] = this.has_more;
//     data['total_count'] = this.total_count;
//     data['url'] = this.url;
//     return data;
//   }
// }