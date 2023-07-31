import 'package:convertouch/model/constant.dart';
import 'package:convertouch/model/entity/item_model.dart';
import 'package:convertouch/model/util/menu_page_util.dart';
import 'package:flutter/material.dart';

class ConvertouchMenuGridItem extends StatefulWidget {
  const ConvertouchMenuGridItem(
    this.item, {
    super.key,
    required this.logo,
    this.onTap,
    this.onLongPress,
    this.isMarkedToSelect = false,
    this.isSelected = false,
    this.removalModeEnabled = false,
    this.markOnTap = false,
    this.borderColor = const Color(0xFF366C9F),
    this.borderColorMarked = const Color(0xFF366C9F),
    this.borderColorSelected = const Color(0xFF366C9F),
    this.backgroundColor = const Color(0xFFF2F5FF),
    this.backgroundColorSelected = const Color(0xFF8BD5FD),
    this.backgroundColorMarked = const Color(0xFFDEE6FF),
    this.contentColor = const Color(0xFF366C9F),
    this.contentColorMarked = const Color(0xFF366C9F),
    this.contentColorSelected = const Color(0xFF366C9F),
  });

  final ItemModelWithIdName item;
  final Widget logo;
  final void Function()? onTap;
  final void Function()? onLongPress;
  final bool isMarkedToSelect;
  final bool isSelected;
  final bool removalModeEnabled;
  final bool markOnTap;
  final Color borderColor;
  final Color borderColorMarked;
  final Color borderColorSelected;
  final Color backgroundColor;
  final Color backgroundColorMarked;
  final Color backgroundColorSelected;
  final Color contentColor;
  final Color contentColorMarked;
  final Color contentColorSelected;

  @override
  State createState() => _ConvertouchMenuGridItemState();
}

class _ConvertouchMenuGridItemState extends State<ConvertouchMenuGridItem> {
  late bool _isMarkedToSelect;
  bool _isMarkedToRemove = false;

  late Color _contentColor;
  late Color _borderColor;
  late Color _backgroundColor;

  @override
  void initState() {
    super.initState();
    _isMarkedToSelect = widget.isMarkedToSelect;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isSelected) {
      _borderColor = widget.borderColorSelected;
      _backgroundColor = widget.backgroundColorSelected;
      _contentColor = widget.contentColorSelected;
    } else if (_isMarkedToSelect) {
      _borderColor = widget.borderColorMarked;
      _backgroundColor = widget.backgroundColorMarked;
      _contentColor = widget.contentColorMarked;
    } else {
      _borderColor = widget.borderColor;
      _backgroundColor = widget.backgroundColor;
      _contentColor = widget.contentColor;
    }

    return GestureDetector(
      onTap: () {
        if (widget.removalModeEnabled) {
          setState(() {
            _isMarkedToRemove = !_isMarkedToRemove;
          });
        } else {
          if (!widget.isSelected) {
            if (widget.markOnTap) {
              setState(() {
                _isMarkedToSelect = !_isMarkedToSelect;
              });
            }
          }
        }

        bool notMarkedAndCanBeSelected =
            !widget.markOnTap && !widget.isMarkedToSelect;
        if (widget.markOnTap || notMarkedAndCanBeSelected) {
          widget.onTap?.call();
        }
      },
      onLongPress: widget.onLongPress,
      child: Container(
        decoration: BoxDecoration(
          color: _backgroundColor,
          borderRadius: BorderRadius.circular(7),
          border: Border.all(
            color: _borderColor,
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Flexible(
              flex: 5,
              child: DefaultTextStyle(
                style: TextStyle(
                  color: _contentColor,
                  fontWeight: FontWeight.w700,
                  fontFamily: quicksandFontFamily,
                  fontSize: 16,
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                  child: widget.logo,
                ),
              ),
            ),
            Flexible(
              flex: 3,
              child: Container(
                padding: const EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                child: Text(
                  widget.item.name,
                  style: TextStyle(
                    fontFamily: quicksandFontFamily,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: _contentColor,
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: getGridItemNameLinesNumToWrap(widget.item.name),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
