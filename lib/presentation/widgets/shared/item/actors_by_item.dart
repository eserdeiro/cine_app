import 'package:cine_app/config/helpers/orientation_helper.dart';
import 'package:cine_app/domain/entities/actor_entity.dart';
import 'package:cine_app/presentation/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ActorsByItem extends ConsumerWidget {
  final String itemId;
  final Map<String, List<ActorEntity>> actorsByItem;
  final bool showAll;
  const ActorsByItem({
    required this.itemId,
    required this.actorsByItem,
    required this.showAll,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    // if has no data, show circularprogress
    if (actorsByItem[itemId] == null) {
      return const SizedBox(
        height: 65,
        child: Center(child: CircularProgressIndicator(strokeWidth: 3)),
      );
    }

    final actors = actorsByItem[itemId]!;
    final actorsLength = actors.length;
    return GridView.builder(
      padding: EdgeInsets.zero,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 3,
      ),
      itemCount: showAll ? actorsLength : (actorsLength < 4 ? actorsLength : 4),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (_, index) {
        if (index < actorsLength) {
          final actor = actors[index];
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Actor photo
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.network(
                  actor.profilePath,
                  height: 50,
                  width: 50,
                  fit: BoxFit.cover,
                ),
              ),

              //Name
              const SizedBox(height: 5),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        actor.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 8),

                      //Actor character, if null, show job.
                      Text(
                        actor.character ?? actor.job!,
                        style: const TextStyle(
                          fontSize: 12,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
