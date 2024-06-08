import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodei_life/Provider/Filter_Provider.dart';
import 'package:foodei_life/constant/images.dart';
import 'package:foodei_life/theme/colors.dart';
import 'package:velocity_x/velocity_x.dart';

class newFilter extends ConsumerWidget {
  const newFilter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilter = ref.watch(filterProvider);
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize
            .min, // Make sure the bottom sheet is as tall as its content
        children: [
          // gluten - free
          ListTile(
            leading: CircleAvatar(
              child: Image(image: AssetImage(hGlutenImage)),
            ),
            title: SwitchListTile(
              contentPadding: EdgeInsets.only(right: 8),
              activeTrackColor: hyellow02,
              value: activeFilter[FilterMap.glutenFree]!,
              onChanged: (isChecked) {
                ref
                    .read(filterProvider.notifier)
                    .setFilter(FilterMap.glutenFree, isChecked);
              },
              title: Text(
                'Gluten-Free',
                style: TextStyle(fontSize: 20),
              ),
              subtitle: Text('Only Include gluten-free meals.',
                  style:
                      TextStyle(fontSize: 12, color: Vx.hexToColor("808080"))),
            ),
          ),

          // lactose free
          ListTile(
            leading: CircleAvatar(
              child: Image(image: AssetImage(hLactoseImage)),
            ),
            title: SwitchListTile(
              contentPadding: EdgeInsets.only(right: 8),
              activeTrackColor: hyellow02,
              value: activeFilter[FilterMap.lactoseFree]!,
              onChanged: (isChecked) {
                ref
                    .read(filterProvider.notifier)
                    .setFilter(FilterMap.lactoseFree, isChecked);
              },
              title: Text(
                'Lactose-Free',
                style: TextStyle(fontSize: 20),
              ),
              subtitle: Text('Only Include Lactose-free meals.',
                  style:
                      TextStyle(fontSize: 12, color: Vx.hexToColor("808080"))),
            ),
          ),

          // vegetarian
          ListTile(
            leading: CircleAvatar(
              child: Image(image: AssetImage(hVegImage)),
            ),
            title: SwitchListTile(
              contentPadding: EdgeInsets.only(right: 8),
              activeTrackColor: hyellow02,
              value: activeFilter[FilterMap.Veg]!,
              onChanged: (isChecked) {
                ref
                    .read(filterProvider.notifier)
                    .setFilter(FilterMap.Veg, isChecked);
              },
              title: Text(
                'Vegetarian',
                style: TextStyle(fontSize: 20),
              ),
              subtitle: Text('Only Include Veg meals.',
                  style:
                      TextStyle(fontSize: 12, color: Vx.hexToColor("808080"))),
            ),
          ),

          // vegan
          ListTile(
            leading: CircleAvatar(
              child: Image(image: AssetImage(hVeganImage)),
            ),
            title: SwitchListTile(
              contentPadding: EdgeInsets.only(right: 8),
              activeTrackColor: hyellow02,
              value: activeFilter[FilterMap.Vegan]!,
              onChanged: (isChecked) {
                ref
                    .read(filterProvider.notifier)
                    .setFilter(FilterMap.Vegan, isChecked);
              },
              title: Text(
                'Vegan',
                style: TextStyle(fontSize: 20),
              ),
              subtitle: Text(
                'Only Include Vegan meals.',
                style: TextStyle(fontSize: 12, color: Vx.hexToColor("808080")),
              ),
            ),
          ),
        ],
      ).p(25),
    );
  }
}
