import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class ListSkeleton extends StatelessWidget {
  const ListSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 6,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(
            top: 15,
            bottom: 15,
          ),
          child: SkeletonItem(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    SkeletonAvatar(
                      style: SkeletonAvatarStyle(
                        width: 50,
                        height: 50,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SkeletonLine(
                      style: SkeletonLineStyle(
                        height: 5,
                        width: 250,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SkeletonLine(
                      style: SkeletonLineStyle(
                        height: 5,
                        width: 150,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SkeletonLine(
                      style: SkeletonLineStyle(
                        height: 5,
                        width: 200,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SkeletonLine(
                      style: SkeletonLineStyle(
                        height: 5,
                        width: 100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
