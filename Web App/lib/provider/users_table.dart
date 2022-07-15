import 'package:bestfitnesstrackereu/provider/auth.dart';
import 'package:flutter/material.dart';
import 'package:responsive_table/responsive_table.dart';
import '../../datamodels/user_model.dart';
import '../../services/user_services.dart';

// everything in this class is used in user_administration_view_...
// used for the function of the table

class UsersTable with ChangeNotifier {
  List<int> perPages = [10, 20, 50, 100];
  int total = 100;
  int? currentPerPage = 100;
  List<bool>? expanded;
  String? searchKey = "id";

  int currentPage = 1;
  bool isSearch = false;
  List<Map<String, dynamic>> sourceOriginal = [];
  List<Map<String, dynamic>> sourceFiltered = [];
  List<Map<String, dynamic>> usersTableSource = [];
  List<Map<String, dynamic>> usersTableSourceScientist = [];

  List<Map<String, dynamic>> selecteds = [];
  String selectableKey = "id";

  String? sortColumn;
  bool sortAscending = true;
  bool isLoading = true;
  bool showSelect = true;

  // Headers of the admin table
  List<DatatableHeader> adminTableHeaders = [
    DatatableHeader(
        text: "UID",
        value: "uid",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Benutzername",
        value: "username",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "E-Mail",
        value: "email",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Vorname",
        value: "first name",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Nachname",
        value: "last name",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Geburtsdatum",
        value: "birthday",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Geschlecht",
        value: "gender",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Status",
        value: "status",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Rolle",
        value: "role",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
  ];

  // Headers of the scientist table
  List<DatatableHeader> scientistTableHeaders = [
    DatatableHeader(
        text: "UID",
        value: "uid",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Benutzername",
        value: "username",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "E-Mail",
        value: "email",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Vorname",
        value: "first name",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Nachname",
        value: "last name",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Geburtsdatum",
        value: "birthday",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Geschlecht",
        value: "gender",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Status",
        value: "status",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
  ];

  final UserServices _userServices = UserServices();
  List<UserModel> _users = <UserModel>[];
  List<UserModel> get users => _users;

  final UserServices _scientistServices = UserServices();
  List<UserModel> _scientist = <UserModel>[];
  List<UserModel> get scientist => _scientist;

  // get all users from the database
  Future _loadFromFirebase() async {
    _users = await _userServices.getAllUsers();
    _scientist = await _scientistServices.getAllScientists();
  }

  // get all the data from the users (_loadFromFirebase safed the data in _users) and safe them in a Map<String, dynamic>
  List<Map<String, dynamic>> _getUsersData() {
    List<Map<String, dynamic>> temps = [];
    var i = _users.length;
    print("Users:" + i.toString());
    for (UserModel userData in _users) {
      temps.add({
        "uid": userData.uid,
        "username": userData.username,
        "email": userData.email,
        "first name": userData.firstName,
        "last name": userData.lastName,
        "birthday": userData.birthday,
        "gender": userData.gender,
        "status": userData.status,
        'role': userData.role,
      });
      i++;
    }
    return temps;
  }
  // get all the data from the users (_loadFromFirebase safed the data in _users) and safe them in a Map<String, dynamic>
  List<Map<String, dynamic>> _getUsersDataScientist() {
    List<Map<String, dynamic>> temps = [];
    var i = _scientist.length;
    print("Wissenschaftler:" + i.toString());
    for (UserModel userData in _scientist) {
      temps.add({
        "uid": userData.uid,
        "username": userData.username,
        "email": userData.email,
        "first name": userData.firstName,
        "last name": userData.lastName,
        "birthday": userData.birthday,
        "gender": userData.gender,
        "status": userData.status,
      });
      i++;
    }
    return temps;
  }

  // initialize the data from the database into the table
  initializeData() async {
    mockPullData();
  }

  // initialize function
  mockPullData() async {
    final AuthProvider authprovider = AuthProvider();
    expanded = List.generate(
        currentPerPage!, (index) => false); //generate a list of currentpages
    isLoading = true;
    notifyListeners();
    await _loadFromFirebase(); // get all users from the database

    usersTableSourceScientist.clear();
    usersTableSourceScientist.addAll(_getUsersDataScientist());

    sourceOriginal.clear();
    sourceOriginal.addAll(_getUsersData());

    sourceFiltered = sourceOriginal;
    total = sourceFiltered.length; //total length of the users in the table
    usersTableSource = sourceFiltered
        .getRange(0, _users.length)
        .toList(); // return range from 0 to the size of the user in the table/database
    isLoading = false;
    notifyListeners();
  }

  // resets the data
  resetData({start: 0}) async {
    isLoading = true;
    notifyListeners();
    var _expandedLen =
        total - start < currentPerPage! ? total - start : currentPerPage!;
    expanded = List.generate(_expandedLen as int, (index) => false);
    usersTableSource.clear();
    usersTableSource =
        sourceFiltered.getRange(start, start + _expandedLen).toList();
    isLoading = false;
    notifyListeners();
  }

  // filters the data in the table
  filterData(value) {
    isLoading = true;
    notifyListeners();
    try {
      if (value == "" || value == null) {
        sourceFiltered = sourceOriginal;
      } else {
        sourceFiltered = sourceOriginal
            .where((data) => data[searchKey!]
                .toString()
                .toLowerCase()
                .contains(value.toString().toLowerCase()))
            .toList();
      }
      total = sourceFiltered.length;
      var _rangeTop = total < currentPerPage! ? total : currentPerPage!;
      expanded = List.generate(_rangeTop, (index) => false);
      usersTableSource = sourceFiltered.getRange(0, _rangeTop).toList();
    } catch (e) {
      print(e);
    }
    isLoading = false;
    notifyListeners();
  }

  // sorts the data when an user clicks on the column
  onSort(dynamic value) {
    isLoading = true;
    notifyListeners();
    sortColumn = value;
    sortAscending = !sortAscending;
    if (sortAscending) {
      sourceFiltered
          .sort((a, b) => b["$sortColumn"].compareTo(a["$sortColumn"]));
    } else {
      sourceFiltered
          .sort((a, b) => a["$sortColumn"].compareTo(b["$sortColumn"]));
    }
    var _rangeTop = currentPerPage! < sourceFiltered.length
        ? currentPerPage!
        : sourceFiltered.length;
    usersTableSource = sourceFiltered.getRange(0, _rangeTop).toList();
    searchKey = value;

    isLoading = false;
    notifyListeners();
  }

  // add or remove the selected row to the "selecteds" variable
  onSelected(bool? value, Map<String, dynamic> item) {
    print("$value  $item ");
    if (value!) {
      selecteds.add(item); //List of Map <String, dynamic>
    } else {
      selecteds.removeAt(selecteds.indexOf(item));
    }
    notifyListeners();
  }

  // when click on the field "select all", then select the entire map (add to selecteds)
  onSelectAll(bool? value) {
    if (value!) {
      selecteds = usersTableSource.map((entry) => entry).toList().cast();
    } else {
      selecteds.clear();
    }
    notifyListeners();
  }

  onChanged(int? value) {
    currentPerPage = value;
    currentPage = 1;
    resetData();
    notifyListeners();
  }

  // clicking on previous page
  previous() {
    currentPage == 1
        ? null
        : () {
            var nextSet = currentPage - currentPerPage!;
            currentPage = nextSet > 1 ? nextSet : 1;
            resetData(start: currentPage - 1);
          };
    notifyListeners();
  }

  // clicking on next page
  next() {
    currentPage + currentPerPage! - 1 > total
        ? null
        : () {
            var nextSet = currentPage + currentPerPage!;

            currentPage = nextSet < total ? nextSet : total - currentPerPage!;
            resetData(start: nextSet - 1);
          };
    notifyListeners();
  }

  // initialize the table
  UsersTable.init() {
    initializeData();
  }
}
