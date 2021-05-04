import 'package:flutter/material.dart';
import 'package:timetracker/model/Job.dart';

class JobList extends StatelessWidget {
  final job jobs;
  final VoidCallback onTap;

  const JobList({this.jobs, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(jobs.name),
      trailing: Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
