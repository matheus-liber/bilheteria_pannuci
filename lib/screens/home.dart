import 'package:bilheteria_panucci/logic/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:bilheteria_panucci/components/home/genre_filter.dart';
import 'package:bilheteria_panucci/components/movie_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeCubit homeCubit = HomeCubit();

  @override
  void initState() {
    homeCubit.getMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: Text(
                  "Filmes",
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
              GenreFilter(homeCubit: homeCubit),
              BlocBuilder(
                bloc: homeCubit,
                builder: (context, state) {
                  if (state is HomeLoading) {
                    return SliverFillRemaining(child: Center(child: CircularProgressIndicator()));
                  } else if (state is HomeSuccess) {
                    if (state.movies.isEmpty) {
                      return SliverFillRemaining(child: Center(child: Text('Não há filmes desse gênero')));
                    }
                    return SliverGrid.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisExtent: 320,
                      ),
                      itemBuilder: (context, index) {
                        return MovieCard(movie: state.movies[index]);
                      },
                      itemCount: state.movies.length,
                    );
                  } else {
                    return SliverFillRemaining(child: Center(child: Text('Deu ruim')));
                  }
                },

              ),
            ],
          ),
        ),
      ),
    );
  }
}
