import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:shop_hop_prokit/models/ShAddress.dart';
import 'package:shop_hop_prokit/utils/ShColors.dart';
import 'package:shop_hop_prokit/utils/ShConstant.dart';
import 'package:shop_hop_prokit/utils/ShStrings.dart';
import 'package:shop_hop_prokit/utils/ShWidget.dart';

import '../main.dart';

// ignore: must_be_immutable
class ShAddNewAddress extends StatefulWidget {
  static String tag = '/AddNewAddress';
  ShAddressModel? addressModel;

  ShAddNewAddress({this.addressModel});

  @override
  ShAddNewAddressState createState() => ShAddNewAddressState();
}

class ShAddNewAddressState extends State<ShAddNewAddress> {
  var primaryColor;
  var firstNameCont = TextEditingController();
  var lastNameCont = TextEditingController();
  var pinCodeCont = TextEditingController();
  var cityCont = TextEditingController();
  var stateCont = TextEditingController();
  var addressCont = TextEditingController();
  var phoneNumberCont = TextEditingController();
  var countryCont = TextEditingController();

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    if (widget.addressModel != null) {
      pinCodeCont.text = widget.addressModel!.pinCode!;
      addressCont.text = widget.addressModel!.address!;
      cityCont.text = widget.addressModel!.city!;
      stateCont.text = widget.addressModel!.state!;
      countryCont.text = widget.addressModel!.country!;
      firstNameCont.text = widget.addressModel!.first_name!;
      lastNameCont.text = widget.addressModel!.last_name!;
      phoneNumberCont.text = widget.addressModel!.phone_number!;
    }
  }

  @override
  Widget build(BuildContext context) {
    void onSaveClicked() async {
      Navigator.pop(context, true);
    }
    // TODO Without NullSafety Geo coder
/*    getLocation() async {
      Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((position) {
        var coordinates = Coordinates(position.latitude, position.longitude);
        Geocoder.local.findAddressesFromCoordinates(coordinates).then((addresses) {
          var first = addresses.first;
          print("${addresses} : ${first.addressLine}");
          setState(() {
            pinCodeCont.text = first.postalCode;
            addressCont.text = first.addressLine;
            cityCont.text = first.locality;
            stateCont.text = first.adminArea;
            countryCont.text = first.countryName;
          });
        }).catchError((error) {
          print(error);
        });
      }).catchError((error) {
        print(error);
      });
    }*/

    final useCurrentLocation = Container(
      alignment: Alignment.center,
      child: MaterialButton(
        color: appStore.isDarkModeOn ? cardDarkColor : sh_light_gray,
        elevation: 0,
        padding: EdgeInsets.only(top: spacing_middle, bottom: spacing_middle),
        onPressed: () => {
          // TODO Without NullSafety Geo coder
          //getLocation()
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.my_location, color: primaryColor, size: 16),
            8.width,
            Text('Use Current Location', style: primaryTextStyle()),
          ],
        ),
      ),
    );

    final firstName = TextFormField(
      controller: firstNameCont,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      textCapitalization: TextCapitalization.words,
      style: primaryTextStyle(),
      autofocus: false,
      onFieldSubmitted: (term) {
        FocusScope.of(context).nextFocus();
      },
      decoration: formFieldDecoration(sh_hint_first_name),
    );

    final lastName = TextFormField(
      controller: lastNameCont,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      textCapitalization: TextCapitalization.words,
      style: primaryTextStyle(),
      autofocus: false,
      onFieldSubmitted: (term) {
        FocusScope.of(context).nextFocus();
      },
      decoration: formFieldDecoration(sh_hint_last_name),
    );

    final pinCode = TextFormField(
      controller: pinCodeCont,
      keyboardType: TextInputType.number,
      maxLength: 6,
      autofocus: false,
      onFieldSubmitted: (term) {
        FocusScope.of(context).nextFocus();
      },
      textInputAction: TextInputAction.next,
      style: primaryTextStyle(),
      decoration: formFieldDecoration(sh_hint_pin_code),
    );

    final city = TextFormField(
      controller: cityCont,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.words,
      style: primaryTextStyle(),
      onFieldSubmitted: (term) {
        FocusScope.of(context).nextFocus();
      },
      textInputAction: TextInputAction.next,
      autofocus: false,
      decoration: formFieldDecoration(sh_hint_city),
    );

    final state = TextFormField(
      onFieldSubmitted: (term) {
        FocusScope.of(context).nextFocus();
      },
      controller: stateCont,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.words,
      style: primaryTextStyle(),
      autofocus: false,
      textInputAction: TextInputAction.next,
      decoration: formFieldDecoration(sh_hint_state),
    );

    final country = TextFormField(
      onFieldSubmitted: (term) {
        FocusScope.of(context).nextFocus();
      },
      controller: countryCont,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.words,
      style: primaryTextStyle(),
      autofocus: false,
      textInputAction: TextInputAction.next,
      decoration: formFieldDecoration("Country"),
    );

    final address = TextFormField(
      controller: addressCont,
      keyboardType: TextInputType.multiline,
      maxLines: 4,
      onFieldSubmitted: (term) {
        FocusScope.of(context).nextFocus();
      },
      autofocus: false,
      style: primaryTextStyle(),
      decoration: formFieldDecoration(sh_hint_address),
    );

    final phoneNumber = TextFormField(
      controller: phoneNumberCont,
      keyboardType: TextInputType.phone,
      textInputAction: TextInputAction.done,
      maxLength: 10,
      autofocus: false,
      decoration: formFieldDecoration(sh_hint_contact),
    );

    final saveButton = MaterialButton(
      height: 50,
      minWidth: double.infinity,
      shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(40.0)),
      onPressed: () {
        if (firstNameCont.text.isEmpty) {
          toasty(context, "First name required");
        } else if (lastNameCont.text.isEmpty) {
          toasty(context, "Last name required");
        } else if (phoneNumberCont.text.isEmpty) {
          toasty(context, "Phone Number required");
        } else if (addressCont.text.isEmpty) {
          toasty(context, "Address required");
        } else if (cityCont.text.isEmpty) {
          toasty(context, "City name required");
        } else if (stateCont.text.isEmpty) {
          toasty(context, "State name required");
        } else if (countryCont.text.isEmpty) {
          toasty(context, "Country name required");
        } else if (pinCodeCont.text.isEmpty) {
          toasty(context, "Pincode required");
        } else {
          onSaveClicked();
        }
      },
      color: sh_colorPrimary,
      child: text(sh_lbl_save_address, fontFamily: fontMedium, fontSize: textSizeLargeMedium, textColor: sh_white),
    );

    final body = Wrap(runSpacing: spacing_standard_new, children: <Widget>[
      useCurrentLocation,
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(child: firstName),
          SizedBox(
            width: spacing_standard_new,
          ),
          Expanded(child: lastName),
        ],
      ),
      phoneNumber,
      address,
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(child: city),
          SizedBox(
            width: spacing_standard_new,
          ),
          Expanded(child: state),
        ],
      ),
      Row(
        children: <Widget>[
          Expanded(child: country),
          SizedBox(
            width: spacing_standard_new,
          ),
          Expanded(child: pinCode),
        ],
      ),
      Padding(
        padding: const EdgeInsets.only(top: 30.0, bottom: 30.0),
        child: saveButton,
      ),
    ]);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.addressModel == null ? sh_lbl_add_new_address : sh_lbl_edit_address, style: boldTextStyle()),
        iconTheme: IconThemeData(color: appStore.isDarkModeOn ? white : sh_textColorPrimary),
        actionsIconTheme: IconThemeData(color: appStore.isDarkModeOn ? white : sh_colorPrimary),
        actions: [
          cartIcon(context, 3),
        ],
      ),
      body: Container(width: double.infinity, child: SingleChildScrollView(child: body), margin: EdgeInsets.all(16)),
    );
  }
}
