import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:storeFlutter/util/app-theme.dart';

class QuantityInput extends StatefulWidget {
  final int quantity;
  final double min;
  final double max;
  final int step;
  final ValueChanged<int> onChanged;
  final bool enabled;

  double minValue;
  double maxValue;

  QuantityInput({
    Key key,
    this.quantity = 1,
    this.min = 1,
    this.max = 9999,
    this.step = 1,
    this.enabled = true,
    this.onChanged,
  }) : super(key: key) {
    if (this.min != null)
      this.minValue = this.min;
    else
      this.minValue = 1;
    if (this.max != null)
      this.maxValue = this.max;
    else
      this.maxValue = 9999;
  }

  @override
  _QuantityInputState createState() => _QuantityInputState();
}

class _QuantityInputState extends State<QuantityInput> {
  double _widgetHeight = 30;
  double _btnWidth = 35;
  int _quantity;

  bool get minusBtnDisabled =>
      _quantity <= widget.minValue ||
      _quantity - widget.step < widget.minValue ||
      !widget.enabled;

  bool get addBtnDisabled =>
      _quantity >= widget.maxValue ||
      _quantity + widget.step > widget.maxValue ||
      !widget.enabled;

  @override
  void initState() {
    super.initState();
    _quantity = widget.quantity;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5)),
        border: Border.all(color: AppTheme.colorGray2, width: 1),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: _widgetHeight, maxWidth: 120),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            minusBtn(),
            Center(child: Text(_quantity.toString())),
            plusBtn(),
          ],
        ),
      ),
    );
  }

  GestureDetector minusBtn() {
    bool disabled = minusBtnDisabled;
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: disabled
          ? null
          : () {
              int newQty = _quantity - widget.step;
              setState(() {
                _quantity = newQty;
              });
              if (widget.onChanged != null) widget.onChanged(newQty);
            },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            width: _btnWidth,
            decoration: BoxDecoration(
              color: disabled ? AppTheme.colorGray2 : Colors.white,
              borderRadius: BorderRadius.horizontal(
                left: Radius.circular(3),
              ),
            ),
            child: Center(
              child: FaIcon(
                FontAwesomeIcons.lightMinus,
                color: disabled ? AppTheme.colorGray5 : Colors.black,
                size: 12,
              ),
            ),
          ),
          SizedBox(
            height: _widgetHeight,
            child: VerticalDivider(
              width: 1,
              thickness: 1,
              color: AppTheme.colorGray2,
            ),
          ),
        ],
      ),
    );
  }

  GestureDetector plusBtn() {
    bool disabled = addBtnDisabled;
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: disabled
          ? null
          : () {
              int newQty = _quantity + widget.step;
              setState(() {
                _quantity = newQty;
              });
              if (widget.onChanged != null) widget.onChanged(newQty);
            },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: _widgetHeight,
            child: VerticalDivider(
              width: 1,
              thickness: 1,
              color: AppTheme.colorGray2,
            ),
          ),
          Container(
            width: _btnWidth,
            decoration: BoxDecoration(
              color: disabled ? AppTheme.colorGray2 : Colors.white,
              borderRadius: BorderRadius.horizontal(
                right: Radius.circular(3),
              ),
            ),
            child: Center(
              child: FaIcon(
                FontAwesomeIcons.lightPlus,
                color: disabled ? AppTheme.colorGray5 : Colors.black,
                size: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
