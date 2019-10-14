import 'package:flutter/material.dart';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'dart:io';
import 'main.dart';
////////////////////////////////////////////////////////////////////////
///////////////////////LIST/////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////

class Item {
  Item({this.name, this.icon});
  Icon icon;
  String name;
}

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  int  id, listSize;
  bool isInit = true;
  var animatedList;

  _addItem() async{
    log.i('ANIMATED_LIST [add] ');
    await Firestore.instance.collection('incrementID').document('IDINC')
        .setData({'lastID':--id});
    await Firestore.instance.collection('satellites').document('SAT_$id')
        .setData({'name':'Satellite $id'});
    setState(() {
      listKey.currentState.insertItem(0,duration: const Duration(milliseconds: 200),);

      //sleep(const Duration(seconds:1));
    });
  }

  _removeItem(int index, DocumentSnapshot snapshot) async{
    log.i('ANIMATED_LIST [remove] ');
    Firestore.instance.runTransaction((Transaction transaction) async{
      await transaction.delete(snapshot.reference);
    });
    setState(() {

      listKey.currentState.removeItem(
        index,
            (context, animation) => buildItem(context, snapshot, 0, animation),
        duration: const Duration(milliseconds: 200),
      );
    });
  }

  Widget buildItem(
      BuildContext context, DocumentSnapshot document, int index, Animation<double> animation) {
    return SizeTransition(
      axis: Axis.vertical,
      sizeFactor: animation,
      child: SizedBox(
        child: ListTile(
          //trailing: item.icon,
          title: Text(document['name']),
          onTap: (){
            _removeItem(index, document);
          },
        ),
      ),
    );
  }

  getData() async {
    return await Firestore.instance.collection('incrementID').getDocuments();
  }
  @override
  Widget build(BuildContext context) {
      log.i('ANIMATED_LIST [build] ');
      getData().then((val) {
        id = int.parse(val.documents[0].data['lastID'].toString());
      });
      return Scaffold(
        body: Directionality(
            textDirection: TextDirection.ltr,
            child: StreamBuilder(
              stream: Firestore.instance.collection('satellites').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData ) return const Text('Loading...');
                listSize = snapshot.data.documents.length;
                animatedList = new AnimatedList(
                  key: listKey,
                  initialItemCount: listSize,
                  itemBuilder: (context, index, animation) {
                    return
                      buildItem(
                          context, snapshot.data.documents[index], index,
                          animation);
                  },
                );
                return animatedList;
              },
            )),
        floatingActionButton: FloatingActionButton(
          onPressed: _addItem,
          tooltip: 'Decrement',
          child: Icon(Icons.add),
        ),
      );
  }
}