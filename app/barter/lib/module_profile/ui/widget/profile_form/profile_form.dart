import 'dart:io';

import 'package:barter/consts/urls.dart';
import 'package:barter/generated/l10n.dart';
import 'package:barter/module_profile/request/profile/profile_request.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileFormWidget extends StatefulWidget {
  final Function(String, String, String) onProfileSaved;
  final Function(String, String, String) onImageUpload;
  final ProfileRequest request;

  ProfileFormWidget({
    @required this.onProfileSaved,
    @required this.onImageUpload,
    this.request,
  });

  @override
  State<StatefulWidget> createState() => _ProfileFormWidgetState(
      request != null ? request.name : null,
      request != null ? request.phone : null);
}

class _ProfileFormWidgetState extends State<ProfileFormWidget> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  String localImage;

  final _formKey = GlobalKey<FormState>();

  _ProfileFormWidgetState(String name, String phone) {
    _nameController.text = name;
    _phoneController.text = phone;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.always,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GestureDetector(
              onTap: () {
                ImagePicker()
                    .getImage(source: ImageSource.gallery)
                    .then((value) {
                  widget.onImageUpload(
                    _nameController.text,
                    _phoneController.text,
                    value.path,
                  );
                  setState(() {});
                });
              },
              child: Container(
                height: 96,
                width: 96,
                decoration: BoxDecoration(shape: BoxShape.circle),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        shape: BoxShape.circle,
                      ),
                    ),
                    widget.request == null
                        ? Container()
                        : widget.request.image == null
                            ? Container()
                            : Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          widget.request.image.contains('http')
                                              ? widget.request.image
                                              : Urls.IMAGES_ROOT +
                                                  widget.request.image),
                                      fit: BoxFit.cover,
                                    )),
                              ),
                  ],
                ),
              ),
            ),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: S.of(context).name,
                labelText: S.of(context).name,
              ),
              validator: (name) {
                if (name == null) {
                  return S.of(context).nameIsRequired;
                }
                if (name.isEmpty) {
                  return S.of(context).nameIsRequired;
                }
                return null;
              },
            ),
            TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: S.of(context).phoneNumber,
                labelText: S.of(context).phoneNumber,
              ),
              validator: (name) {
                if (name == null) {
                  return S.of(context).pleaseInputPhoneNumber;
                }
                if (name.isEmpty) {
                  return S.of(context).pleaseInputPhoneNumber;
                }
                return null;
              },
            ),
            RaisedButton(
                color: Theme.of(context).primaryColor,
                child: Text(S.of(context).save),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    widget.onProfileSaved(
                      _nameController.text,
                      _phoneController.text,
                      widget.request.image,
                    );
                  } else {
                    Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text(S.of(context).pleaseCompleteTheForm)));
                  }
                })
          ],
        ),
      ),
    );
  }
}
