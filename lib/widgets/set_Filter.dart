import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodei_life/constant/images.dart';
import 'package:foodei_life/theme/colors.dart';

import '../Provider/Filter_Provider.dart';

class Filter extends ConsumerWidget {
  const Filter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilter = ref.watch(filterProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Your Filters')),
      body: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              child: Image(image: AssetImage(hGlutenImage)),
            ),
            title: SwitchListTile(
              activeTrackColor: materialColor[300],
              value: activeFilter[FilterMap.glutenFree]!,
              onChanged: (isChecked) {
                ref
                    .read(filterProvider.notifier)
                    // you can also use Watch, but it craetes a unnecessary rebuilds
                    .setFilter(FilterMap.glutenFree, isChecked);
              },
              title: Text('Gluten-Free',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      )),
              subtitle: Text('Only Include gluten-free meals.',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      )),
            ),
          ),
          ListTile(
            leading: CircleAvatar(
              child: Image(image: AssetImage(hLactoseImage)),
            ),
            title: SwitchListTile(
              activeTrackColor: materialColor[300],
              value: activeFilter[FilterMap.lactoseFree]!,
              onChanged: (isChecked) {
                ref
                    .read(filterProvider.notifier)
                    .setFilter(FilterMap.lactoseFree, isChecked);
              },
              title: Text('Lactose-Free',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      )),
              subtitle: Text('Only Include Lactos-free meals.',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      )),
            ),
          ),
          ListTile(
            leading: CircleAvatar(
              child: Image(image: AssetImage(hVegImage)),
            ),
            title: SwitchListTile(
              activeTrackColor: materialColor[300],
              value: activeFilter[FilterMap.Veg]!,
              onChanged: (isChecked) {
                ref
                    .read(filterProvider.notifier)
                    .setFilter(FilterMap.Veg, isChecked);
              },
              title: Text('Vegetiran',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      )),
              subtitle: Text('Only Include Veg meals.',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      )),
            ),
          ),
          ListTile(
            leading: CircleAvatar(
              child: Image(image: AssetImage(hVeganImage)),
            ),
            title: SwitchListTile(
              activeTrackColor: materialColor[300],
              value: activeFilter[FilterMap.Vegan]!,
              onChanged: (isChecked) {
                ref
                    .read(filterProvider.notifier)
                    .setFilter(FilterMap.Vegan, isChecked);
              },
              title: Text('Vegan',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      )),
              subtitle: Text('Only Include Vegan meals.',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      )),
            ),
          )
        ],
      ),
    );
  }
}
