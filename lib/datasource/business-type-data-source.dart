import 'package:flutter/material.dart';
import 'package:storeFlutter/datasource/data-source.dart';
import 'package:storeFlutter/models/label-value.dart';

class BusinessTypeDataSource extends DataSource {
  List<LabelValue> datas = [
    LabelValue(label: 'Manufacturer', value: 'MANUFACTURER'),
    LabelValue(label: 'Marine Insurance', value: 'MARINE_INSURANCE'),
    LabelValue(label: 'Surveyor', value: 'SURVEYOR'),
    LabelValue(label: 'Packaging Provider', value: 'PACKAGING_PROVIDER'),
    LabelValue(
        label: 'Fumigation / Phytosanitary', value: 'FUMIGATION/PHYTOSANITARY'),
    LabelValue(label: 'Certifications', value: 'CERTIFICATIONS'),
    LabelValue(label: 'Port Services', value: 'PORT_SERVICES'),
    LabelValue(label: 'Cooperative', value: 'COORPERATIVE'),
    LabelValue(label: 'Cooperative Member', value: 'COORPETATIVE_MEMBER'),
    LabelValue(label: 'Trader', value: 'TRADER'),
    LabelValue(label: 'Distributor / Reseller', value: 'DISTRIBUTOR/RESELLER'),
    LabelValue(label: 'Trucking', value: 'TRUCKING'),
    LabelValue(label: 'Warehousing', value: 'WAREHOUSING'),
    LabelValue(label: 'Tank Operator', value: 'TANK_OPERATOR'),
    LabelValue(label: 'Vessel', value: 'VESSEL'),
    LabelValue(label: 'Air service', value: 'AIR_SERVICE'),
    LabelValue(
        label: 'Forwarder / Shipping Agent', value: 'FORWARDER/SHIPPING_AGENT'),
    LabelValue(label: 'Haulage', value: 'HAULAGE'),
    LabelValue(label: 'Pipeline', value: 'PIPELINE'),
    LabelValue(label: 'Barge', value: 'BARGE'),
    LabelValue(label: 'Waterborne', value: 'WATERBORNE'),
    LabelValue(label: 'Trade Finance', value: 'TRADE_FINANCE'),
    LabelValue(label: 'Land Insurance', value: 'LAND_INSURANCE'),
    LabelValue(label: 'Service Provider', value: 'SERVICE_PROVIDER'),
  ];

  @override
  Future<List<LabelValue>> prepareDataSource(BuildContext context,
      {dynamic param}) async {
    return datas;
  }

  @override
  String get translateKeyPrefix => "dataSource.businessType.";
}
