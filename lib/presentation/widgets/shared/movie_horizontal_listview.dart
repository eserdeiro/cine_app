import 'package:animate_do/animate_do.dart';
import 'package:cine_app/config/helpers/formats.dart';
import 'package:cine_app/domain/entities/movie_entity.dart';
import 'package:flutter/material.dart';

class MovieHorizontalListview extends StatefulWidget {
  final List<Movie> movies;
  final String?     title;
  final String?     subtitle;
  final VoidCallback? loadNextPage;

  const MovieHorizontalListview(
      {super.key,
      required this.movies,
      this.title,
      this.subtitle,
      this.loadNextPage});

  @override
  State<MovieHorizontalListview> createState() => _MovieHorizontalListviewState();
}

class _MovieHorizontalListviewState extends State<MovieHorizontalListview> {

  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    
    scrollController.addListener(() {
      //TODO
      if(widget.loadNextPage == null) return;

      if((scrollController.position.pixels + 200) >= scrollController.position.maxScrollExtent) {
        widget.loadNextPage!();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 360,
      child: Column(
        //Title & Date
        children: [
          if (widget.title != null || widget.subtitle != null)
            _Title(title: widget.title, subtitle: widget.subtitle),

          const SizedBox(height: 10),

          //ListView Movies
          Expanded(
              child: ListView.builder(
                  controller: scrollController,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: widget.movies.length,
                  itemBuilder: (context, index) {
                    return _Slide(movie: widget.movies[index]);
                  })),
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Movie movie;
  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Image
          SizedBox(
            width: 150,
            height: 222,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.network(
                  movie.posterPath,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress != null) {
                      return const _SlideLoadingProgress();
                    } else {
                      return FadeIn(child: child);
                    }
                  },
                )),
          ),
          const SizedBox(height: 5),
          //Movie title
          SizedBox(
              width: 150,
              child:
                  Text(movie.title, maxLines: 2, style: textStyle.titleSmall)),
          //Rating
          SizedBox(
            width: 150,
            child: Row(
              children: [
                Icon(Icons.star_half_outlined, color: Colors.yellow.shade800),
                const SizedBox(width: 2),
                //VoteAverage
                Text(Formats.number(movie.voteAverage, 1),
                    style: textStyle.bodyMedium
                        ?.copyWith(color: Colors.yellow.shade800)),
                const Spacer(),
                //Popularity
                Text(Formats.number(movie.popularity, 0),
                    style: textStyle.bodySmall)
              ],
            ),
          )
        ],
      ),
    );
  }
}
//_SlideLoadingProgress
class _SlideLoadingProgress extends StatelessWidget {
  const _SlideLoadingProgress();
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 222,
        color: Colors.black12,
        child: SpinPerfect(
            infinite: true,
            child: const Icon(Icons.refresh_outlined, size: 40)));
  }
}

//_Title
class _Title extends StatelessWidget {
  final String? title;
  final String? subtitle;

  const _Title({this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.only(top: 10),
      child: Row(children: [
        if (title != null) Text(title!, style: titleStyle),
        const Spacer(),
        if (subtitle != null)
          FilledButton.tonal(
              style:
                  const ButtonStyle(visualDensity: VisualDensity.comfortable),
              onPressed: () {},
              child: Text(subtitle!))
      ]),
    );
  }
}