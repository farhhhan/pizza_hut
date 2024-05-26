import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_app/auth/bloc/auth_bloc.dart';
import 'package:pizza_app/bloc/pizzaadd_bloc.dart';
import 'package:pizza_app/cart_screen.dart';
import 'package:pizza_app/pizzalist/page.dart';
import 'package:pizza_app/profile_edit.dart';
import 'package:pizza_app/userBloc/bloc/user_bloc.dart';
import 'package:pizza_app/widgets/bottom_rounded_clipper.dart';
import 'package:pizza_app/widgets/order_button.dart';
import 'package:pizza_app/widgets/pizza_details.dart';
import 'package:pizza_app/widgets/pizza_size.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final PageController _titleSlideController = PageController();
  final PageController _imageSlideController = PageController(
    viewportFraction: 0.70,
  );
  final PageController _detailsSlideController = PageController();

  @override
  void initState() {
    super.initState();
    context.read<PizzaaddBloc>().add(GetPizzaEvent());
    context.read<UserBloc>().add(ProfileGetEvent());
    Future.delayed(const Duration(milliseconds: 100), () {
      _imageSlideController.animateToPage(1,
          duration: const Duration(milliseconds: 400), curve: Curves.linear);
    });
    _imageSlideController.addListener(() {
      _titleSlideController.jumpTo(_imageSlideController.offset * 0.148);
      _detailsSlideController.jumpTo(_imageSlideController.offset * 0.5621);
    });
  }

  @override
  void dispose() {
    _titleSlideController.dispose();
    _imageSlideController.dispose();
    _detailsSlideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is profileSuccesState) {
              return ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  UserAccountsDrawerHeader(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                    ),
                    accountName: Text(
                      state.user!.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                    accountEmail: Text(
                      state.user!.email,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    currentAccountPicture: CircleAvatar(
                      backgroundImage: NetworkImage(state.user!.profile),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text('Profile'),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ProfileEditScreen(user: state.user!)));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.home),
                    title: Text('Home'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.dashboard),
                    title: Text('Filter'),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FoodListPage(),
                          ));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Settings'),
                    onTap: () {
                      // Handle the onTap
                    },
                  ),
                ],
              );
            } else if (state is LoadingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Center(
                child: Text('Failed to load user profile'),
              );
            }
          },
        ),
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<PizzaaddBloc, PizzaaddState>(
          builder: (context, state) {
            if (state is PizzaGetSucces) {
              return Column(
                children: [
                  Stack(
                    children: [
                      ClipPath(
                        clipper: BottomRoundedClipper(),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 450,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      SafeArea(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    _scaffoldKey.currentState?.openDrawer();
                                  },
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Image.asset(
                                        "assets/images/menu.png",
                                        width: 32,
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: (){
                                        Navigator.push(context,MaterialPageRoute(builder: (context) => CartScreen()));
                                      },
                                      child: Stack(
                                        children: [
                                          CircleAvatar(
                                            maxRadius: 20,
                                            backgroundColor: Colors.black45,
                                          ),
                                          SizedBox(
                                            height: 40,
                                            child: Image.asset('assets/images/cars.png'))
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 20,),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 20),
                                      child: BlocBuilder<UserBloc, UserState>(
                                        builder: (context, state) {
                                          if (state is profileSuccesState) {
                                            return InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ProfileEditScreen(
                                                                user: state
                                                                    .user!)));
                                              },
                                              child: CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                    state.user!.profile),
                                                maxRadius: 25,
                                              ),
                                            );
                                          } else {
                                            return CircleAvatar(
                                              backgroundColor: Colors.grey,
                                              maxRadius: 25,
                                            );
                                          }
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: 45,
                              child: PageView.builder(
                                itemCount: state.pizzaList!.length,
                                controller: _titleSlideController,
                                scrollDirection: Axis.vertical,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Text(
                                    state.pizzaList![index].name,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontSize: 25,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              height: 320,
                              child: AnimatedBuilder(
                                animation: _imageSlideController,
                                builder: (context, child) {
                                  return PageView.builder(
                                    itemCount: state.pizzaList!.length,
                                    controller: _imageSlideController,
                                    onPageChanged: (page) {},
                                    itemBuilder: (context, index) {
                                      double value = 0.0;

                                      if (_imageSlideController
                                          .position.haveDimensions) {
                                        value = index.toDouble() -
                                            (_imageSlideController.page ?? 0);
                                        value = (value * 0.7).clamp(-1, 1);
                                      }

                                      return Align(
                                        alignment: Alignment.topCenter,
                                        child: Transform.translate(
                                          offset: Offset(
                                              0, 10 + (value.abs() * 40)),
                                          child: Transform.scale(
                                            scale: 1 - (value.abs() * 0.4),
                                            child: Transform.rotate(
                                              angle: value * 5,
                                              child: Image.network(
                                                state
                                                    .pizzaList![index].imageUrl,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: 310,
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AnimatedBuilder(
                            animation: _detailsSlideController,
                            builder: (context, child) {
                              return SizedBox(
                                height: 170,
                                child: PageView.builder(
                                  itemCount: state.pizzaList!.length,
                                  controller: _detailsSlideController,
                                  scrollDirection: Axis.vertical,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    double value = 0.0;

                                    if (_detailsSlideController
                                        .position.haveDimensions) {
                                      value = index.toDouble() -
                                          (_detailsSlideController.page ?? 0);
                                      value = (value * 0.9);
                                    }

                                    return Opacity(
                                      opacity: 1 - value.abs(),
                                      child: PizzaDetails(
                                        pizzaDetails: state.pizzaList![index],
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const PizzaSize(),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return Column(
                children: [
                  Stack(
                    children: [
                      ClipPath(
                        clipper: BottomRoundedClipper(),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 450,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      SafeArea(
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Image.asset(
                                  "assets/images/menu.png",
                                  width: 32,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: 45,
                              child: PageView.builder(
                                itemCount: 5,
                                controller: _titleSlideController,
                                scrollDirection: Axis.vertical,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Container(
                                    height: 10,
                                    width: 100,
                                    color: Colors.grey,
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              height: 320,
                              child: AnimatedBuilder(
                                animation: _imageSlideController,
                                builder: (context, child) {
                                  return PageView.builder(
                                    itemCount: 5,
                                    controller: _imageSlideController,
                                    onPageChanged: (page) {},
                                    itemBuilder: (context, index) {
                                      double value = 0.0;

                                      if (_imageSlideController
                                          .position.haveDimensions) {
                                        value = index.toDouble() -
                                            (_imageSlideController.page ?? 0);
                                        value = (value * 0.7).clamp(-1, 1);
                                      }

                                      return Align(
                                        alignment: Alignment.topCenter,
                                        child: Transform.translate(
                                          offset: Offset(
                                              0, 10 + (value.abs() * 40)),
                                          child: Transform.scale(
                                            scale: 1 - (value.abs() * 0.4),
                                            child: Transform.rotate(
                                              angle: value * 5,
                                              child: CircleAvatar(
                                                backgroundColor: Colors.black45,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AnimatedBuilder(
                            animation: _detailsSlideController,
                            builder: (context, child) {
                              return SizedBox(
                                height: 170,
                                child: PageView.builder(
                                  itemCount: 5,
                                  controller: _detailsSlideController,
                                  scrollDirection: Axis.vertical,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    double value = 0.0;

                                    if (_detailsSlideController
                                        .position.haveDimensions) {
                                      value = index.toDouble() -
                                          (_detailsSlideController.page ?? 0);
                                      value = (value * 0.9);
                                    }

                                    return Opacity(
                                      opacity: 1 - value.abs(),
                                      child: Container(
                                        color: Colors.grey,
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const PizzaSize(),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
      floatingActionButton: const OrderButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
