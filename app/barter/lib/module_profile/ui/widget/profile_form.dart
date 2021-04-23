import 'package:barter/consts/urls.dart';
import 'package:barter/module_auth/enums/user_type.dart';
import 'package:barter/module_profile/request/profile/profile_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class ProfileFormWidget extends StatefulWidget {
  final Function(ProfileRequest) onProfileSaved;
  final Function(ProfileRequest) onImageUpload;
  final ProfileRequest request;

  ProfileFormWidget({
    @required this.onProfileSaved,
    @required this.onImageUpload,
    this.request,
  });

  @override
  State<StatefulWidget> createState() => _ProfileFormWidgetState(
      request != null ? request.userName : null,
      request != null ? request.lastName : null,
      request != null ? request.phone : null,
      request != null ? request.location : null,
      request != null ? request.image : null);
}

class _ProfileFormWidgetState extends State<ProfileFormWidget> {
  final _lastNameController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _locationController = TextEditingController();
  final _serviceTitleController = TextEditingController();
  final _serviceDescriptionController = TextEditingController();
  final PageController _pageController = PageController();

  int _currentStep = 0;
  List<String> _tags =['tag 1', 'tag 2',];
  String theImage;
  UserRole userRole = UserRole.ROLE_USER;
  var acceptUsagePolicy = false;
  var acceptMarketingEmails = false;

  final _personalFormKey = GlobalKey<FormState>();
  final _companyFormKey = GlobalKey<FormState>();

