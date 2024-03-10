import 'package:flutter/material.dart';
import 'package:graduation_gathering/Profile/academic_structure.dart';
import 'package:graduation_gathering/Profile/set_user_profile.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';

import '../Auth/auth_token.dart';
import '../Profile/account_type.dart';
import '../Profile/profile_settings.dart';

/// This holds the screen for the application.
class ProfileScreen extends StatefulWidget {
  const ProfileScreen(
      {super.key, required this.authToken, required this.profile, required this.academicStructure});

  final AuthToken authToken;
  final ProfileSettings profile;
  final AcademicStructure academicStructure;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

// This class contains the GUI structure for the app.
class _ProfileScreenState extends State<ProfileScreen> {
  late SetUserProfile _setUserProfile;
  late SingleValueDropDownController _facultyDropDownController;
  late SingleValueDropDownController _schoolDropDownController;
  late SingleValueDropDownController _courseDropDownController;

  late List<DropDownValueModel> _facultyDropDownList = [];
  late List<DropDownValueModel> _schoolDropDownList = [];
  late List<DropDownValueModel> _courseDropDownList = [];

  bool _schoolVisible = false;
  bool _courseVisible = false;

  String _email = "";
  late AccountType _accountType;
  String? _name;
  String? _faculty;
  String? _school;
  String? _course;

