//import 'package:flutter_multi_carousel/carousel.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:live/Helper/binding.dart';
import 'package:live/core/view_model/category_viewmodel.dart';
import 'package:live/core/view_model/home_viewmodel.dart';
import 'package:live/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:live/core/view_model/post_viewmodel.dart';
import 'package:live/model/category.dart';
import 'package:live/view/ControlView.dart';
import 'package:live/view/posts_of_category.dart';
import 'package:live/view/widgets/cachedimage.dart';
import 'package:live/view/widgets/circular_progress.dart';
import 'package:live/view/widgets/customtext.dart';
import 'package:live/view/widgets/noconnection.dart';
import 'details_post.dart';
import 'package:live/model/staticdata.dart';
import 'package:live/core/view_model/checkconnection.dart';
import 'package:http/http.dart' as http;

class home_view extends StatefulWidget {
  @override
  _home_viewState createState() => _home_viewState();
}

class _home_viewState extends State<home_view> {
  categoryviewmodel categoryobj = new categoryviewmodel();
  ScrollController _scrollController =
  ScrollController(initialScrollOffset: 0.0);
  PageController scrollController = PageController();
  TextEditingController searchcontroller = new TextEditingController();
  final GetXNetworkManager _networkManager = Get.find<GetXNetworkManager>();

  bool issearching = false;
  List  searchitems = [];

  double offset = 0.0;

  List<Post> categories = []; //List<Post>();

  List<Widget> listofimages = [];

