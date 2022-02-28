import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cubit/cubit/app_cubits.dart';
import 'package:flutter_cubit/misc/colors.dart';
import 'package:flutter_cubit/widgets/app_buttons.dart';
import 'package:flutter_cubit/widgets/app_large_text.dart';
import 'package:flutter_cubit/widgets/app_text.dart';
import 'package:flutter_cubit/widgets/responsive_button.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int gottenStars = 4;
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Stack(
          children: [
            Positioned(
                left: 0,
                right: 0,
                child: Container(
                  width: double.maxFinite,
                  height: 350,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("img/mountain.jpeg"),
                        fit: BoxFit.cover),
                  ),
                )),
            Positioned(
                left: 20,
                top: 40,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        BlocProvider.of<AppCubits>(context).goHome();
                      },
                      icon: const Icon(Icons.menu),
                      color: Colors.white,
                    ),
                  ],
                )),
            Positioned(
                top: 200,
                child: Container(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 30),
                    width: MediaQuery.of(context).size.width,
                    height: 500,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            topLeft: Radius.circular(30))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // NAME AND PRICE
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppLargeText(
                                text: "Yosemite",
                                color: Colors.black.withOpacity(0.8)),
                            const AppLargeText(
                              text: "\$ 250",
                              color: AppColors.mainColor,
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        // LOCATION
                        Row(
                          children: const [
                            Icon(Icons.location_on, color: AppColors.mainColor),
                            SizedBox(width: 5),
                            AppText(
                              text: "USA, California",
                              color: AppColors.textColor1,
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        // STARS
                        Row(
                          children: [
                            Wrap(
                              children: List.generate(5, (index) {
                                return Icon(Icons.star,
                                    color: index < gottenStars
                                        ? AppColors.starColor
                                        : AppColors.textColor2);
                              }),
                            ),
                            const SizedBox(width: 10),
                            const AppText(
                                text: "(4.0)", color: AppColors.textColor2)
                          ],
                        ),
                        const SizedBox(height: 25),
                        // NUMBER OF PEOPLE
                        AppLargeText(
                          text: "People",
                          textSize: 20,
                          color: Colors.black.withOpacity(0.8),
                        ),
                        const SizedBox(height: 5),
                        AppText(
                            text: "Number of people in your group",
                            color: AppColors.mainTextColor),
                        const SizedBox(height: 10),
                        // NUM OF PEOPLE BUTTONS
                        Wrap(
                            children: List.generate(5, (index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 10),
                              child: AppButton(
                                color: selectedIndex == index
                                    ? Colors.white
                                    : Colors.black,
                                backgroundColor: selectedIndex == index
                                    ? Colors.black
                                    : AppColors.buttonBackground,
                                size: 50,
                                borderColor: selectedIndex == index
                                    ? Colors.black
                                    : AppColors.buttonBackground,
                                text: (index + 1).toString(),
                              ),
                            ),
                          );
                        })),
                        const SizedBox(height: 20),
                        // DESCRIPTION
                        AppLargeText(
                            text: "Description",
                            color: Colors.black.withOpacity(0.8),
                            textSize: 20),
                        const SizedBox(height: 10),
                        AppText(
                          text:
                              "Yosemite National Park is located in central Sierra Nevada in the US state of California. It is located near the wild protected areas",
                          color: AppColors.mainTextColor,
                        ),
                      ],
                    ))),
            Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: Row(
                  children: [
                    AppButton(
                        color: AppColors.textColor2,
                        backgroundColor: Colors.white,
                        size: 60,
                        borderColor: AppColors.textColor2,
                        isIcon: true,
                        icon: Icons.favorite_border),
                    const SizedBox(width: 20),
                    ResponsiveButton(isResponsive: true)
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
