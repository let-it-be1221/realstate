import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:realstate/provider/house_provider.dart';
import 'package:realstate/provider/realtor_provider.dart';

class Notifications extends ConsumerStatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends ConsumerState<Notifications> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<String> docIds = [];

  Stream<QuerySnapshot> getNotificationsStream(String docId) {
    return _firestore
        .collection('mynotifications')
        .doc(docId)
        .collection('subject')
        .snapshots();
  }

  Future<List<String>> getDocumentIdsFromSellerCollection() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('seller').get();

    List<String> documentIds = [];

    for (var document in snapshot.docs) {
      documentIds.add(document.id);
    }

    setState(() {
      docIds = documentIds;
    });

    return documentIds;
  }

  @override
  void initState() {
    super.initState();
    getDocumentIdsFromSellerCollection();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: docIds.length,
        itemBuilder: (context, index) {
          String docId = docIds[index];

          return StreamBuilder<QuerySnapshot>(
            stream: getNotificationsStream(docId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              }

              // if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              //   return Center(
              //     child: Text('No data available'),
              //   );
              // }

              List<DocumentSnapshot> documents = snapshot.data!.docs;

              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: documents.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> data =
                      documents[index].data() as Map<String, dynamic>;

                  return Dismissible(
                    key:
                        Key(data['id']), // Use a unique identifier for the item
                    direction: DismissDirection.horizontal,
                    background: Container(
                      color: Colors.green,
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Icon(
                          Icons.approval_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    secondaryBackground: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    child: ListTile(
                      
                      title: Text(data['name'],style: TextStyle(fontWeight: FontWeight.bold),),
                      subtitle: Text("${data['name']} has a new post!!"),
                      leading: Image.network(data['profilePic']),
                      onTap: () {
                        // Handle the onTap event
                      },
                    ),
                    onDismissed: (direction) {
                      if (direction == DismissDirection.endToStart) {
                        // Delete the item
                        ref.watch(houseProvider).reject(data['id']);
                        setState(() {
                          documents.removeAt(index);
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('House deleted'),
                          ),
                        );
                      } else if (direction == DismissDirection.startToEnd) {
                        // Add the item
                        ref.watch(houseProvider).approve(data['id']);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('House Approved'),
                          ),
                        );
                      }
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
