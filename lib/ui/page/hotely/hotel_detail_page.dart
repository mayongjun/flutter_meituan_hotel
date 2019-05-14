import 'package:flutter/material.dart';
import 'package:hotel/common/tu_chong_repository.dart';
import 'package:hotel/common/tu_chong_source.dart';
import 'package:hotel/ui/page/first/customtilebar.dart';
import 'package:hotel/ui/widget/stack_appbar/hotel_appbar.dart';
import '../../widget/MyDivider.dart';
import '../../widget/loading_more/loading_more_list.dart';
import 'hotel_item.dart';
import '../order/room_order_item.dart';

class HotelDetailPage extends StatefulWidget{

  final String hotel_name;
  final String hotel_location;

  HotelDetailPage({
    this.hotel_location,
    this.hotel_name,
  });

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HotelDetailPageState();
  }
}

class _HotelDetailPageState extends State<HotelDetailPage>{

  TuChongRepository listSourceRepository;
  ScrollController _scrollcontroller = ScrollController();
  HotelBarController _hotelbarcontroller = new HotelBarController();
  bool _isNeedSetAlpha = false;
  GlobalKey<HotelAppBarState>_mTitleKey = new GlobalKey();
  List<String> list = ['1','2','3'];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _hotelbarcontroller.value.alpha = 0;

    _scrollcontroller.addListener(() {

      if ( _scrollcontroller.offset < 80.0) {
        _isNeedSetAlpha = true;
        _hotelbarcontroller.value.alpha = ((_scrollcontroller.offset / 80) * 255).toInt();
        _mTitleKey.currentState.setState(() {});
      } else {
        if (_isNeedSetAlpha) {
          _hotelbarcontroller.value.alpha = 255;
          _mTitleKey.currentState.setState(() {});
          _isNeedSetAlpha = false;
        }
      }
    });
    listSourceRepository = new TuChongRepository();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: _mainpage(),
    );
  }
  _mainpage(){

    final _media = MediaQuery.of(context).size;

    return  Stack(
        children: <Widget>[
          new Container(
            height: _media.height,
            child: LoadingMoreCustomScrollView(
              showGlowLeading: false,
              controller: _scrollcontroller,
              slivers: <Widget>[
                SliverToBoxAdapter(
                  child: Column(
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Container(
                            height: 300,
                            width: _media.width,
                            child: Image.network(
                              'https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=1211820406,3634865743&fm=26&gp=0.jpg',
                              fit: BoxFit.fill,
                            ),
                          ),
                          Container(
                            height: 50,
                            width: 180,
                            margin: EdgeInsets.only(top: 200,left: 30),
                            decoration: BoxDecoration(
                                color: Colors.black54,
                                borderRadius: BorderRadius.all(Radius.circular(5.0))
                            ),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(left: 5),
                                  child: Text(
                                    '5.0',
                                    style: TextStyle(
                                        color: Colors.orangeAccent,
                                        fontSize: 30,
                                        fontWeight: FontWeight.w700
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: 300,
                            margin: EdgeInsets.only(top: 280),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0),topRight: Radius.circular(15.0))
                            ),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    'qweqwe',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 30
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    'qweqwe',
                                    softWrap: true,
                                  ),
                                ),
                                Container(
                                  child: Text(
                                      'qweqwe'
                                  ),
                                ),
                                Container(
                                  child: Text(
                                      'qweqwe'
                                  ),
                                ),
                                MyDivider(height: 0,width: 0.5,),

                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SliverList(
                    delegate: SliverChildBuilderDelegate(
                        (context,int index){
                          return RoomItem();
                        },
                        childCount: 2
                    ),
                )
//                LoadingMoreSliverList(
//                    SliverListConfig<TuChongItem>(
//                      itemBuilder:  itemBuilder,
//                      sourceList: listSourceRepository,
//                      //isLastOne: false
//                    )
//                ),
              ],
            ),
          ),
          HotelAppBar(
            height: 80.0,
            controller: _hotelbarcontroller,
            key: _mTitleKey,
          )
        ]
    );
  }
  Widget itemBuilder(BuildContext context,TuChongItem item, int index) => HotelItem();
}