  @override
  void initState() {
    super.initState();

    for (var id in staticdata.ids) {
      if (id != 0) {
        categoryobj.getcategory(id, http.Client()).then((value) => {
          if (!categories.contains(value))
            {
              if (this.mounted)
                {
                  setState(() {
                    categories += value;
                  }),
                }
            }
        });
      }
      print(categories.length);
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(50.0);
      }
    });
    Binding().dependencies();

    searchcontroller.addListener(() {
      filtercategory();
    });
  }

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
        length: 1,
        child: GetBuilder<HomeViewModel>(
            init: HomeViewModel(),
            builder: (controler) => Scaffold(
                appBar: AppBar(
                    backgroundColor: kSecondaryGreyColor,
                    actions: [
                      Padding(
                          padding: EdgeInsets.only(right: 10.w),
                          child: IconButton(
                            icon: Icon(Icons.menu, color: primarycolor),
                            onPressed: () {
                              controler.changeselectedvalue(2);
                              Get.to(Controllview());
                            },
                            iconSize: 30,
                          )),
                    ],
                    title: Row(children: [
                      issearching
                          ? new IconButton(
                        onPressed: () {
                          searchcontroller.clear();
                          setState(() {
                            this.issearching = false;
                          });
                          searchitems.clear();
                        },
                        icon: Icon(
                          Icons.cancel,
                          color: Colors.black,
                        ),
                      )
                          : new IconButton(
                        onPressed: () {
                          setState(() {
                            searchcontroller.clear();
                            this.issearching = true;
                          });
                        },
                        icon: Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        iconSize: 30,
                      ),
                      !issearching
                          ? Padding(
                        padding: EdgeInsets.only(left: 60.w),
                        child: Center(
                          child: Image.asset(
                            "assets/images/logo (1).png",
                            width: 130.w,
                            height: 130.h,
                          ),
                        ),
                      )
                          : Container(
                          height: 20.h,
                          width: 250.w,
                          child: TextField(
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                                hintText: "بحث",
                                hintStyle: TextStyle(color: Colors.black)),
                            controller: searchcontroller,
                          )),
                    ])),
                body: GetBuilder<GetXNetworkManager>(
                    builder: (builder) => _networkManager.connectionType == 1
                        ? Directionality(
                        textDirection: TextDirection.rtl,
                        child: issearching
                            ? Container(
                            height: 900, child: searchgridview())
                            : GetBuilder<postviewmodel>(
                            init: postviewmodel(),
                            builder: (controler1) => FutureBuilder(
                                future:
                                controler1.getposts(http.Client()),
                                builder:
                                    (context, AsyncSnapshot snapshot) {
                                  if (snapshot.hasData) {
                                    for (var item in snapshot.data) {
                                      if (listofimages.length <=
                                          snapshot.data.length) {
                                        if (item.attachments.length !=
                                            0) {
                                          listofimages.add(
                                              SingleChildScrollView(
                                                  scrollDirection:
                                                  Axis.vertical,
                                                  controller:
                                                  _scrollController,
                                                  physics:
                                                  NeverScrollableScrollPhysics(),
                                                  child: Container(
                                                      height: 280,
                                                      child: Flex(
                                                        direction: Axis
                                                            .vertical,
                                                        children: [
                                                          Expanded(
                                                              flex: 3,
                                                              child:
                                                              GestureDetector(
                                                                child:
                                                                cachedimage(
                                                                  url: item
                                                                      .attachments[0]
                                                                      .url,
                                                                ),
                                                                onTap:
                                                                    () {
                                                                  Get.to(
                                                                      details_post(),
                                                                      arguments: item);
                                                                },
                                                              )),
                                                          Expanded(
                                                              flex: 1,
                                                              child: Padding(
                                                                  padding: EdgeInsets.only(top: 10),
                                                                  child: Center(
                                                                    child:
                                                                    customtext(
                                                                      text: '${item.title}',
                                                                      height: 1.5,
                                                                      fontSize: 16,
                                                                    ),
                                                                  )))
                                                        ],
                                                      ))));
                                        }
                                      }
                                    }
                                    return SingleChildScrollView(
                                        child: ListView(
                                            shrinkWrap: true,
                                            controller:
                                            _scrollController,
                                            scrollDirection:
                                            Axis.vertical,
                                            physics:
                                            BouncingScrollPhysics(),
                                            children: [
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                              Center(
                                                  child:Container(
                                                      height: 285,
                                                      child:PageView.builder(
                                                          controller: scrollController,
                                                          scrollDirection: Axis.horizontal,
                                                          itemBuilder: (context, i) => SingleChildScrollView( scrollDirection:
                                                          Axis.vertical,child:CarouselSlider(
                                                              items: listofimages,
                                                              options: CarouselOptions(
                                                                height: 285.h,

                                                                aspectRatio: 16/9,
                                                                viewportFraction: 0.8,
                                                                initialPage: 0,
                                                                enableInfiniteScroll: true,
                                                                reverse: false,
                                                                autoPlay: true,
                                                                autoPlayInterval: Duration(seconds: 3),
                                                                autoPlayAnimationDuration: Duration(milliseconds: 800),
                                                                autoPlayCurve: Curves.fastOutSlowIn,
                                                                enlargeCenterPage: true,
                                                                enlargeFactor: 0.3,
                                                                onPageChanged:(index, reason) {
                                                          if (index ==
                                                          listofimages.length -
                                                          1) {
                                                          scrollController
                                                              .jumpToPage(
                                                          0);
                                                          }
                                                          },
                                                                scrollDirection: Axis.horizontal,
                                                              )
                                                             // height: 285.h,
                                                              //width: 330.w,
                                                              //initialPage: 0,
                                                              //allowWrap: true,
                                                              //showIndicator: false,
                                                              //type: Types.simple,
                                                             /* onPageChange: (index, reason) {
                                                                if (index ==
                                                                    listofimages.length -
                                                                        1) {
                                                                  scrollController
                                                                      .jumpToPage(
                                                                      0);
                                                                }
                                                              },
                                                              indicatorType:  IndicatorTypes.dot,
                                                              axis: Axis.horizontal,
                                                              showArrow: true,
                                                              children: listofimages*/))))),
                                              SizedBox(height: 20),
                                              Container(
                                                  height: 2765.h,
                                                  child: ListView.builder(
                                                      shrinkWrap: true,
                                                      physics:
                                                      NeverScrollableScrollPhysics(),
                                                      itemCount: staticdata
                                                          .homeids.length,
                                                      itemBuilder:
                                                          (BuildContextcontext,
                                                          index) {
                                                        return new Container(
                                                            height: index !=
                                                                0 &&
                                                                index !=
                                                                    4
                                                                ? 269.h
                                                                : 450.h,
                                                            child: ListView(
                                                                shrinkWrap:
                                                                true,
                                                                physics:
                                                                NeverScrollableScrollPhysics(),
                                                                children: [
                                                                  SizedBox(
                                                                      height:
                                                                      10.h),
                                                                  section_listview(
                                                                      staticdata
                                                                          .homenames[index],
                                                                      index),
                                                                  GetBuilder<
                                                                      categoryviewmodel>(
                                                                      init:
                                                                      categoryviewmodel(),
                                                                      builder: (controler) => FutureBuilder(
                                                                          future: controler.getcategory(staticdata.homeids[index], http.Client()),
                                                                          builder: (context, AsyncSnapshot snapshot2) {
                                                                            if (snapshot2.hasData) {
                                                                              return Container(
                                                                                padding: EdgeInsets.only(right: 3.w, top: 15.h, bottom: 5.h),
                                                                                height: index != 0 && index != 4 ? 230.h : 430.h,
                                                                                child: index != 0 && index != 4
                                                                                    ? ListView.builder(
                                                                                    itemCount: index != 0 && index != 4 ? snapshot2.data.length : 4,
                                                                                    scrollDirection: Axis.horizontal,
                                                                                    itemBuilder: (BuildContext context, i) {
                                                                                      return category_listview(i, snapshot2.data);
                                                                                    })
                                                                                    : GridView.builder(
                                                                                  // to disable GridView's scrolling
                                                                                    physics: ScrollPhysics(), // to disable GridView's scrolling
                                                                                    shrinkWrap: true,
                                                                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                                                                                    itemCount: 4,
                                                                                    itemBuilder: (BuildContext context, i) {
                                                                                      return Padding(padding: EdgeInsets.only(right: 1.w, left: 1.w), child: category_listview(i, snapshot2.data));
                                                                                    }),
                                                                              );
                                                                            } else {
                                                                              return circular_progress();
                                                                            }
                                                                          }))
                                                                ]));
                                                      }))
                                            ]));
                                  } else {
                                    return Center(
                                      child: Image.asset(
                                          'assets/images/logo (1).png'),
                                    );
                                  }
                                })))
                        : noconnection()))));
  }

  section_listview(
      String name,
      int i,
      ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(right: 15.w),
          child: customtext(
              text: name,
              color: primarycolor,
              fontSize: 17,
              fontweight: FontWeight.bold),
        ),
        GestureDetector(
            onTap: () {
              Get.to(postofcategory(
                indexofdata: i,
              ));
            },
            child: Padding(
              padding: EdgeInsets.only(left: 10.w),
              child: customtext(
                  text: 'عرض الكل', fontSize: 17, fontweight: FontWeight.bold),
            )),
      ],
    );
  }

  category_listview(int i, List data) {
    if (data[i].attachments.length != 0) {
      return GestureDetector(
        child: Column(children: [
          cachedimage(
              url: data[i].attachments[0].images["small-wide-hd"].url,
              width: 100,
              height: 100),
          Container(
            padding: EdgeInsets.only(right: 23.w, top: 13.h),
            height: 65.h,
            width: 200.w,
            child: Text(
              data[i].title.replaceAll(new RegExp("[0-9&:#;.]"), ''),
              style: TextStyle(
                fontSize: 15,
              ),
              maxLines: 2,
            ),
          ),
        ]),
        onTap: () {
          Get.to(details_post(), arguments: data[i]);
        },
      );
    } else {
      return SizedBox(
        width: 0,
        height: 0,
      );
    }
  }

  searchgridview() {
    return GridView.builder(
        physics: ScrollPhysics(),
        // to disable GridView's scrolling
        shrinkWrap: true,
        gridDelegate:
        SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: searchitems.length,
        itemBuilder: (BuildContext context, index) {
          if (searchitems[index].attachments.length != 0) {
            return Padding(
              padding: EdgeInsets.only(top: 7.h, right: 10.w),
              child: GestureDetector(
                onTap: () {
                  Get.to(details_post(), arguments: searchitems[index]);
                },
                child: Column(children: [
                  Expanded(
                      child: cachedimage(
                          url: searchitems[index].attachments[0].url,
                          width: 50,
                          height: 50)),
                  Container(
                    padding: EdgeInsets.only(top: 5.h, bottom: 1.h),
                    height: 63.w,
                    width: 200.w,
                    child: customtext(
                      text: searchitems[index].title,
                      fontSize: 15,
                      maxLine: 2,
                    ),
                  ),
                ]),
              ),
            );
          } else {
            return SizedBox(
              width: 0,
              height: 0,
            );
          }
        });
  }

  filtercategory() {
    List filteredcategory = [];
    if (searchcontroller.text.isNotEmpty) {
      searchitems.removeRange(0, searchitems.length);
      filteredcategory = categories
          .where((item) => item.title!.contains(searchcontroller.text))
          .toList();
      setState(() {
        searchitems = filteredcategory;

      });
    }
  }
}
