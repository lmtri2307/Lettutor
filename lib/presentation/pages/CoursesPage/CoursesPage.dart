import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lettutor/presentation/pages/CoursesPage/BookTabView.dart';
import 'package:lettutor/presentation/pages/CoursesPage/CourseFilter.dart';
import 'package:lettutor/presentation/pages/CoursesPage/CourseTabView.dart';
import 'package:lettutor/presentation/widgets/MySearchBar/SearchBar.dart';
import 'package:lettutor/presentation/widgets/PageAppBar/PageAppBar.dart';
import 'package:lettutor/presentation/widgets/PageOverview/PageOverview.dart';

class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PageAppBar(
        type: AppBarType.main,
        title: "Courses",
      ),
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverList(
                delegate: SliverChildListDelegate([
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 35),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    PageOverview(
                      image: SvgPicture.asset("assets/images/course.svg"),
                      title: "Discover Courses",
                      overview:
                          "LiveTutor has built the most quality, methodical and scientific courses in the fields of life for those who are in need of improving their knowledge of the fields.",
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            MySearchBar(
                              hintText: "Search Courses",
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            CourseFilter(),
                            SizedBox(
                              height: 10,
                            ),
                            TabBar(
                              tabAlignment: TabAlignment.start,
                              isScrollable: true,
                              tabs: [
                                Tab(text: 'Course'),
                                Tab(text: 'E-Book'),
                                Tab(text: 'Interactive E-Book'),
                              ],
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            ]))
          ],
          // physics: NeverScrollableScrollPhysics(),
          body: ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: const TabBarView(
              // physics: NeverScrollableScrollPhysics(),
              children: [
                SingleChildScrollView(child: CourseTabView()),
                SingleChildScrollView(
                    child: BookTabView(
                )),
                Text('Interactive E-Book'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
