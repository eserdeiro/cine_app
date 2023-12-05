import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cine_app/config/constants/strings.dart';
import 'package:cine_app/config/helpers/formats.dart';
import 'package:cine_app/domain/entities/movie_entity.dart';


class ItemHorizontalListview extends StatefulWidget {
  final List<Movie> movies;
  final String?     title;
  final String?     subtitle;
  final VoidCallback? loadNextPage;

  const ItemHorizontalListview(
      {super.key,
      required this.movies,
      this.title,
      this.subtitle,
      this.loadNextPage});

  @override
  State<ItemHorizontalListview> createState() => _ItemHorizontalListviewState();
}

class _ItemHorizontalListviewState extends State<ItemHorizontalListview> {

  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    //When you reach the end, load more items (movies & tv shows)
    scrollController.addListener(() {
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
      height: 300,
      child: //ListView items
          ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: widget.movies.length,
              itemBuilder: (context, index) {
                return _Slide(movie: widget.movies[index]);
              }),
    );
  }
}

class _Slide extends StatelessWidget {
  final Movie movie;
  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
   
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: Container(
          color: const Color(0xff252836),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Image
              Stack(
                children: [
                   SizedBox(
                  width: 150,
                  height: 222,
                  child: Image.network(
                    movie.posterPath,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress != null) {
                        return const _SlideLoadingProgress();
                      } else {
                        //redirect from '/movie' to '/home/0/move/id' because movie is not recognized
                        return GestureDetector(
                          onTap: () => context.push('${Strings.movieRoute}${movie.id}'),
                          child: FadeIn(child: child));
                      }
                    },
                  ),
                ),
              //Vote average
              Positioned(
                right: 10,
                top: 10,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  child: Container(
                    color: const Color.fromRGBO(31, 29, 43, 50),
                    width: 50,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        children: [
                          const Icon(Icons.star, color: Color(0xfffd8701), size: 15),
                          const SizedBox(width: 2),
                          Text(Formats.number(movie.voteAverage , 1),
                              style: textStyle.bodyMedium
                                  ?.copyWith(color: const Color(0xfffd8701))),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                ),
              )
                ]
              ),
              const SizedBox(height: 5),
      
              //Item title
              SizedBox(
                  width: 150,
                  child:
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                          movie.title, 
                          maxLines: 1, 
                          style: const TextStyle(fontWeight: FontWeight.w600),
                          overflow: TextOverflow.ellipsis,),
                      )),
               
              //GenreID
              SizedBox(
                width: 150,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10, left: 5, right: 5, top: 5),
                  child: Text(movie.genreIds.toString(), maxLines: 1),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

//_SlideLoadingProgress
class _SlideLoadingProgress extends StatelessWidget {
  const _SlideLoadingProgress();
  @override
  Widget build(BuildContext context) {
    return FadeIn(
      child: Container(
          height: 222,
          color : Colors.black12,
          child : SpinPerfect(
              infinite: true,
              child: const Icon(Icons.refresh_outlined, size: 40))),
    );
  }
}
