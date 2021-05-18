import 'package:barter/module_swap/model/swap_items_model.dart';
import 'package:barter/module_swap/model/swap_model.dart';
import 'package:barter/module_swap/request/update_swap_request.dart';
import 'package:barter/module_swap/ui/widget/swap_list_item.dart';
import 'package:flutter/material.dart';

class UpdateSwapForm extends StatefulWidget {
  final List<SwapItemsModel> myItems;
  final List<SwapItemsModel> targetItems;
  final UpdateSwapRequest request;
  final Function(SwapModel) onSwapUpdate;

  UpdateSwapForm(
      {@required this.myItems,
      @required this.targetItems,
      @required this.request,
      @required this.onSwapUpdate});

  @override
  State<StatefulWidget> createState() => _UpdateSwapFormState();
}

class _UpdateSwapFormState extends State<UpdateSwapForm> {
  List<SwapItemsModel> selectedListItems1 = [];
  List<SwapItemsModel> selectedListItems2 = [];

  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() {
    widget.myItems.forEach((element1) {
      widget.request.swapItemsOne.forEach((element2) {
        if (element1.id == element2.toString()) {
          selectedListItems1.add(element1);
        }
      });
    });
    widget.targetItems.forEach((element1) {
      widget.request.swapItemsTwo.forEach((element2) {
        if (element1.id == element2.toString()) {
          selectedListItems2.add(element1);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Flex(
          direction: Axis.vertical,
          children: [
            ListTile(
              title: Text('My Services'),
            ),
            ListTile(
              title: DropdownButtonFormField(
                decoration: InputDecoration(
                  hintText: 'my services',
                  hintStyle: TextStyle(fontSize: 16),
                ),
                items: _getMyItemsDropDownList(),
                onChanged: (s) {
                  // _items1 = s;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                height: 56,
                width: 56,
                color: Theme.of(context).primaryColor,
                child: Icon(Icons.swap_calls_sharp),
              ),
            ),
            ListTile(
              title: Text('Target Services'),
            ),
            ListTile(
              title: DropdownButtonFormField(
                decoration: InputDecoration(
                  hintText: 'target services',
                  hintStyle: TextStyle(fontSize: 16),
                ),
                items: _getTargetItemsDropDownList(),
                onChanged: (s) {},
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: OutlineButton(
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  widget.onSwapUpdate(SwapModel(
                      id: widget.request.swapID,
                      accepted: false,
                      swapItemsOne: selectedListItems1,
                      swapItemsTow: selectedListItems2));
                },
                child: Text('send'),
              ),
            )
          ],
        ),
      ),
    );
  }

  List<DropdownMenuItem> _getMyItemsDropDownList() {
    var items = <DropdownMenuItem>[];
    widget.myItems.forEach((element) {
      if (selectedListItems1.contains(element)) {
        items.add(DropdownMenuItem(
            value: element.id,
            child: ListItem(
              selected: true,
              item: element,
              isSelected: (bool value) {
                setState(() {
                  if (value) {
                    selectedListItems1.add(element);
                  } else {
                    selectedListItems1.remove(element);
                  }
                });
              },
            )));
      } else {
        items.add(DropdownMenuItem(
            value: element.id,
            child: ListItem(
              selected: false,
              item: element,
              isSelected: (bool value) {
                setState(() {
                  if (value) {
                    selectedListItems1.add(element);
                  } else {
                    selectedListItems1.remove(element);
                  }
                });
              },
            )));
      }
    });

    return items;
  }

  List<DropdownMenuItem> _getTargetItemsDropDownList() {
    var items = <DropdownMenuItem>[];
    widget.targetItems.forEach((element) {
      if (selectedListItems2.contains(element)) {
        items.add(DropdownMenuItem(
            value: element.id,
            child: ListItem(
              selected: true,
              item: element,
              isSelected: (bool value) {
                setState(() {
                  if (value) {
                    selectedListItems2.add(element);
                  } else {
                    selectedListItems2.remove(element);
                  }
                });
              },
            )));
      } else {
        items.add(DropdownMenuItem(
            value: element.id,
            child: ListItem(
              selected: false,
              item: element,
              isSelected: (bool value) {
                setState(() {
                  if (value) {
                    selectedListItems2.add(element);
                  } else {
                    selectedListItems2.remove(element);
                  }
                });
              },
            )));
      }
    });
    return items;
  }
}