import 'package:flutter/material.dart';

class ShopCustom extends StatelessWidget {
  const ShopCustom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          children: [
            ListTile(
                onTap: () {},
                title: const Text(
                  'Duy Bình Shop',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                ),
                subtitle: const Text('1Tr người theo dõi'),
                tileColor: Colors.grey.withOpacity(0.15),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                leading: ClipOval(
                  child: CircleAvatar(
                    radius: 25,
                    child: Image.network(
                        'https://static-images.vnncdn.net/files/publish/2022/9/3/bien-vo-cuc-thai-binh-346.jpeg'),
                  ),
                ),
                trailing: GestureDetector(
                  onTap: () {},
                  child: SizedBox(
                    height: 30,
                    width: 30,
                    child: Image.network(
                        'https://cdn-icons-png.flaticon.com/128/3683/3683218.png'),
                  ),
                )),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
