import 'package:flutter/material.dart';
import 'package:juno/heatmap/flutter_heatmap_calendar.dart';
// import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:juno/models/text_widgets.dart';

class HabitPage extends StatelessWidget {
  const HabitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 8,
      padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
      itemBuilder: (context, index) {
        return const MyTile();
      },
    );
  }
}

class MyTile extends StatelessWidget {
  const MyTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
      child: AspectRatio(
        aspectRatio: 1.5 / 1,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.grey[500],
          ),
          child: Column(
            children: [
              InfoBar(),
              MyHeatMap(),
            ],
          ),
        ),
      ),
    );
  }
}

class InfoBar extends StatelessWidget {
  const InfoBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconContainer(
              icon: Icon(Icons.monitor_heart_rounded),
              onTap: () {},
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Heading(text: "Title"),
                  Subtitle(text: "description"),
                ],
              ),
            ),
          ],
        ),
        // Container(color: Colors.amber, height: 10, width: 10),
        IconContainer(
          icon: Icon(Icons.add_rounded),
          onTap: () {},
        ),
        // Container(color: Colors.amber, height: 10, width: 10),
      ],
    );
  }
}

class IconContainer extends StatelessWidget {
  const IconContainer({
    super.key,
    required this.icon,
    required this.onTap,
  });

  final Icon icon;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Colors.grey[350],
        ),
        child: icon,
      ),
    );
  }
}

class MyHeatMap extends StatelessWidget {
  MyHeatMap({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[400],
      child: HeatMap(
        scrollable: true,
        endDate: DateTime.now(),
        datasets: {
          DateTime(2024, 03, 01): 1,
          DateTime(2024, 03, 02): 2,
          DateTime(2024, 03, 03): 3,
          DateTime(2024, 03, 04): 4,
          DateTime(2024, 03, 05): 5,
        },
        defaultColor: Colors.grey,
        colorsets: {0: Colors.red},
        // colorTipSize: 0,
        size: 10,
        showText: false,
        borderRadius: 2,
        showColorTip: false,
        
      ),
    );
  }
}
