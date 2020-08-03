import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:storeFlutter/screens/account/manage-address.dart';
import 'package:storeFlutter/models/identity/location.dart';
import 'package:storeFlutter/services/storage-service.dart';
import 'package:storeFlutter/datasource/country-data-source.dart';
import 'package:storeFlutter/util/app-theme.dart';
import 'package:auto_size_text/auto_size_text.dart';

class AddressView extends StatelessWidget {
  final StorageService storageService = GetIt.I<StorageService>();
  final CountryDataSource countryDataSource = GetIt.I<CountryDataSource>();
  final List<Location> addresses;

  AddressView(this.addresses);

  @override
  Widget build(BuildContext context) {
    return Column(children: _generateDynamicList(context, addresses));
  }

  List<Widget> _generateDynamicList(
      BuildContext _context, List<Location> _addresses) {
    List<Widget> list = List();
    print("test");
    print(_addresses);
    if (_addresses == null) return list;

    for (int i = 0; i < _addresses.length; i++) {
      if (_addresses[i] == null) continue;
      list.add(Container(
          margin: const EdgeInsets.only(top: 20),
          padding: const EdgeInsets.only(bottom: 10),
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(_context).size.width * 0.15,
                    child: Container(
                      alignment: Alignment.center,
                      child: FaDuotoneIcon(
                        FontAwesomeIcons.duotoneMapMarkedAlt,
                        secondaryColor: AppTheme.colorPrimary,
                        primaryColor: AppTheme.colorPrimary,
                        size: 20,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(_context).size.width * 0.60,
                    child: Text(
                        _addresses[i].fullName == null
                            ? storageService.loginUser.firstName
                            : _addresses[i].fullName,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    width: MediaQuery.of(_context).size.width * 0.20,
                    child: Container(
                      alignment: Alignment.center,
                      child: FlatButton(
                        textColor: AppTheme.colorLink,
                        onPressed: () => {
                          Navigator.pushReplacement(
                            _context,
                            CupertinoPageRoute(
                              builder: (context) =>
                                  ManageAddressScreen(_addresses[i].id),
                            ),
                          )
                        },
                        child: Text(
                            FlutterI18n.translate(_context, "account.edit")),
                        shape: CircleBorder(
                            side: BorderSide(color: Colors.transparent)),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(_context).size.width * 0.15,
                  ),
                  SizedBox(
                    width: MediaQuery.of(_context).size.width * 0.60,
                    child: Text(
                        (_addresses[i].phoneNo == null
                            ? storageService.loginUser.contactNo
                            : _addresses[i].phoneNo),
                        style: TextStyle()),
                  ),
                  SizedBox(
                    width: MediaQuery.of(_context).size.width * 0.20,
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(_context).size.width * 0.15,
                  ),
                  SizedBox(
                    width: MediaQuery.of(_context).size.width * 0.80,
                    child: Text(
                        _addresses[i].address +
                            ", " +
                            _addresses[i].city +
                            ", " +
                            _addresses[i].state +
                            ", " +
                            _addresses[i].postcode +
                            ", " +
                            (_addresses[i].countryName == null
                                ? "Malaysia"
                                : _addresses[i].countryName),
                        style: TextStyle()),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(_context).size.width * 0.15,
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: 20,
                      maxHeight: 30,
                    ),
                    child: FlatButton(
                      onPressed: () => {},
                      color: _addresses[i].defaultShipping
                          ? AppTheme.colorPrimary
                          : AppTheme.colorSuccess,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80.0),
                      ),
                      child: AutoSizeText(
                          _addresses[i].locationType != null &&
                                  _addresses[i].locationType == "HOME"
                              ? FlutterI18n.translate(
                                  _context, "account.address.home")
                              : FlutterI18n.translate(
                                  _context, "account.address.office"),
                          minFontSize: 12,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              _addresses[i].defaultShipping
                  ? Row(
                      children: <Widget>[
                        SizedBox(
                          width: MediaQuery.of(_context).size.width * 0.15,
                          child: Container(
                            alignment: Alignment.center,
                            child: FaDuotoneIcon(
                              FontAwesomeIcons.duotoneCheck,
                              secondaryColor: AppTheme.colorOrange,
                              primaryColor: AppTheme.colorOrange,
                              size: 20,
                            ),
                          ),
                        ),
                        SizedBox(
                            width: MediaQuery.of(_context).size.width * 0.80,
                            child: Text(
                                FlutterI18n.translate(
                                    _context, "account.defaultShippingAddress"),
                                style: TextStyle(
                                  color: AppTheme.colorOrange,
                                  fontSize: 12,
                                ))),
                      ],
                    )
                  : Container(),
              _addresses[i].defaultBilling
                  ? Row(
                      children: <Widget>[
                        SizedBox(
                          width: MediaQuery.of(_context).size.width * 0.15,
                          child: Container(
                            alignment: Alignment.center,
                            child: FaDuotoneIcon(
                              FontAwesomeIcons.duotoneCheck,
                              secondaryColor: AppTheme.colorOrange,
                              primaryColor: AppTheme.colorOrange,
                              size: 20,
                            ),
                          ),
                        ),
                        SizedBox(
                            width: MediaQuery.of(_context).size.width * 0.80,
                            child: Text(
                                FlutterI18n.translate(
                                    _context, "account.defaultBillingAddress"),
                                style: TextStyle(
                                  color: AppTheme.colorOrange,
                                  fontSize: 12,
                                ))),
                      ],
                    )
                  : Container(),
            ],
          )));
    }
    return list;
  }
}
