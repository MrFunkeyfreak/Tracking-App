import 'package:bestfitnesstrackereu/pages/user_administration/widgets/add_button_admin.dart';
import 'package:bestfitnesstrackereu/pages/user_administration/widgets/edit_button_admin.dart';
import 'package:bestfitnesstrackereu/provider/auth.dart';
import 'package:bestfitnesstrackereu/provider/users_table.dart';
import 'package:bestfitnesstrackereu/services/user_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_table/responsive_table.dart';
import 'package:bestfitnesstrackereu/routing/route_names.dart';

// table to administrate every user, scientist and admin
// add, edit, delete, lock or unlock are the buttons/functions for this table (see widgets)

class UsersAdministrationViewAdminDesktop extends StatefulWidget {
  const UsersAdministrationViewAdminDesktop({Key? key}) : super(key: key);

  @override
  _UsersAdministrationViewAdminDesktopState createState() =>
      _UsersAdministrationViewAdminDesktopState();
}

class _UsersAdministrationViewAdminDesktopState
    extends State<UsersAdministrationViewAdminDesktop> {
  String? uid;
  late List<Map<String, dynamic>> selectedRow;
  UserServices userServicesInstance = UserServices();
  late Map<String, dynamic> UpdateUser;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final UsersTable userTable = Provider.of<UsersTable>(context);
    final AuthProvider authproviderInstance =
        Provider.of<AuthProvider>(context);
    final hasAuthenticated = context.select<AuthProvider, bool>(
        (AuthProvider) => authproviderInstance.status == Status.Admin);

    return Scaffold(
        body: Center(
          // if user is admin, then build up the side, otherwise show permission denied
          child: hasAuthenticated
          ? Scaffold(
              appBar: AppBar(
                  title: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                    const Text("Admin-Menü", style: TextStyle(color: Colors.white)),
                    const Spacer(),
                    const Text("Benutzerverwaltung"),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.refresh_sharp),
                      onPressed: userTable.initializeData,
                    ),
                  ])),
              drawer: Drawer(
                child: ListView(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.storage),
                      title: const Text("Benutzerverwaltung"),
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(UsersAdministrationRoute);
                      },
                    ),
                  ],
                ),
              ),
              body: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                    Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(0),
                      constraints: const BoxConstraints(
                        maxHeight: 700,
                      ),
                      child: Card(
                        elevation: 1,
                        shadowColor: Colors.black,
                        clipBehavior: Clip.none,
                        child: ResponsiveDatatable(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Wrap(
                                children: <Widget>[
                                  //add-button + functionality (see widgets)
                                  const AddButtonAdmin(),

                                  const SizedBox(
                                    width: 15,
                                  ),

                                  //edit-button + functionality (see widgets)
                                  const EditButtonAdmin(),

                                  const SizedBox(
                                    width: 15,
                                  ),

                                  TextButton.icon(
                                    onPressed: () async => {
                                      selectedRow = userTable
                                          .selecteds, //get the user informations from the user, which is selected in the table

                                      if (selectedRow.isEmpty)
                                        {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: const Text(
                                                      "Error: Bitte wähle einen User aus."),
                                                  actions: [
                                                    TextButton(
                                                      child: const Text("Ok"),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    )
                                                  ],
                                                );
                                              })
                                        },

                                      if (selectedRow.length == 1)
                                        {
                                          uid = selectedRow[0][
                                              'uid'], // get the uid of the selected user

                                          // delete user -> for this create a Map <String, dynamic> without the personal informations from the user
                                          // and set the status to deleted + role to user
                                          UpdateUser = {
                                            'id': uid,
                                            'username': '',
                                            'first name': '',
                                            'last name': '',
                                            'birthday': '',
                                            'gender': '',
                                            'status': 'gelöscht',
                                            'role': 'User'
                                          },
                                          //update the user details from the Map <String, dynamic>      -> user is deleted
                                          userServicesInstance
                                              .updateUserData(UpdateUser),
                                          print(uid! + 'user gelöscht'),
                                          userTable.selecteds.clear(),
                                          userTable.initializeData(),
                                        },

                                      // more than 1 user got selected
                                      if (selectedRow.length >= 2)
                                        {
                                          //for all users in the Map <String,dynamic> "selectedRow" update status to deleted and
                                          // delete all personal informations + role to user
                                          for (var i = 0;
                                              i < selectedRow.length;
                                              i++)
                                            {
                                              UpdateUser = {
                                                'id': selectedRow[i]['uid'],
                                                'username': '',
                                                'first name': '',
                                                'last name': '',
                                                'birthday': '',
                                                'gender': '',
                                                'status': 'gelöscht',
                                                'role': 'User'
                                              },
                                              userServicesInstance
                                                  .updateUserData(UpdateUser),
                                            },
                                        },
                                      userTable.selecteds.clear(),
                                      userTable.initializeData(),
                                    },
                                    icon: const Icon(
                                      IconData(0xe1bb,
                                          fontFamily: 'MaterialIcons'),
                                      color: Colors.black,
                                    ),
                                    label: const Text("Löschen",
                                        style: TextStyle(color: Colors.black)),
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.grey),
                                      padding:
                                          MaterialStateProperty.all<EdgeInsets>(
                                              const EdgeInsets.all(10)),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),

                              Wrap(
                                children: [
                                  TextButton.icon(
                                    onPressed: () async => {
                                      selectedRow = userTable.selecteds, // get the selected row from the table
                                      if (selectedRow.isEmpty)
                                        {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: const Text(
                                                      "Error: Bitte wähle einen User aus."),
                                                  actions: [
                                                    TextButton(
                                                      child: const Text("Ok"),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    )
                                                  ],
                                                );
                                              })
                                        },
                                      if (selectedRow.length == 1)
                                        {
                                          uid = selectedRow[0]['uid'],
                                          await authproviderInstance
                                              .updateUserStatus(uid,
                                                  'gesperrt'), //update status from user with uid to locked
                                        },
                                      if (selectedRow.length >= 2)
                                        {
                                          // update status from all user which got selected to locked
                                          for (var i = 0;
                                              i < selectedRow.length;
                                              i++)
                                            {
                                              await authproviderInstance
                                                  .updateUserStatus(
                                                      selectedRow[i]['uid'],
                                                      'gesperrt'),
                                            },
                                        },
                                      userTable.selecteds.clear(),
                                      userTable.initializeData(),
                                    },
                                    icon: const Icon(
                                      IconData(0xe3b1,
                                          fontFamily: 'MaterialIcons'),
                                      color: Colors.black,
                                    ),
                                    label: const Text("Sperren",
                                        style: TextStyle(color: Colors.black)),
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.grey),
                                      padding:
                                          MaterialStateProperty.all<EdgeInsets>(
                                              const EdgeInsets.all(10)),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  TextButton.icon(
                                    onPressed: () async => {
                                      selectedRow = userTable.selecteds,
                                      if (selectedRow.isEmpty)
                                        {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: const Text(
                                                      "Error: Bitte wähle einen User aus."),
                                                  actions: [
                                                    TextButton(
                                                      child: const Text("Ok"),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    )
                                                  ],
                                                );
                                              })
                                        },
                                      if (selectedRow.length == 1)
                                        {
                                          uid = selectedRow[0]['uid'],
                                          await authproviderInstance
                                              .updateUserStatus(uid,
                                                  'aktiv'), //update status from user with uid to active (unlocked)
                                        },
                                      if (selectedRow.length >= 2)
                                        {
                                          // update status from all user which got selected to active (unlocked)
                                          for (var i = 0;
                                              i < selectedRow.length;
                                              i++)
                                            {
                                              await authproviderInstance
                                                  .updateUserStatus(
                                                      selectedRow[i]['uid'],
                                                      'aktiv'),
                                            },
                                        },
                                      userTable.selecteds.clear(),
                                      userTable.initializeData(),
                                    },
                                    icon: const Icon(
                                      IconData(0xe3b0,
                                          fontFamily: 'MaterialIcons'),
                                      color: Colors.black,
                                    ),
                                    label: const Text("Freischalten",
                                        style: TextStyle(color: Colors.black)),
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.grey),
                                      padding:
                                          MaterialStateProperty.all<EdgeInsets>(
                                              const EdgeInsets.all(10)),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          reponseScreenSizes: const [ScreenSize.xs],
                          actions: [
                            if (userTable.isSearch)
                              Expanded(
                                  child: TextField(
                                decoration: InputDecoration(
                                    hintText: 'Enter search term based on ' +
                                        userTable.searchKey!
                                            .replaceAll(
                                                RegExp('[\\W_]+'), ' ')
                                            .toUpperCase(),
                                    prefixIcon: IconButton(
                                        icon: const Icon(Icons.cancel),
                                        onPressed: () {
                                          setState(() {
                                            userTable.isSearch = false;
                                          });
                                          userTable.initializeData();
                                        }),
                                    suffixIcon: IconButton(
                                        icon: const Icon(Icons.search),
                                        onPressed: () {})),
                                onSubmitted: (value) {
                                  userTable.filterData(value);
                                },
                              )),
                            if (!userTable.isSearch)
                              IconButton(
                                  icon: const Icon(Icons.search),
                                  onPressed: () {
                                    setState(() {
                                      userTable.isSearch = true;
                                    });
                                  })
                          ],
                          headers: userTable.adminTableHeaders,
                          source: userTable.usersTableSource,
                          selecteds: userTable.selecteds,
                          showSelect: userTable.showSelect,
                          autoHeight: false,
                          onChangedRow: (value, header) {
                            /// print(value);
                            /// print(header);
                          },
                          onSubmittedRow: (value, header) {
                            /// print(value);
                            /// print(header);
                          },
                          onTabRow: (data) {
                            print(data);
                          },
                          onSort: userTable.onSort,
                          expanded: userTable.expanded,
                          sortAscending: userTable.sortAscending,
                          sortColumn: userTable.sortColumn,
                          isLoading: userTable.isLoading,
                          onSelect: userTable.onSelected,
                          onSelectAll: userTable.onSelectAll,
                          footers: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              child: const Text("Rows per page:"),
                            ),
                            if (userTable.perPages.isNotEmpty)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: DropdownButton<int>(
                                  value: userTable.currentPerPage,
                                  items: userTable.perPages
                                      .map((e) => DropdownMenuItem<int>(
                                            value: e,
                                            child: Text("$e"),
                                          ))
                                      .toList(),
                                  onChanged: userTable.onChanged,
                                  isExpanded: false,
                                ),
                              ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              child: Text(
                                  "${userTable.currentPage} - ${userTable.currentPerPage} of ${userTable.total}"),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.arrow_back_ios,
                                size: 16,
                              ),
                              onPressed: userTable.previous,
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                            ),
                            IconButton(
                              icon: const Icon(Icons.arrow_forward_ios, size: 16),
                              onPressed: userTable.next,
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                            )
                          ],
                        ),
                      ),
                    ),
                  ])))
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/403_error.png",
                  width: 350,
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Access denied\nZugriff verweigert\n',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          '\nDu hast nicht die nötigen Rechte, \num Zugriff zu dieser Seite zu erhalten',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
    ));
  }
}

// not in use
class _DropDownContainer extends StatelessWidget {
  final Map<String, dynamic> data;
  const _DropDownContainer({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> _children = data.entries.map<Widget>((entry) {
      Widget w = Row(
        children: [
          Text(entry.key.toString()),
          const Spacer(),
          Text(entry.value.toString()),
        ],
      );
      return w;
    }).toList();

    return Container(
      /// height: 100,
      child: Column(
        /// children: [
        ///   Expanded(
        ///       child: Container(
        ///     color: Colors.red,
        ///     height: 50,
        ///   )),

        /// ],
        children: _children,
      ),
    );
  }
}
