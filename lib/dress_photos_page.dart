import 'package:flutter/material.dart';
import 'package:flutter_dress/bloc/BlocProvider.dart';
import 'package:flutter_dress/bloc/DressPhotoDirsBlocData.dart';
import 'package:flutter_dress/model/PhotoDir.dart';


final test = 'API rate limit exceeded for xxx.xxx.xxx.xxx. (But here\'s the good news: Authenticated requests get a higher rate limit. Check out the documentation for more details.)';

class DressPhotoDirsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final DressPhotoDirsBlocData bloc = BlocProvider.of<DressPhotoDirsBlocData>(context);
    return StreamBuilder<List<PhotoDir>>(
      stream: bloc.outPhotoDirs,
      initialData: [],
      builder: (BuildContext context, AsyncSnapshot<List<PhotoDir>> snapshot){
        final data = snapshot.data;
        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index){
            final photoDir = data[index];
            return new Text(
              photoDir.name
            );
          },
        );
      },
    );
  }
}

class DressPhotosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Container(
        padding: EdgeInsets.all(10.0),
        child: BlocProvider<DressPhotoDirsBlocData>(
          bloc: new DressPhotoDirsBlocData(),
          child: DressPhotoDirsPage(),
        )
      ),
    );
  }

  Widget _buildErrorMessage(){
    return new Row(
      children: <Widget>[
        new Padding(
          padding: EdgeInsets.only(
            right: 5.0
          ),
          child: new Icon(Icons.error_outline),
        ),
        new Expanded(
          flex: 1,
          child: new Text(
            test,
            style: new TextStyle(
              color: Colors.redAccent
            ),
          ),
        )
      ],
    );
  }
}