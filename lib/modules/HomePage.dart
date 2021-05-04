import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timetracker/layouts/addjob.dart';
import 'package:timetracker/layouts/listbuilder.dart';
import 'package:timetracker/layouts/listjob.dart';
import 'package:timetracker/model/Job.dart';
import 'package:timetracker/shared/network/remote/Auth.dart';
import 'package:timetracker/shared/network/remote/Database.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final doc = Provider.of<DataBase>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Jobs'),
        centerTitle: true,
        actions: <Widget>[
          // ignore: deprecated_member_use
          FlatButton(
              onPressed: () => _confirmSignOut(context),
              child: Text(
                'Logout',
                style: TextStyle(fontSize: 18.0, color: Colors.white),
              ))
        ],
      ),
      body: _buildContent(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () => EditJob.show(context),
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final database = Provider.of<DataBase>(context, listen: false);
    return StreamBuilder<List<job>>(
        stream: database.jobStream(),
        builder: (context, snapshot) {
          return ListBuilder<job>(
            snapshot: snapshot,
            itemWidgetBuilder: (context,job)=>Dismissible(
              key: Key('job-${job.idDocument}'),
              background:Container(color: Colors.red,) ,
              direction: DismissDirection.startToEnd,
              onDismissed: (direction)=>database.delete(job),

              child: JobList(
                jobs: job,
                onTap: () => EditJob.show(context, jobs: job),
              ),
            ),

          );
        });
  }
}



Future<void> _confirmSignOut(BuildContext context) async {
  final auth = Provider.of<AuthResult>(context, listen: false);

  final didRequestSignOut = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Logout'),
          content: Text('Are you sure that in logout'),
          actions: <Widget>[
            // ignore: deprecated_member_use
            FlatButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('OK'),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
            ),
            // ignore: deprecated_member_use
            FlatButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('cancel'),
            )
          ],
        );
      });
  if (didRequestSignOut == true) {
    auth.sign_out();
  }
}
