import 'package:flutter/material.dart';
import 'package:flutter_application_3/resources/styles.dart';

class FeedPage extends StatefulWidget {
  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {

  Widget heroWidget() {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.all(16),
          child: SizedBox(
            width: 376,
            child: Image.asset('assets/merrel_maipo_waterpro.jpg'),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 16,
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Merrel Maipo Waterpro',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: PocStyles.HEADLINE_BLACK.copyWith(
                  shadows: [
                    Shadow(offset: Offset(-1.5, -1.5), color: Colors.white),
                    Shadow(offset: Offset(1.5, -1.5), color: Colors.white),
                    Shadow(offset: Offset(1.5, 1.5), color: Colors.white),
                    Shadow(offset: Offset(-1.5, 1.5), color: Colors.white),
                  ]
                ),
              ),
              Text('\$199,00',
                style: PocStyles.FIELD_INPUT,
              )
            ]
          ),
        )
      ],
    );
  }

  List<Widget> productGrid() {
    const products = [
      'assets/merrel_maipo_waterpro.jpg',
      'assets/merrel_maipo_waterpro.jpg',
      'assets/merrel_maipo_waterpro.jpg',
      'assets/merrel_maipo_waterpro.jpg'
    ];

    return products.map((e) => GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey[200],
              width: 1.5,
            ),
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              width: 139,
              height: 139,
              child: Image.asset(e)
            ),
            Text(
              'Merrel Maipo Waterpro',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: PocStyles.ACTION_LABEL_BLACK,
            ),
            Text(
              '\$199,00',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: PocStyles.ACTION_LABEL_BLACK,
            )
          ],
        ),
      ),
    )).toList();
  }

  @override
  Widget build(BuildContext context) {
    var mqDataScale = MediaQuery.of(context).textScaleFactor;

    return Container(
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate([
                heroWidget(),
                Container(
                  padding: EdgeInsets.only(left: 16, right: 16, top: 32, bottom: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Our Products', style: PocStyles.HEADLINE_2),
                      DropdownButton(
                        hint: Text('Popular'),
                        items: [
                          DropdownMenuItem(child: Text('Popular', style: PocStyles.LABEL_BLACK)),
                          DropdownMenuItem(child: Text('Terlaris', style: PocStyles.LABEL_BLACK)),
                          DropdownMenuItem(child: Text('Terbaru', style: PocStyles.LABEL_BLACK)),
                        ],
                        onChanged: (value) {},
                      )
                    ],
                  ),
                ),
              ])
            ),
            SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 0.9 - (0.1 * (mqDataScale.round() - 1)),
                crossAxisCount: 2
              ),
              delegate: SliverChildListDelegate(
                productGrid()
              ),
            )
          ],
        ),
      ),
    );
  }
}
