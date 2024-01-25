import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lettutor/models/Category.dart';
import 'package:lettutor/models/Level.dart';
import 'package:lettutor/presentation/pages/CoursesPage/BookTabView.dart';
import 'package:lettutor/presentation/pages/CoursesPage/CourseFilter.dart';
import 'package:lettutor/presentation/pages/CoursesPage/CourseTabView.dart';
import 'package:lettutor/presentation/widgets/MySearchBar/SearchBar.dart';
import 'package:lettutor/presentation/widgets/PageAppBar/PageAppBar.dart';
import 'package:lettutor/presentation/widgets/PageOverview/PageOverview.dart';
import 'package:lettutor/service/CourseService.dart';
import 'package:provider/provider.dart';

class CourseFormProvider extends ChangeNotifier {
  final courseForm = CourseSearchForm();

  void setSearchText(String searchText) {
    if (searchText.isEmpty) {
      courseForm.searchText = null;
    } else {
      courseForm.searchText = searchText;
    }
    notifyListeners();
  }

  void setLevels(List<Level> levels) {
    courseForm.levels = levels;
    notifyListeners();
  }

  void setCategories(List<Category> categories) {
    courseForm.categories = categories;
    notifyListeners();
  }

  void setIsAscending(bool? isAscending) {
    courseForm.isAscending = isAscending;
    notifyListeners();
  }
}

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
        child: ChangeNotifierProvider(
          create: (context) => CourseFormProvider(),
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
              child: TabBarView(
                // physics: NeverScrollableScrollPhysics(),
                children: [
                  SingleChildScrollView(
                      child: Consumer<CourseFormProvider>(
                    builder: (context, provider, child) => CourseTabView(
                      key: UniqueKey(),
                      form: provider.courseForm,
                    ),
                  )),
                  const SingleChildScrollView(child: BookTabView()),
                  const Text('Interactive E-Book'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
