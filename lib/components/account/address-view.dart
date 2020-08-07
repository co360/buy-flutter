import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:storeFlutter/blocs/account/address-bloc.dart';
import 'package:storeFlutter/components/app-button.dart';
import 'package:storeFlutter/components/app-loading-dialog.dart';
import 'package:storeFlutter/components/app-loading.dart';
import 'package:storeFlutter/models/identity/location.dart';
import 'package:storeFlutter/services/storage-service.dart';
import 'package:storeFlutter/util/app-theme.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:storeFlutter/util/enums-util.dart';

class AddressView extends StatefulWidget {
  final enumAddressViewType viewType;
  final int selectId;
  final Function(BuildContext, int) callBack;

  AddressView(this.viewType, this.selectId, this.callBack);
  @override
  _AddressViewState createState() => _AddressViewState();
}

class _AddressViewState extends State<AddressView> {
  final StorageService storageService = GetIt.I<StorageService>();
  bool hasDialog = false;
  @override
  void initState() {
    print("Initialize AddressView and State");

    GetIt.I<AddressBloc>()
        .add(GetAddressEvent(storageService.loginUser.companyId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressBloc, AddressState>(
        bloc: GetIt.I<AddressBloc>(),
        builder: (context, state) {
          print("[AddressView] current state $state");

          if (state is GetAddressInProgress) {
            return AppLoading();
          } else if (state is GetAddressSuccess) {
            print(state.addresses);
            if (state.addresses.length > 0) {
              return SingleChildScrollView(
                child: Column(
                    children: generateDynamicList(context, state.addresses)),
              );
            }
          }
          return SingleChildScrollView(
            child: emptyList(context),
          );
        });
  }

  List<Widget> generateDynamicList(
      BuildContext _context, List<Location> _addresses) {
    List<Widget> list = List();
    if (_addresses == null) return list;

    for (int i = 0; i < _addresses.length; i++) {
      if (_addresses[i] == null) continue;
      list.add(Container(
          margin: const EdgeInsets.only(top: 10),
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
                    width: MediaQuery.of(_context).size.width * 0.50,
                    child: Text(
                        _addresses[i].fullName == null
                            ? storageService.loginUser.firstName
                            : _addresses[i].fullName,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    width: MediaQuery.of(_context).size.width * 0.35,
                    child: Container(
                        alignment: Alignment.centerRight,
                        child: widget.viewType == enumAddressViewType.SELECT
                            ? Container(
                                margin: EdgeInsets.only(right: 10),
                                child: RaisedButton(
                                  color: _addresses[i].id == widget.selectId
                                      ? AppTheme.colorOrange
                                      : AppTheme.colorGray6,
                                  textColor: Colors.white,
                                  onPressed: () => widget.callBack(
                                      _context, _addresses[i].id),
                                  child: _addresses[i].defaultShipping
                                      ? Text("Default")
                                      : Text(FlutterI18n.translate(
                                          _context, "account.address.useThis")),
                                ),
                              )
                            : FlatButton(
                                textColor: AppTheme.colorLink,
                                onPressed: () =>
                                    widget.callBack(_context, _addresses[i].id),
                                child: Text(FlutterI18n.translate(
                                    _context, "account.edit")),
                                shape: CircleBorder(
                                  side: BorderSide(color: Colors.transparent),
                                ),
                              )),
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
              _addresses[i].defaultShipping &&
                      widget.viewType == enumAddressViewType.EDIT
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
              _addresses[i].defaultBilling &&
                      widget.viewType == enumAddressViewType.EDIT
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

  Widget emptyList(BuildContext _context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 40.0),
              child: Text(
                FlutterI18n.translate(_context, "account.noAddress"),
                textAlign: TextAlign.center,
              )),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(top: 40.0),
            child: SizedBox(
              width: 264,
              child: AppButton(
                FlutterI18n.translate(_context, "account.addAddressNow"),
                () => widget.callBack(_context, 0),
                size: AppButtonSize.small,
                noPadding: true,
              ),
            ),
          ),
        ]);
  }
}
