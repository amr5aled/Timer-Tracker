import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timetracker/model/Job.dart';
import 'package:timetracker/shared/network/remote/Database.dart';


class EditJob extends StatefulWidget {
  final DataBase dataBase;
  final job jobs;
  const EditJob({this.dataBase, this.jobs});
  static Future<void> show(BuildContext context,{job jobs}) {
    final database = Provider.of<DataBase>(context, listen: false);
    return Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => EditJob(dataBase: database,jobs: jobs,),
        fullscreenDialog: true));
  }

  @override
  _EditJobState createState() => _EditJobState();
}


class _EditJobState extends State<EditJob> {

  String name;
  int ratePerHour;

  @override
  void initState() {
    super.initState();
    if(widget.jobs!=null)
      {
        name=widget.jobs.name;
        ratePerHour=widget.jobs.rateperhour;
      }
  }

  final _formKey = GlobalKey<FormState>();
  bool _validateForm() {
    final _form = _formKey.currentState;
    if (_form.validate()) {
      _form.save();
      return true;
    }
    return false;
  }

  Future<void> _submit() async {
    if (_validateForm()) {
      try {
        final jobs = await widget.dataBase.jobStream().first;
        final allNames = jobs.map((e) => e.name).toList();
        if(widget.jobs!=null)
          {
            allNames.remove(widget.jobs.name);
          }
        if (allNames.contains(name)) {
          return showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title:Text('already name used') ,
                    content: Text('please enter difference name'),
                    actions: <Widget>[
                      // ignore: deprecated_member_use
                      FlatButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: Text('ok')),
                    ],
                  ));
        } else {
          String documentID()=>DateTime.now().toIso8601String();
          final id=widget.jobs?.idDocument??documentID();
          final _job = job(idDocument:id,name: name, rateperhour: ratePerHour);
          await widget.dataBase.createJob(_job);
          Navigator.of(context).pop(true);
        }
      } catch (e) {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: Text('some error occured'),
                ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.jobs==null?'New Job':'Edit Job'),
        elevation: 2.0,
        centerTitle: true,
        actions: <Widget>[
          // ignore: deprecated_member_use
          FlatButton(
              onPressed: _submit,
              child: Text(
                'save',
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ))
        ],
      ),
      backgroundColor: Colors.grey[200],
      body: _buildContent(),
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      // create box is scrollled//
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    initialValue: name,
                    decoration: InputDecoration(labelText: 'Job name'),
                    validator: (value) =>
                        value.isNotEmpty ? null : 'name can\'t empty',
                    onSaved: (value) => name = value,
                  ),
                  TextFormField(
                    initialValue: ratePerHour!=null?'$ratePerHour':null,
                    decoration: InputDecoration(labelText: 'RateperHour'),
                    keyboardType: TextInputType.numberWithOptions(
                        signed: false, decimal: false),
                    validator: (value) =>
                        value.isNotEmpty ? null : 'rateperhour can\'t empty',
                    onSaved: (value) => ratePerHour = int.tryParse(value) ?? 0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
