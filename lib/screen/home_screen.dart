import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_desktop_poc/bloc/home_bloc.dart';
import 'package:flutter_desktop_poc/model/slide_model.dart';
import 'package:flutter_desktop_poc/widget/clock.dart';
import 'package:flutter_desktop_poc/widget/custom_slider.dart';
import 'package:flutter_desktop_poc/widget/promo_section.dart';
import 'package:flutter_desktop_poc/data/data.dart' as data;
import 'package:flutter_desktop_poc/widget/toggle_active_slider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<HomeBloc>(
        create: (context) => HomeBloc(countSliders: 30),
        dispose: (context, homeBloc) => homeBloc.dispose(),
        child: Consumer<HomeBloc>(
          builder: (context, homeBloc, child) {
            return RawKeyboardListener(
              focusNode: FocusNode(),
              autofocus: true,
              onKey: (value) {
                var data = value.data;
                // print(data.logicalKey.keyId);
                if (value is RawKeyUpEvent && data.logicalKey.keyId == 4295426130) {
                  homeBloc.setCurrentSlider(-1);
                }
                if (value is RawKeyUpEvent && data.logicalKey.keyId == 4295426129) {
                  homeBloc.setCurrentSlider(1);
                }
                // if (value is RawKeyDownEvent && data.logicalKey.keyId == 4295426130) {
                //   homeBloc.setCurrentSlider(-1);
                // }
                // if (value is RawKeyDownEvent && data.logicalKey.keyId == 4295426129) {
                //   homeBloc.setCurrentSlider(1);
                // }
              },
              child: Scaffold(
                backgroundColor: Theme.of(context).backgroundColor,
                body: CustomScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  // shrinkWrap: true,
                  controller: homeBloc.mainScrollCtrl,
                  slivers: [
                    SliverAppBar(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('TITLE'),
                          Clock(),
                        ],
                      ),
                      toolbarHeight: 50,
                      expandedHeight: 80,
                      pinned: true,
                      backgroundColor: Colors.black,
                    ),
                    SliverToBoxAdapter(
                      child: StreamBuilder(
                          stream: homeBloc.streamOpacity,
                          builder: (context, snapshotOpacity) {
                            return StreamBuilder(
                                stream: homeBloc.streamScale,
                                builder: (context, snapshotScale) {
                                  return PromoSection(
                                    opacity: snapshotOpacity.data ?? 1,
                                    scale: snapshotScale.data ?? 1,
                                    image: NetworkImage('http://lorempixel.com/1200/800'),
                                    title: 'Title promo',
                                    description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.',
                                  );
                                });
                          }),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: 32,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: StreamBuilder(
                          stream: homeBloc.streamCurrentSlider,
                          builder: (context, snapshot) {
                            return ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return CustomSlider(
                                  title: 'Slider $index',
                                  listSlides: [
                                    SlideModel(title: 'slide 1', image: NetworkImage('http://lorempixel.com/500/500')),
                                    SlideModel(title: 'slide 2', image: NetworkImage('http://lorempixel.com/500/500')),
                                    SlideModel(title: 'slide 3', image: NetworkImage('http://lorempixel.com/500/500')),
                                    SlideModel(title: 'slide 4', image: NetworkImage('http://lorempixel.com/500/500')),
                                    SlideModel(title: 'slide 5', image: NetworkImage('http://lorempixel.com/500/500')),
                                    SlideModel(title: 'slide 6', image: NetworkImage('http://lorempixel.com/500/500')),
                                    SlideModel(title: 'slide 7', image: NetworkImage('http://lorempixel.com/500/500')),
                                    SlideModel(title: 'slide 8', image: NetworkImage('http://lorempixel.com/500/500')),
                                    SlideModel(title: 'slide 9', image: NetworkImage('http://lorempixel.com/500/500')),
                                    SlideModel(title: 'slide 10', image: NetworkImage('http://lorempixel.com/500/500')),
                                    SlideModel(title: 'slide 11', image: NetworkImage('http://lorempixel.com/500/500')),
                                    SlideModel(title: 'slide 12', image: NetworkImage('http://lorempixel.com/500/500')),
                                    SlideModel(title: 'slide 13', image: NetworkImage('http://lorempixel.com/500/500')),
                                    SlideModel(title: 'slide 14', image: NetworkImage('http://lorempixel.com/500/500')),
                                    SlideModel(title: 'slide 15', image: NetworkImage('http://lorempixel.com/500/500')),
                                  ],
                                  active: snapshot.data == index,
                                );
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  height: 16,
                                );
                              },
                              itemCount: 30,
                            );
                          }),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: 32,
                      ),
                    ),
                    // SliverToBoxAdapter(
                    //   child: Center(
                    //     child: RaisedButton(
                    //       color: Colors.grey,
                    //       child: Text(
                    //         'Back to top',
                    //         style: Theme.of(context).textTheme.bodyText1,
                    //       ),
                    //       onPressed: () {
                    //         homeBloc.backToTop();
                    //       },
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
