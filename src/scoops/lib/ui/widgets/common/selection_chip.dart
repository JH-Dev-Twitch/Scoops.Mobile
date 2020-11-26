import 'package:flutter/material.dart';
import 'package:scoops/ui/models/Selection.dart';

class SelectionChip extends StatelessWidget {
  SelectionChip(
    this._item,
    this.tapped, {
    this.selectedColor,
    this.backgroundColor,
    this.textColor = Colors.black,
    this.selectedTextColor = Colors.white,
    this.selectedIcon = Icons.check,
    this.selectedIconColor = Colors.white,
  });

  final Selection _item;

  final Color selectedColor;
  final Color backgroundColor;

  final Color textColor;
  final Color selectedTextColor;

  final Color selectedIconColor;
  final IconData selectedIcon;

  final Function tapped;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.tapped,
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Chip(
              avatar: buildSelectedIcon(this._item.selected),
              label: Text(_item.value,
                  style: TextStyle(
                      color: _item.selected
                          ? this.selectedTextColor
                          : this.textColor)),
              backgroundColor:
                  _item.selected ? selectedColor : backgroundColor)),
    );
  }

  Widget buildSelectedIcon(bool selected) => selected
      ? Icon(
          this.selectedIcon,
          color: this.selectedIconColor,
          size: 18,
        )
      : null;
}