  _ProfileFormWidgetState(
    String firstName,
    String lastName,
    String phone,
    String location,
    String image,
  ) {
    _firstNameController.text = firstName;
    _lastNameController.text = lastName;
    _phoneController.text = phone;
    _locationController.text = location;
    theImage = image;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
           scrollDirection: Axis.vertical,
           child: Column(
             children: [
               SizedBox(
                 height: 20.0,
               ),
                ModalRoute.of(context).canPop ? _setupHeader() : Container(),
               getAccountSwitcher(),
               AnimatedSwitcher(
                 duration: Duration(seconds: 1),
                 child: userRole == UserRole.ROLE_COMPANY
                     ? getCompanyForm()
                     : getPersonalForm(),
               ),
             ],
           ),
         );
    // return Column(
    //   children: [
    //     ModalRoute.of(context).canPop ? _setupHeader() : Container(),
    //     Expanded(
    //       child: PageIndicatorContainer(
    //           align: IndicatorAlign.top,
    //           indicatorColor: Colors.black26,
    //           indicatorSelectorColor: Colors.red,
    //           pageView: PageView(
    //             physics: NeverScrollableScrollPhysics(),
    //             controller: _pageController,
    //             scrollDirection: Axis.horizontal,
    //             children: [
    //               SingleChildScrollView(
    //                 scrollDirection: Axis.vertical,
    //                 child: Column(
    //                   children: [
    //                     SizedBox(
    //                       height: 20.0,
    //                     ),
    //                     getAccountSwitcher(),
    //                     AnimatedSwitcher(
    //                       duration: Duration(seconds: 1),
    //                       child: userRole == UserRole.ROLE_COMPANY
    //                           ? getCompanyForm()
    //                           : getPersonalForm(),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //              getServiceForm()
    //             ],
    //           ),
    //           length: 2),
    //     )
    //   ],
    // );
  }

  Widget getServiceForm() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20.0,
          ),
         // AddServiceScreen(AddServiceStateManager(ServicesService(ServicesRepository()))),

          Container(
           
            padding: EdgeInsets.all(10),
            decoration:
                BoxDecoration(border: Border.all(color: Colors.black26)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Add service you can provide '),
                TextFormField(
                  controller: _serviceTitleController,
                  decoration: InputDecoration(
                    hintText: 'Service Title',
                    labelText: 'Service Title',
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black26,
                      ),
                      borderRadius: BorderRadius.circular(5)),
                  width: 150,
                  child: PopupMenuButton<String>(
                      onSelected: (category) {},
                      child: ListTile(
                        title: Text('Category'),
                        trailing: Icon(Icons.arrow_drop_down),
                      ),
                      itemBuilder: (context) {
                        return <PopupMenuItem<String>>[
                          PopupMenuItem(
                            child: Text('category 1'),
                            value: "1",
                          ),
                          PopupMenuItem(
                            child: Text('category 2'),
                            value: "2",
                          ),
                        ];
                      }),
                ),
                TextFormField(
                  controller: _serviceDescriptionController,
                  decoration: InputDecoration(
                    hintText: 'Service Description',
                    labelText: 'Service Description',
                  ),
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    
                    FlatButton(
                      child: Text('+ Add tag'),
                      onPressed: (){
                       return showDialog(context: context,builder: (context){
                         return AlertDialog(
                           actions: [
                             IconButton(icon: Icon(Icons.add), onPressed: (){

                             })
                           ],
                           content: Container(
                             height: 200,
                             child:TextFormField(
                  controller: _serviceTitleController,
                  decoration: InputDecoration(
                    hintText: 'Service Title',
                    labelText: 'Service Title',
                  ),
                ),
                             color: Colors.red,),
                         );

                       });
                      },
                      ),

                      

                  ],
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                     child: Row(
                    children:List.generate(_tags.length, (index) =>Container(
                      child: Text(_tags[index].toString(),style: TextStyle(color: Colors.white),),
                      margin: EdgeInsets.only(left: 10),
                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.cyan,
                        borderRadius: BorderRadius.circular(20)
                      ),
                    ))
                  ),
                ),
  
              ],
            ),
          ),
          privacyAndMarketting(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RaisedButton(
                  color: Theme.of(context).primaryColor,
                  child: Text('Cancel'), //S.of(context).save),
                  onPressed: () {
                    _pageController.jumpToPage(0);
                    // if (_companyFormKey.currentState.validate()) {

                    //   // widget.onProfileSaved(
                    //   //   ProfileRequest(
                    //   //       roles: ['${UserRole.values[userRole.index]}'],
                    //   //       userName: _firstNameController.text,
                    //   //       lastName: _lastNameController.text,
                    //   //       phone: _phoneController.text,
                    //   //       location: _locationController.text,
                    //   //       image: theImage,
                    //   //       type: 'company'),
                    //   // );
                    // } else {
                    //   Scaffold.of(context).showSnackBar(SnackBar(
                    //       content: Text(
                    //           'Please Complete the Form'))); //S.of(context).pleaseCompleteTheForm)));
                    // }
                  }),
              RaisedButton(
                  color: Theme.of(context).primaryColor,
                  child: Text('Done'), //S.of(context).save),
                  onPressed: () {
                    widget.onProfileSaved(
                      ProfileRequest(
                        roles: ['${UserRole.values[userRole.index]}'],
                        userName: _firstNameController.text,
                        lastName: _lastNameController.text,
                        phone: _phoneController.text,
                        location: _locationController.text,
                        image: theImage,
                        type:  userRole == UserRole.ROLE_COMPANY?'company':'personal',
                      ),
                    );
                  })
            ],
          )
        ],
      )),
    );
  }

  Widget _setupHeader() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Text(
            'Complete Profile Info'.toUpperCase(),
            style: TextStyle(color: Colors.blue),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          color: Theme.of(context).primaryColor,
          height: 4,
        ),
        Container(
          padding: EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.info,
                  color: Colors.white,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Please First we need to complete your profile info',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 16,
        ),
      ],
    );
  }

  Widget privacyAndMarketting() {
    return Flex(
      direction: Axis.vertical,
      children: [
        CheckboxListTile(
          value: acceptMarketingEmails,
          title: Text('Don\'t mind marketing emails'),
          onChanged: (value) {
            acceptMarketingEmails = value;
            if (mounted) setState(() {});
          },
        ),
        CheckboxListTile(
          value: acceptUsagePolicy,
          title: Text('Accept Usage Policy'),
          onChanged: (bool value) {
            acceptUsagePolicy = value;
            if (mounted) setState(() {});
          },
        ),
      ],
    );
  }

  Widget getAccountSwitcher() {
    var iconSize = 36.0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GestureDetector(
          onTap: () {
            userRole = UserRole.ROLE_USER;
            if (mounted) {
              setState(() {});
            }
          },
          child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: userRole == UserRole.ROLE_USER
                    ? Theme.of(context).primaryColor
                    : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                'assets/images/freelance.svg',
                height: iconSize,
                width: iconSize,
              )),
        ),
        GestureDetector(
          onTap: () {
            userRole = UserRole.ROLE_COMPANY;
            if (mounted) {
              setState(() {});
            }
          },
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: userRole == UserRole.ROLE_COMPANY
                  ? Theme.of(context).primaryColor
                  : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              'assets/images/company.svg',
              height: iconSize,
              width: iconSize,
            ),
          ),
        ),
      ],
    );
  }

  Widget getPersonalForm() {
    return Padding(
      key: ObjectKey(UserRole.ROLE_USER),
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _personalFormKey,
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
                    ProfileRequest(
                      userName: _firstNameController.text,
                      lastName: _lastNameController.text,
                      phone: _phoneController.text,
                      location: _locationController.text,
                      image: value.path,
                    ),
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
                                                widget.request.image,
                                      ),
                                      fit: BoxFit.cover,
                                    )),
                              ),
                  ],
                ),
              ),
            ),
            TextFormField(
              controller: _firstNameController,
              decoration: InputDecoration(
                hintText: 'First Name',
                labelText: 'First Name',
              ),
              validator: (name) {
                if (name == null) {
                  return 'Name is required'; //S.of(context).nameIsRequired;
                }
                if (name.isEmpty) {
                  return 'Name is required'; //S.of(context).nameIsRequired;
                }
                return null;
              },
            ),
            // TextFormField(
            //   controller: _lastNameController,
            //   decoration: InputDecoration(
            //     hintText: 'Last Name',
            //     labelText: 'Last Name',
            //   ),
            //   validator: (name) {
            //     if (name == null) {
            //       return 'Name is required';//S.of(context).nameIsRequired;
            //     }
            //     if (name.isEmpty) {
            //       return 'Name is required';//S.of(context).nameIsRequired;
            //     }
            //     return null;
            //   },
            // ),
            TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: 'Phone Number', // S.of(context).phoneNumber,
                labelText: 'Phone Number', //S.of(context).phoneNumber,
              ),
              validator: (name) {
                // if (name == null) {
                //   return 'Please input phone number';//S.of(context).pleaseInputPhoneNumber;
                // }
                // if (name.isEmpty) {
                //   return 'Please input phone number';// S.of(context).pleaseInputPhoneNumber;
                // }
                return null;
              },
            ),
            TextFormField(
              controller: _locationController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: 'Location',
                labelText: 'Location',
              ),
              validator: (location) {
                // if (location == null) {
                //   return 'Please Input Location';
                // }
                // if (location.isEmpty) {
                //   return 'Please Input Location';
                // }
                return null;
              },
            ),

            RaisedButton(
                color: Theme.of(context).primaryColor,
                child: Text('Next'), //S.of(context).save),
                onPressed: () {
                  if (_personalFormKey.currentState.validate()) {
                   
                    widget.onProfileSaved(
                      ProfileRequest(
                        roles: ['${UserRole.values[userRole.index]}'],
                        userName: _firstNameController.text,
                        lastName: _lastNameController.text,
                        phone: _phoneController.text,
                        location: _locationController.text,
                        image: theImage,
                        type: 'personal',
                      ),
                    );
                  } else {
                    Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text(
                            'Please Complete the Form'))); //S.of(context).pleaseCompleteTheForm)));
                  }
                })
          ],
        ),
      ),
    );
  }

  Widget getCompanyForm() {
    return Padding(
      key: ObjectKey(UserRole.ROLE_COMPANY),
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _companyFormKey,
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
                    ProfileRequest(
                      userName: _firstNameController.text,
                      lastName: _lastNameController.text,
                      phone: _phoneController.text,
                      location: _locationController.text,
                      image: value.path,
                    ),
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
                                                widget.request.image,
                                      ),
                                      fit: BoxFit.cover,
                                    )),
                              ),
                  ],
                ),
              ),
            ),
            TextFormField(
              controller: _firstNameController,
              decoration: InputDecoration(
                hintText: 'Name',
                labelText: 'Name',
              ),
              validator: (name) {
                if (name == null) {
                  return 'Name is required'; // S.of(context).nameIsRequired;
                }
                if (name.isEmpty) {
                  return 'Name is required'; //S.of(context).nameIsRequired;
                }
                return null;
              },
            ),
            TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: 'Phone Number', //S.of(context).phoneNumber,
                labelText: 'Phone Number', //S.of(context).phoneNumber,
              ),
              validator: (name) {
                if (name == null) {
                  return 'Please input phone number'; //S.of(context).pleaseInputPhoneNumber;
                }
                if (name.isEmpty) {
                  return 'Please input phone number'; //S.of(context).pleaseInputPhoneNumber;
                }
                return null;
              },
            ),
            TextFormField(
              controller: _locationController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: 'Location',
                labelText: 'Location',
              ),
              validator: (location) {
                if (location == null) {
                  return 'Please Input Location';
                }
                if (location.isEmpty) {
                  return 'Please Input Location';
                }
                return null;
              },
            ),
            // privacyAndMarketting(),
            RaisedButton(
                color: Theme.of(context).primaryColor,
                child: Text('Next'), //S.of(context).save),
                onPressed: () {
                  if (_companyFormKey.currentState.validate()) {
                  
                    widget.onProfileSaved(
                      ProfileRequest(
                          roles: ['${UserRole.values[userRole.index]}'],
                          userName: _firstNameController.text,
                          lastName: _lastNameController.text,
                          phone: _phoneController.text,
                          location: _locationController.text,
                          image: theImage,
                          type: 'company'),
                    );
                  } else {
                    Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text(
                            'Please Complete the Form'))); //S.of(context).pleaseCompleteTheForm)));
                  }
                })
          ],
        ),
      ),
    );
  }
}
