import 'package:flutter/material.dart';
import 'package:graduation_gathering/Screen/Connections/follow_box_widget.dart';
import 'package:graduation_gathering/Profile/Connections/connections.dart';
import 'package:graduation_gathering/Profile/academic_structure.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';

import '../../Auth/auth_token.dart';
import '../../Profile/Connections/connection_profile.dart';
import '../../Profile/Connections/other_user_profiles.dart';
import '../../Profile/account_type.dart';

/// Widget for the add connections screen.
class AddConnectionsScreen extends StatefulWidget {
  const AddConnectionsScreen(
      {super.key,
      required this.authToken,
      required this.connections,
      required this.otherUserProfiles,
      required this.academicStructure,
      required this.backButtonPressed});

  final AuthToken authToken;
  final Connections connections;
  final OtherUserProfiles otherUserProfiles;
  final AcademicStructure academicStructure;
  final Function() backButtonPressed;

  @override
  State<AddConnectionsScreen> createState() => _AddConnectionsScreenState();
}

// State for the add connections screen.
class _AddConnectionsScreenState extends State<AddConnectionsScreen> {
  late Widget _connectionsContainer;

  final TextEditingController _searchBoxController = TextEditingController();

  String? _searchText;

  late SingleValueDropDownController _facultyDropDownController;
  late SingleValueDropDownController _schoolDropDownController;
  late SingleValueDropDownController _courseDropDownController;

  final List<DropDownValueModel> _facultyDropDownList = [];
  final List<DropDownValueModel> _schoolDropDownList = [];
  final List<DropDownValueModel> _courseDropDownList = [];

  bool _schoolVisible = false;
  bool _courseVisible = false;

  String? _faculty;
  String? _school;
  String? _course;

  AccountType? _accountTypeValue;

  @override
  void initState() {
    _createConnectionsContainer();

    _schoolVisible = false;
    _courseVisible = false;

    _facultyDropDownController = SingleValueDropDownController();
    _schoolDropDownController = SingleValueDropDownController();
    _courseDropDownController = SingleValueDropDownController();
    widget.academicStructure.getFaculties().forEach((element) {
      _facultyDropDownList
          .add(DropDownValueModel(name: element, value: element));
    });
    super.initState();
  }

  // Forms the list of connections boxes.
  _createConnectionsContainer() {
    if (!(_searchText != null && _searchText!.length >= 3)) {
      _connectionsContainer = const Column(
        children: [],
      );
      return;
    }

    List<ConnectionProfile> connectionsPreFilter = [];
    for (ConnectionProfile profile in widget.otherUserProfiles) {
      if (!filterProfile(profile)) {
        connectionsPreFilter.add(profile);
      }
    }

    List<ConnectionProfile> connections = [];
    for (ConnectionProfile profile in connectionsPreFilter) {
      if ((profile
              .getEmail()
              .toLowerCase()
              .contains(_searchText!.toLowerCase()) ||
          (profile.getName() != null &&
              profile
                  .getName()!
                  .toLowerCase()
                  .contains(_searchText!.toLowerCase())))) {
        connections.add(profile);
      }
    }

    if (connections.isEmpty)
    {
      _connectionsContainer = const Text("No results found");
      return;
    }

    List<Widget> connectionsWidgets = [];
    for (ConnectionProfile profile in connections) {
      connectionsWidgets.add(FollowBoxWidget(profile: profile, token: widget.authToken));
    }

    _connectionsContainer = SingleChildScrollView(
      scrollDirection: Axis.vertical,
        child:Column(
      children: connectionsWidgets,
    ));
  }

  bool filterProfile(ConnectionProfile profile) {
    if (_accountTypeValue != null &&
        _accountTypeValue != profile.getAccountType()) {
      return true;
    }

    if (_faculty != null) {
      if (_faculty != profile.getFaculty()) {
        return true;
      } else {
        if (_school != null) {
          if (_school != profile.getSchool()) {
            return true;
          } else {
            if (_course != null && _course != profile.getCourse()) {
              return true;
            }
          }
        }
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFFFFFFF),
        resizeToAvoidBottomInset: false,
        body: Padding(
            padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
        child:
        Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  widget.backButtonPressed();
                },
                child: const Text("Back", style: TextStyle(fontSize: 20))),
            const Text("Filters: "),
            DropdownButton<AccountType?>(
                value: _accountTypeValue,
                items: const [
                  DropdownMenuItem(
                    value: null,
                    child: Text("Account Type"),
                  ),
                  DropdownMenuItem(
                    value: AccountType.student,
                    child: Text("Student"),
                  ),
                  DropdownMenuItem(
                    value: AccountType.staff,
                    child: Text("Staff"),
                  )
                ],
                menuMaxHeight: 500,
                onChanged: (value) {
                  _accountTypeValue = value;
                  if (value == AccountType.staff) {
                    _courseVisible = false;
                    _course = null;
                  } else if (_school != null) {
                    _courseVisible = true;
                    _courseDropDownController.dropDownValue = null;
                  }
                  _createConnectionsContainer();
                  setState(() {});
                },
                elevation: 8,
                isExpanded: true,
                underline: Container()),
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
                        widget.academicStructure
                            .getSchoolsFromFaculty(value.value)
                            ?.forEach((element) {
                          _schoolDropDownList.add(DropDownValueModel(
                              name: element, value: element));
                        });
                        _faculty = value.value;
                      }
                      _createConnectionsContainer();
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
                            if (_accountTypeValue != AccountType.staff) {
                              _courseVisible = true;
                              _courseDropDownList.clear();
                              _courseDropDownController.dropDownValue = null;
                              widget.academicStructure
                                  .getCoursesFromSchoolAndFaculty(
                                      value.value, _faculty!)
                                  ?.forEach((element) {
                                _courseDropDownList.add(DropDownValueModel(
                                    name: element, value: element));
                              });
                              _school = value.value;
                            }
                          }
                          _createConnectionsContainer();
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
                          } else {
                            _course = value.value;
                          }
                          _createConnectionsContainer();
                          setState(() {});
                        },
                      ))
                ])),
            TextField(
              onChanged: (text) {
                if (text.length > 50) {
                  text = text.substring(0, 50);
                }
                _searchText = text;
                _createConnectionsContainer();
                setState(() {});
              },
              controller: _searchBoxController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 0.0),
                ),
                hintText: 'Enter a Name or Email address here...',
              ),
            ),
            SingleChildScrollView(
              child: _connectionsContainer,
            ),
          ],
        )));
  }
}
