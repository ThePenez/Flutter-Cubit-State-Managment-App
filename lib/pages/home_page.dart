import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cubit/cubit/app_cubit_states.dart';
import 'package:flutter_cubit/cubit/app_cubits.dart';
import 'package:flutter_cubit/misc/colors.dart';
import 'package:flutter_cubit/widgets/app_large_text.dart';
import 'package:flutter_cubit/widgets/app_text.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class HomePage extends HookWidget {
  var images = {
    "balloning.png": "Balloning",
    "hiking.png": "Hiking",
    "kayaking.png": "Kayaking",
    "snorkling.png": "Snorkling"
  };

  @override
  Widget build(BuildContext context) {
    final tabController = useTabController(initialLength: 3);

    useEffect(() {
      tabController.addListener(() {
        debugPrint('Selected index: ${tabController.index}');
      });
    }, []);

    return Scaffold(
      body: BlocBuilder<AppCubits, CubitStates>(
        builder: (context, state) {
          if (state is LoadedState) {
            var info = state.places;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //MENU TEXT
                Container(
                  padding: const EdgeInsets.only(top: 50, left: 20),
                  child: Row(
                    children: [
                      const Icon(Icons.menu, size: 30, color: Colors.black54),
                      const Expanded(child: SizedBox()),
                      Container(
                        margin: const EdgeInsets.only(right: 20),
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.withOpacity(0.5),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                //DISCOVER TEXT
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: const AppLargeText(text: "Discover"),
                ),
                const SizedBox(height: 15),
                //TAB BAR
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TabBar(
                      labelPadding: const EdgeInsets.only(left: 20, right: 20),
                      controller: tabController,
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.grey,
                      isScrollable: true,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicator: CircleTabIndicator(
                          color: AppColors.mainColor, radius: 4),
                      tabs: const [
                        Tab(text: "Places"),
                        Tab(text: "Inspiration"),
                        Tab(text: "Emotions")
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                //TAB BAR VIEW
                Container(
                  padding: const EdgeInsets.only(left: 20),
                  height: 270,
                  width: double.maxFinite,
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      ListView.builder(
                        itemCount: info.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              BlocProvider.of<AppCubits>(context)
                                  .detailPage(info[index]);
                            },
                            child: Container(
                                margin:
                                    const EdgeInsets.only(right: 15, top: 10),
                                width: 200,
                                height: 300,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          "http://localhost:3000" +
                                              info[index].img),
                                      fit: BoxFit.cover,
                                    ))),
                          );
                        },
                      ),
                      const Text("There"),
                      const Text("Bye"),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                //EXPLORE MORE TEXT
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      AppLargeText(text: "Explore more", textSize: 22),
                      AppText(text: "See all", color: AppColors.textColor1),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  height: 120,
                  width: double.maxFinite,
                  margin: const EdgeInsets.only(left: 20),
                  child: ListView.builder(
                      itemCount: 4,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (_, index) {
                        return Container(
                          margin: const EdgeInsets.only(right: 30),
                          child: Column(
                            children: [
                              Container(
                                  //margin: const EdgeInsets.only(right: 50),
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white,
                                      image: DecorationImage(
                                        image: AssetImage("img/" +
                                            images.keys.elementAt(index)),
                                        fit: BoxFit.cover,
                                      ))),
                              SizedBox(height: 5),
                              Container(
                                child: AppText(
                                  text: images.values.elementAt(index),
                                  color: AppColors.textColor2,
                                ),
                              )
                            ],
                          ),
                        );
                      }),
                )
              ],
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class CircleTabIndicator extends Decoration {
  final Color color;
  double radius;

  CircleTabIndicator({required this.color, required this.radius});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CirclePainter(color: color, radius: radius);
  }
}

class _CirclePainter extends BoxPainter {
  final Color color;
  double radius;

  _CirclePainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    Paint _paint = Paint();
    _paint.color = color;
    _paint.isAntiAlias = true;

    final Offset circleOffset = Offset(
        configuration.size!.width / 2 - radius / 2,
        configuration.size!.height - radius);

    canvas.drawCircle(offset + circleOffset, radius, _paint);
  }
}
