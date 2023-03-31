
import 'package:flutter/material.dart';
import 'package:sqlite_flutter/Page/FormPage.dart';

import '../../Modelo/PageDiary.dart';

class PageCard extends StatelessWidget {

  PageDiary page;
  VoidCallbackParam voidCallbackParam;

  PageCard(this.voidCallbackParam, this.page);


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onPressPage(context),
      child: Card(
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
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                      // mainAxisAlignment: MainAxisAlignment.end,
                      verticalDirection: VerticalDirection.up,
                      children: <Widget>[
                        Text(
                          page.date,
                          style: TextStyle(
                            fontSize: 11,
                          ),
                        ),
                        Icon(
                          Icons.access_time,
                          color: Colors.deepPurple,
                        ),
                      ],
                    )
                  ],
                )
            )
          ],
        ),
      ),
    );
  }


  onPressPage(context) {
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => FormPage(voidCallbackParam, page: page)
      )
    );
  }
}