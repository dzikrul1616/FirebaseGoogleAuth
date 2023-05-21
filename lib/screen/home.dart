import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:loginbloc/auth/login.dart';
import 'package:loginbloc/crud/addcontent.dart';
import 'package:loginbloc/provider/auth_service.dart';
import 'package:loginbloc/provider/crud.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (BuildContext context) => AuthService(),
        child: Consumer<AuthService>(builder: (context, value, child) {
          return DefaultTabController(
            length: 3,
            child: Scaffold(
              floatingActionButton: FloatingActionButton(
                child: const Icon(Icons.add),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddContent()));
                },
              ),
              appBar: AppBar(
                title: const Text('Profile'),
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MenuBar(
                      children: <Widget>[
                        SubmenuButton(
                          menuChildren: <Widget>[
                            MenuItemButton(
                              onPressed: () {},
                              child: const MenuAcceleratorLabel('&Save'),
                            ),
                            MenuItemButton(
                              onPressed: () async {
                                value.signOut();
                              },
                              child: const MenuAcceleratorLabel('&Quit'),
                            ),
                            MenuItemButton(
                              onPressed: () {},
                              child: const MenuAcceleratorLabel('&About'),
                            ),
                          ],
                          child: const MenuAcceleratorLabel('&File'),
                        ),
                        SubmenuButton(
                          menuChildren: <Widget>[
                            MenuItemButton(
                              onPressed: () {},
                              child: const MenuAcceleratorLabel('&Magnify'),
                            ),
                            MenuItemButton(
                              onPressed: () {},
                              child: const MenuAcceleratorLabel('Mi&nify'),
                            ),
                          ],
                          child: const MenuAcceleratorLabel('&View'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('content')
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData) {
                          var listAllDocs = snapshot.data!.docs;

                          return StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('content')
                                .snapshots(),
                            builder: (context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasData) {
                                var listAllDocs = snapshot.data!.docs;

                                return GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 10.0,
                                    crossAxisSpacing: 10.0,
                                    mainAxisExtent: 200,
                                  ),
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) => Container(
                                    child: InkWell(
                                      onTap: () {},
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: Column(
                                          children: [
                                            ListTile(
                                              title: Text(
                                                snapshot.data!.docs[index]
                                                    ['title'],
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16,
                                                    overflow:
                                                        TextOverflow.ellipsis),
                                              ),
                                              subtitle: Text(
                                                snapshot.data!.docs[index]
                                                    ['description'],
                                                style: const TextStyle(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontSize: 14),
                                              ),
                                            ),
                                            // Padding(
                                            //   padding:
                                            //       const EdgeInsets.symmetric(
                                            //           horizontal: 5.0),
                                            //   child: ClipRRect(
                                            //     borderRadius: BorderRadius.only(
                                            //         topRight:
                                            //             Radius.circular(5),
                                            //         topLeft: Radius.circular(5),
                                            //         bottomLeft:
                                            //             Radius.circular(5),
                                            //         bottomRight:
                                            //             Radius.circular(5)),
                                            //     child: Image.network(
                                            //       snapshot.data!.docs[index]
                                            //           ['imageUrl'],
                                            //       height: 80,
                                            //       width: double.infinity,
                                            //       fit: BoxFit.cover,
                                            //     ),
                                            //   ),
                                            // ),
                                            Spacer(),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 15.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                      '${snapshot.data!.docs[index]['price']}'),
                                                  InkWell(
                                                    onTap: () {
                                                      value.showAlertDialog(
                                                          context,
                                                          snapshot.data!
                                                              .docs[index].id);
                                                    },
                                                    child: Icon(
                                                      Icons.delete,
                                                      color: Colors.black,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 20.0,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            },
                          );
                        } else {
                          return Container();
                        }
                      }),
                ),
              ),
            ),
          );
        }));
  }
}
