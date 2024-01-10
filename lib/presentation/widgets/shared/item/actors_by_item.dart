import 'package:cine_app/domain/entities/actor_entity.dart';
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
    return GridView.builder(
      padding: EdgeInsets.zero,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2.5,
      ),
      itemCount: showAll ? actors.length : 4,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final actor = actors[index];
        return Container(
          padding: const EdgeInsets.all(8),
          child: Row(
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
                  padding: const EdgeInsets.symmetric(horizontal: 5),
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
                      const SizedBox(height: 5),

                      //Actor character, if null, show job.
                      Text(
                        (actor.character == null)
                            ? actor.job!
                            : actor.character!,
                        maxLines: 1,
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
          ),
        );
      },
    );
  }
}
