import 'package:barter/module_services/model/category_model.dart';
import 'package:barter/module_services/model/service_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CreateServiceForm extends StatefulWidget {
  final List<CategoryModel> categories;
  final Function(ServiceModel) onServiceAdd;

  CreateServiceForm({@required this.categories, @required this.onServiceAdd});

  @override
  State<StatefulWidget> createState() => _CreateServiceFormState();
}

class _CreateServiceFormState extends State<CreateServiceForm> {


  @override
  Widget build(BuildContext context) {
    return Card(
      child: Form(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Flex(
            direction: Axis.vertical,
            children: [
              ListTile(
                title: Text(
                  'Add Service',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              ListTile(
                title: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Service Name',
                    hintStyle: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              ListTile(
                title: DropdownButtonFormField(
                  decoration: InputDecoration(
                    hintText: 'Category',
                    hintStyle: TextStyle(fontSize: 16),
                  ),
                  items: _getCategoriesDropDownList(),
                  onChanged: (s) {},
                ),
              ),
              ListTile(
                title: TextFormField(
                  minLines: 3,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: 'Service Description',
                    hintStyle: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  'This Service Will be active until: ',
                  style: TextStyle(fontSize: 16),
                ),
                trailing: RaisedButton.icon(
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  onPressed: () {
                    DatePicker.showDatePicker(context);
                  },
                  icon: FaIcon(FontAwesomeIcons.clock),
                  label: Text(
                    '2 Days',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  'Time Needed',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.start,
                  children: _getChips(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: OutlineButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: () {},
                  child: Text('Submit Service'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _getChips() {
    const chipPadding = 4.0;
    var chips = <Widget>[];
    for (int i = 0; i < 4; i++) {
      chips.add(Padding(
        padding: const EdgeInsets.all(chipPadding),
        child: Chip(
          label: Text(
            '$i Day',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ));
    }
    return chips;
  }

  List<DropdownMenuItem> _getCategoriesDropDownList() {
    var items = <DropdownMenuItem>[];
    widget.categories.forEach((element) {
      items.add(DropdownMenuItem(
        value: element.id,
        child: Text(
          '${element.name}',
          style: TextStyle(fontSize: 16),
        ),
      ));
    });
    return items;
  }
}
