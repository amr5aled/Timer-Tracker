import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timetracker/model/Job.dart';
import 'package:timetracker/model/JobApi.dart';


abstract class DataBase {
  Future<void> createJob(job job);// write
  Stream<List<job>> jobStream();//read
  Future<void> delete(job jobs);// delete//
}

class FireStoreData implements DataBase {
  final String uid;
  FireStoreData({@required this.uid});
  Future<void> setData({String path, Map<String, dynamic> data}) async { // write data//
    final reference = FirebaseFirestore.instance.doc(path);
    print('$path:$data');
    await reference.set(data);
  }


  @override
  Future<void> createJob(job job) async => await setData(
        path: ApiJob.job(uid, job.idDocument),
        data: job.toMap(),
      );
  Stream<List<job>> jobStream() {// read job//
    final reference = FirebaseFirestore.instance.collection(ApiJob.jobs(uid));
    final snapshots = reference.snapshots();
    return snapshots.map((snapshot) => snapshot.docs.map((snapshot) =>
          job.fromMap(snapshot.data(),snapshot.id) ).toList()
       );
    
  }
  @override
  Future<void> delete(job jobs) async {
    final reference = FirebaseFirestore.instance.doc(ApiJob.job(uid, jobs.idDocument),);
    await reference.delete();
    
    }

}