  @override
  void initState() {
    _setUserProfile = SetUserProfile(widget.authToken);
    _email = widget.profile.getEmail();
    _accountType = widget.profile.getAccountType();
    _name = widget.profile.getName();
    _faculty = widget.profile.getFaculty();
    _school = widget.profile.getSchool();
    _course = widget.profile.getCourse();

    _schoolVisible = (_faculty != null);
    _courseVisible = (_school != null);

    _facultyDropDownController = SingleValueDropDownController();
    _schoolDropDownController = SingleValueDropDownController();
    _courseDropDownController = SingleValueDropDownController();
    if (_faculty != null)
    {
      _facultyDropDownController.dropDownValue = DropDownValueModel(name: _faculty!, value: _faculty);
    }
    if (_school != null)
    {
      _schoolDropDownController.dropDownValue = DropDownValueModel(name: _school!, value: _school);
    }
    if (_course != null)
    {
      _courseDropDownController.dropDownValue = DropDownValueModel(name: _course!, value: _course);
    }
    widget.academicStructure.getFaculties().forEach((element) {_facultyDropDownList.add(DropDownValueModel(name: element, value: element));});
    if (_schoolVisible)
    {
      widget.academicStructure.getSchoolsFromFaculty(_faculty!)?.forEach((element) {_schoolDropDownList.add(DropDownValueModel(name: element, value: element));});
    }
    if (_courseVisible)
    {
      widget.academicStructure.getCoursesFromSchoolAndFaculty(_school!, _faculty!)?.forEach((element) {_courseDropDownList.add(DropDownValueModel(name: element, value: element));});
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();
    if (_name != null) {
      textEditingController.text = _name!;
    }
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 7),
              const Text("Profile", style: TextStyle(fontSize: 30)),
              const SizedBox(height: 5),
              Text("Email: $_email", style: const TextStyle(fontSize: 22)),
              const SizedBox(height: 5),
              Text("Account Type: ${_accountType.accountTypeAsString}",
                  style: const TextStyle(fontSize: 22)),
              const SizedBox(height: 5),
              Row(children: [
                const Text("Name: ", style: TextStyle(fontSize: 22)),
                const SizedBox(width: 3),
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: TextField(
                      onChanged: (text) {
                        if (text.length > 50) {
                          text = text.substring(0, 50);
                        }
                        _name = text;
                      },
                      controller: textEditingController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 0.0),
                        ),
                        hintText: 'Enter your name here...',
                      ),
                    )),
              ]),
              const SizedBox(height: 5),
              Row(children: [
                const Text("Faculty:", style: TextStyle(fontSize: 22)),
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: DropDownTextField(
                      key: const Key("Faculty Search box"),
                      controller: _facultyDropDownController,
                      clearOption: true,
                      enableSearch: true,
                      textFieldDecoration:
                          const InputDecoration(hintText: "Faculty"),
                      searchDecoration: const InputDecoration(
                          hintText: "Enter your faculty here"),
                      validator: (value) {
                        if (value == null) {
                          return "Required field";
                        } else {
                          return null;
                        }
                      },
                      dropDownItemCount: 5,
                      dropDownList: _facultyDropDownList,
                      onChanged: (value) {
                        if (value == "" || value == null) {
                          _schoolVisible = false;
                          _courseVisible = false;
                          _school = null;
                          _course = null;
                          _faculty = null;
                        } else {
                          _schoolVisible = true;
                          _schoolDropDownList.clear();
                          _schoolDropDownController.dropDownValue = null;
                          widget.academicStructure.getSchoolsFromFaculty(value.value)?.forEach((element) {_schoolDropDownList.add(DropDownValueModel(name: element, value: element));});
                          _faculty = value.value;
                        }
                        setState(() {});
                      },
                    ))
              ]),
              const SizedBox(height: 5),
              Visibility(
                  visible: _schoolVisible,
                  child: Row(children: [
                    const Text("School:", style: TextStyle(fontSize: 22)),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: DropDownTextField(
                          key: const Key("School Search box"),
                          controller: _schoolDropDownController,
                          clearOption: true,
                          enableSearch: true,
                          textFieldDecoration:
                              const InputDecoration(hintText: "School"),
                          searchDecoration: const InputDecoration(
                              hintText: "Enter your school here"),
                          validator: (value) {
                            if (value == null) {
                              return "Required field";
                            } else {
                              return null;
                            }
                          },
                          dropDownItemCount: 5,
                          dropDownList: _schoolDropDownList,
                          onChanged: (value) {
                            if (value == "" || value == null) {
                              _courseVisible = false;
                              _school = null;
                              _course = null;
                            } else {
                              if (widget.profile.getAccountType() == AccountType.student) {
                                _courseVisible = true;
                                _courseDropDownList.clear();
                                _courseDropDownController.dropDownValue = null;
                                widget.academicStructure
                                    .getCoursesFromSchoolAndFaculty(
                                    value.value, _faculty!)?.forEach((element) {
                                  _courseDropDownList.add(DropDownValueModel(
                                      name: element, value: element));
                                });
                                _school = value.value;
                              }
                            }
                            setState(() {});
                          },
                        ))
                  ])),
              const SizedBox(height: 5),
              Visibility(
                  visible: _courseVisible,
                  child: Row(children: [
                    const Text("Course: ", style: TextStyle(fontSize: 22)),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: DropDownTextField(
                          key: const Key("Course Search box"),
                          controller: _courseDropDownController,
                          clearOption: true,
                          enableSearch: true,
                          textFieldDecoration:
                              const InputDecoration(hintText: "Course"),
                          searchDecoration: const InputDecoration(
                              hintText: "Enter your course here"),
                          validator: (value) {
                            if (value == null) {
                              return "Required field";
                            } else {
                              return null;
                            }
                          },
                          dropDownItemCount: 5,
                          dropDownList: _courseDropDownList,
                          onChanged: (value) {
                            if (value == "" || value == null) {
                              _course = null;
                            }
                            else
                            {
                              _course = value.value;
                            }
                            setState(() {});
                          },
                        ))
                  ])),
              Container(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  onPressed: () {
                    _saveSettings();
                  },
                  child: const Text("Save", style: TextStyle(fontSize: 17)),
                ),
              ),
            ],
          ),
        )));
  }

  _saveSettings() {
    widget.profile.setHasLoggedInBefore(true);
    widget.profile.setName(_name);
    widget.profile.setFaculty(_faculty);
    widget.profile.setSchool(_school);
    widget.profile.setCourse(_course);
    _setUserProfile.send(widget.profile);
  }
}
