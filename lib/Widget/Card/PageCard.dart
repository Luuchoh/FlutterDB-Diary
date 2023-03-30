
import 'package:flutter/material.dart';

import '../../Modelo/PageDiary.dart';

class PageCard extends StatelessWidget {

  PageDiary page;
  PageCard(this.page);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Row(
        children: <Widget>[
          Container(
            width: 100,
            height: 100,
            child: Icon(Icons.calendar_month_outlined),
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  page.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.access_time,
                      color: Colors.deepPurple,
                    ),
                    Text(
                      page.date,
                      style: TextStyle(
                        fontSize: 11,
                      ),
                    )
                  ],
                )
              ],
            )
          )
        ],
      ),
    );
  }

}