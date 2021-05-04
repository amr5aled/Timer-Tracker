import 'package:flutter/material.dart';
import 'file:///E:/flutter/timetracker/lib/layouts/EmptyJob.dart';

typedef ItemWidgetBuilder<T> = Widget Function(BuildContext context, T item);

class ListBuilder<T> extends StatelessWidget {
  const ListBuilder({Key key, this.snapshot, this.itemWidgetBuilder})
      : super(key: key);
  final AsyncSnapshot snapshot;
  final ItemWidgetBuilder<T> itemWidgetBuilder;

  @override
  Widget build(BuildContext context) {
    if (snapshot.hasData) {
      final List<T> items = snapshot.data;
      if (items.isNotEmpty) {
      return  _buildList(items);

      } else {
        return EmptyJob();
      }
    } else if (snapshot.hasError) {
      return EmptyJob(
        title: 'something went wrong',
        message: 'can \'t load items',
      );
    }
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildList(List<T> items) {
    return ListView.separated(
      itemCount: items.length+2 ,
        separatorBuilder: (context,index)=>Divider(height: 0.5,),
        itemBuilder: (context,index) {
        if(index==0|| index==items.length+1)
          {
            return Container();
          }
      return  itemWidgetBuilder(context,items[index-1]);

        }


    );
  }
}
