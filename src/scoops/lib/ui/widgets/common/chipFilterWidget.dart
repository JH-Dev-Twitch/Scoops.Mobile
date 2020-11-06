import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChipFilter extends StatelessWidget {
  const ChipFilter({Key key, this.filters, this.tapped}) : super(key: key);

  final Function(int) tapped;
  final List<Filter> filters;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox(
        height: 80,
        child: new ListView.separated(
          separatorBuilder: (BuildContext context, int index) => SizedBox(
            width: 10,
          ),
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.all(10),
          itemCount: filters.length,
          itemBuilder: (BuildContext ctxt, int index) {
            var filter = filters[index];
            return GestureDetector(
              onTap: () => tapped(index),
              child: Chip(
                  backgroundColor: filter.selected
                      ? new Color(0xff166FFF)
                      : Colors.transparent,
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  label: new Text(
                    filter.title,
                    style: TextStyle(
                        color: filter.selected ? Colors.white : Colors.black,
                        fontSize: filter.selected ? 16 : 15,
                        fontWeight: filter.selected
                            ? FontWeight.w900
                            : FontWeight.w600),
                  )),
            );
          },
        ),
      ),
    );
  }
}

class Filter {
  String id;
  String title;
  bool selected;

  Filter(this.id, this.title, this.selected);
}
