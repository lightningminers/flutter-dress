import 'package:flutter/material.dart';

class AvatarCard extends StatelessWidget {
  final String avatar;
  final Widget rightWidget;

  AvatarCard(this.avatar, this.rightWidget);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
      padding: EdgeInsets.all(6.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            constraints: BoxConstraints.expand(height: 100.0, width: 100.0),
            margin: EdgeInsets.only(right: 6.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage(avatar),
            ),
          ),
          Expanded(
            child: rightWidget,
          )
        ],
      ),
    ));
  }
}
