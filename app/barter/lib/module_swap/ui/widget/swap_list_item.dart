import 'package:barter/module_swap/model/swap_items_model.dart';
import 'package:flutter/material.dart';

class ListItem extends StatefulWidget {
  final SwapItemsModel item;
  final ValueChanged<bool> isSelected;
  final bool selected;
  ListItem({this.item, this.isSelected, this.selected});

  @override
  _ListItemState createState() => _ListItemState(selected);
}

class _ListItemState extends State<ListItem> {
  _ListItemState(this.isSelected);
  bool isSelected ;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
          widget.isSelected(isSelected);
        });
      },
      child: Stack(
        children: <Widget>[
          Container(
            height: 50,
            child: Text(widget.item.itemTitle),
          ),
          isSelected
              ? Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.check_circle,
                color: Colors.blue,
              ),
            ),
          )
              : Container()
        ],
      ),
    );
  }
}