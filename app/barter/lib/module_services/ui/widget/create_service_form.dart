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
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _validUntilController = TextEditingController();

  String _category;
  DateTime _validUntil;
  int _daysToFinish;

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
                title: TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: 'Service Name',
                    hintStyle: TextStyle(fontSize: 16),
                  ),
                  validator: (s) {
                    if (s.isEmpty) {
                      return 'Service name is required!';
                    }
                    return null;
                  },
                ),
              ),
              ListTile(
                title: DropdownButtonFormField(
                  decoration: InputDecoration(
                    hintText: 'Category',
                    hintStyle: TextStyle(fontSize: 16),
                  ),
                  items: _getCategoriesDropDownList(),
                  onChanged: (s) {
                    _category = s;
                  },
                ),
              ),
              ListTile(
                title: TextFormField(
                  controller: _descriptionController,
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
                    DatePicker.showDatePicker(context).then((value) {
                      _validUntil = value;
                    });
                  },
                  icon: FaIcon(FontAwesomeIcons.clock),
                  label: Text(
                    _validUntil == null
                        ? 'Forever'
                        : '${_validUntil.month}/${_validUntil.year}',
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
                  onPressed: () {
                    widget.onServiceAdd(ServiceModel(
                      name: _nameController.text,
                      description: _descriptionController.text,
                      categoryId: _category,
                    ));
                  },
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
      chips.add(GestureDetector(
        onTap: () {
          _daysToFinish = i;
          if (mounted) setState(() {});
        },
        child: Padding(
          padding: const EdgeInsets.all(chipPadding),
          child: Chip(
            backgroundColor: i == _daysToFinish ? Theme.of(context).primaryColor : Colors.grey,
            label: Text(
              '$i Day',
              style: TextStyle(fontSize: 16),
            ),
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
